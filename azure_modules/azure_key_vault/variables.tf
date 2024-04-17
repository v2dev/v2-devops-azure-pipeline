variable "key_vault_name"{
	description = "key_vault_name"
	type = string
}

variable "region" { 
	description = "region"
	type = string
	default = "East US"
}

variable "resource_group_name" { 
	description = "resource group name"
	type = string
}

variable "sku_name" { 
	description = "sku name"
	type = string
    default = "standard"
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. If this value isn't null (the default), 'data.azurerm_client_config.current.object_id' will be set to this value."
  default     = null
}

variable "key_permissions" {
  type        = list(string)
  description = "List of key permissions."
  default     = ["List", "Create", "Delete", "Get", "Purge", "Recover", "Update", "GetRotationPolicy", "SetRotationPolicy"]
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default     = ["Set", "Get", "Delete", "Purge", "Recover"]
}

variable "container_app_url" { 
	description = "container_app_url"
	type = string
}

variable "app_url" { 
	description = "app_url"
	type = string
}