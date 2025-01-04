variable "ami_id" {
description = "The ID of the AMI to run."
type = string
}
variable "name" {
description = "The base name for the instance and all other resources"
type = string
}
variable "instance_count" {
  description = "Number of instances to deploy"
  type        = number
  default     = 1
}
