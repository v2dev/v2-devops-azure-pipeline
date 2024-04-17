variable "prefix" {
  description = "The prefix to use for resource naming"
  type        = string
}

variable "environment" {
  description = "The environment (dev, stage, prod)"
  type        = string
}




variable "location" {
  description = "The location where the resource group will be created."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource group."
  type        = map(string)
  default     = {}
}
