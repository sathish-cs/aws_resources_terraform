locals {
  instances = 3 # Number of instances to launch
  subnets = var.subnet_ids
  ec2_instance = {
    for i in range(local.instances) : # Create a map of instances
    "webapp${i}" => { # Name each instance
      subnet_id = local.subnets[i % length(local.subnets)] # Create instances across subnets
    }
  }
}

resource "aws_instance" "webapp" {
  for_each      = local.ec2_instance # Create an instance for each item in the ec2_instance map
  ami           = var.ami # Replace with your desired AMI ID
  instance_type = var.instance_type
  subnet_id     = each.value.subnet_id # Use the subnet_id from the ec2_instance map
  key_name      = "oaf-test"    # Replace with your key pair name

  tags = {
    Name = each.key
  }
}


output "webapp_private_ips" {
  value = {
    for key, i in aws_instance.webapp : key => i.private_ip
  }
}