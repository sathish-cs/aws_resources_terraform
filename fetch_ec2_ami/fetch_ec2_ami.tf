data "aws_ami" "amazon_ami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]

  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_ami.image_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name = var.key_name
  count = 2
    tags = {
        Name = "webserver-${count.index}"
    }
}