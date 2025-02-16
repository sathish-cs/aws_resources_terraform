variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
  default = "ami-07eef52105e8a2059" # Ubuntu AMI
  
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default     = "t2.medium"
}