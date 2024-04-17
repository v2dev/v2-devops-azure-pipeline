variable "prefix" {
  description = "Prefix to be used in resource names"
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
}

variable "resource_group_name" {
  description = "A container that holds related resources for an Azure solution"
}

variable "location" {
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
}

variable "container_apps" {
  type = list(object({
    name          = string
    tags          = optional(map(string))
    revision_mode = string

    template = object({
      containers = set(object({
        name    = string
        image   = string
        cpu     = string
        memory  = string
      }))
      max_replicas    = optional(number)
      min_replicas    = optional(number)
      revision_suffix = optional(string)
    })

    ingress = optional(object({
      allow_insecure_connections = optional(bool, false)
      external_enabled           = optional(bool, false)
      target_port                = number
      transport                  = optional(string)
      traffic_weight = object({
        label           = optional(string)
        latest_revision = optional(string)
        revision_suffix = optional(string)
        percentage      = number
      })
    }))
  }))
}



variable "container_app_subnet" {
  description = "The subnet ID for the Container Apps environment"
}

variable "container_registry_login_server" {
  description = "The login server of the Container Registry"
}

variable "container_registry_id" {
  description = "The ID of the Container Registry"
}

variable "container_env_name" {
  description = "Name of the Container Environment"
  default     = "containerenv"
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace"
  default     = "analyticsworkspace"
}

variable "sku" {
  description = "SKU for the Log Analytics Workspace"
  default     = "PerGB2018"
}
