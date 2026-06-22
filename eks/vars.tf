variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "cluster_version" {
  type        = string
  description = "Cluster version"
  default     = "1.32"
}

variable "cluster_type" {
  type        = string
  description = "private/public cluster"
}

variable "subnet_ids" {
  type = list(string)
}

variable "node_groups" {
  type = map(object({
    instance_types = list(string)
    desired_size   = number
    min_size       = number
    max_size       = number
    capacity_type  = string
    disk_size      = number
    labels         = map(string)
  }))
}

variable "cluster_admins" {
  type = list(string)
}

variable "endpoint_private_access" {
  type    = bool
  default = true
}

variable "tags" {
  type = map(string)
}