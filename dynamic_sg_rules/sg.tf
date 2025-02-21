resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Security group for WebApp"
  vpc_id      = var.vpc
  tags = {
    Name        = "web-sg"
    environment = "dev"
  }


  dynamic "ingress" {
    for_each = var.sg_inbound_rules # Create a dynamic block for each rule in the list
    content {
      from_port       = ingress.value.port # Get the port number from the rule
      to_port         = ingress.value.port
      protocol        = "tcp"
      cidr_blocks     = ingress.value.range == "cidr" ? [ingress.value.target] : []
      security_groups = ingress.value.range == "sg" ? [ingress.value.target] : []
    }
  }
}