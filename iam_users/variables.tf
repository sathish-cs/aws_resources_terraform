variable "policy_arn" {
  description = "The ARN of the role to assume"
  type        = string
  default     = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}