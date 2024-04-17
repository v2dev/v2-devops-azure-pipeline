variable "prefix" {
  description = "The prefix to use for resource naming"
  type        = string
}

variable "environment" {
  description = "The environment (dev, stage, prod)"
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "offer_type" {
  description = "The offer type for the Cosmos DB account"
  type        = string
  default     = "Standard"
}

variable "kind" {
  description = "The kind of Cosmos DB account to create"
  type        = string
  default     = "GlobalDocumentDB"
}

variable "enable_automatic_failover" {
  description = "Whether to enable automatic failover for the Cosmos DB account"
  type        = bool
  default     = false
}

variable "capabilities" {
  description = "The capabilities to enable for the Cosmos DB account"
  type        = string
  default     = "EnableServerless"
}

variable "consistency_level" {
  description = "The consistency level for the Cosmos DB account"
  type        = string
  default     = "Session"
}

variable "max_interval_in_seconds" {
  description = "The maximum interval in seconds for the consistency policy"
  type        = number
  default     = 10
}

variable "max_staleness_prefix" {
  description = "The maximum staleness prefix for the consistency policy"
  type        = number
  default     = 200
}

variable "failover_priority" {
  description = "The failover priority for the Cosmos DB account"
  type        = number
  default     = 0
}

variable "tags" {
  description = "The tags to apply to the resources"
  type        = map(string)
  default     = {}
}