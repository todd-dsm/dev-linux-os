/*
            VARIABLES
*/
variable "image_name" {
  description = "The final AMI name."
  type        = string
}

variable "aws_region" {
  description = "The target AWS region."
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the builder instance."
  type        = string
}

variable "skip_create_ami" {
  description = "Toggle to skip the AMI creation; builds faster."
  default     = true
  type        = bool
}

variable "default_ami_user" {
  description = "The SSH username used to login to the AMI for configuration."
  type        = string
}

