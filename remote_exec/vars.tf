variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
  default = "ami-07eef52105e8a2059" # Ubuntu AMI
  
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
  default = "subnet-0c2b3adq22fhs3" # Replace with your subnet ID
  
}
variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default     = "t2.medium"
}