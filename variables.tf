variable "environment" {
  description = "Name of the environment; will be prefixed to all resources"
  type        = "string"
}

variable "project" {
  type        = "string"
  description = "Name of the project."
}

variable "vpc_id" {
  description = "EFS is created in this VPC"
  type        = "string"
}

variable "subnet_ids" {
  description = "The created EFS will be available in these subnet ids"
  type        = "list"
}

variable "encrypted" {
  description = "Encrypt file system."
  default     = true
}

variable "mount_location" {
  description = "Used to create a cloud init config part for amazon linux instances."
  type        = "string"
  default     = "/efs"
}

variable "performance_mode" {
  description = "maxIO"
  default     = "generalPurpose"
}

variable "subnet_count" {
  type = "string"
}

variable "creation_token" {
  type    = "string"
  default = ""
}

variable "tags" {
  type        = "map"
  description = "A map of tags to add to the resources"
  default     = {}
}
