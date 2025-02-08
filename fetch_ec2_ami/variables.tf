variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in"
  type        = string
  default     = "subnet-1325376c8ed5df" # Change this to your subnet ID
}

variable "instance_type" {
  description = "The type of instance to launch"
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = "web" # Change this to your key name
}