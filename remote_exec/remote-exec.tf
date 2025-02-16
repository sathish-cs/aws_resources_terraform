# This file is used to create an EC2 instance and install packages on it using Terraform

# Create a private key
resource "tls_private_key" "devops" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create a key pair for the EC2 instance
resource "aws_key_pair" "devops_key" {
  key_name   = "oaf"
  public_key = tls_private_key.devops.public_key_openssh
}


# Create an EC2 instance
resource "aws_instance" "devops" {
  ami           = var.ami 
  instance_type = var.instance_type
  key_name      =  aws_key_pair.devops_key.key_name
  subnet_id     = var.subnet_id
  tags = {
    Name = "DevOps"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu" #Change user as per your AMI
    private_key = tls_private_key.devops.private_key_pem
    host        = self.private_ip
  }

  provisioner "file" {
    source      = "./packages.sh"
    destination = "/tmp/packages.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/packages.sh",
      "/tmp/packages.sh"
    ]
  }
}


output "private_key" {
  value     = tls_private_key.devops.private_key_pem
  sensitive = true
}