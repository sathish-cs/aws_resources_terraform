variable "sg_inbound_rules" {
  type = list(object({
    port   = number
    range  = string
    target = string
  }))
  default = [
    { port = 80, range = "cidr", target = "0.0.0.0/0" }, # Allow all traffic on port 80 from any IP address
    { port = 443, range = "cidr", target = "0.0.0.0/0" },
    { port = 22, range = "sg", target = "sg-0958a82ff" } # Allow SSH traffic from the specified security group
  ]
}

variable "vpc" {
  description = "The ID of the VPC"
  type        = string
  default     = "vpc-22a106fc7" # Replace with your VPC ID

}