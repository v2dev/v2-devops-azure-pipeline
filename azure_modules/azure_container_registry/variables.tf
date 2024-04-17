variable "prefix" {
  description = "Prefix to be used in resource names"
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
}

variable "container_registry_name" {
  description = "Name of the Container Registry (without prefix, environment, or special characters)"
  default     = "containerregistry"
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
}

variable "sku" {
  description = "SKU of the Container Registry"
  default     = "Premium"
}

variable "container_registry_user_assigned_identity_name" {
  description = "Name of the user-assigned identity for the Container Registry"
  default     = "containerregistryuserassignedidentity"
}