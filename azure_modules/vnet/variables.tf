variable "prefix" {
  description = "The prefix to use for resource naming"
  type        = string
}

variable "location" {
  description = "The location where the virtual network will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network"
  type        = string
}

variable "network_address_space" {
  description = "The address space of the virtual network"
  type        = string
}

variable "container_subnet_address_prefix" {
  description = "The address prefix of the container subnet"
  type        = string
}

variable "appgw_subnet_address_prefix" {
  description = "The address prefix of the application gateway subnet"
  type        = string
}

variable "storage_subnet_address_prefix" {
  description = "The address prefix of the storage subnet"
  type        = string
}

variable "environment" {
  description = "The environment tag for the virtual network"
  type        = string
}

variable "tags" {
  description = "Additional tags for the virtual network"
  type        = map(string)
  default     = {}
}