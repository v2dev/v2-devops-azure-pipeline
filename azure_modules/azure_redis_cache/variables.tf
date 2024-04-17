variable "prefix" {
  description = "The prefix to use for resource naming"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be created"
  type        = string
}

variable "environment" {
  description = "The environment (dev, stage, prod)"
  type        = string
}

variable "tags" {
  description = "The tags to apply to the resources"
  type        = map(string)
  default     = {}
}