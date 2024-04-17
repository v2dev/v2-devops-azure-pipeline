resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "${var.prefix}-${var.environment}cosmosdb"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = var.offer_type
  kind                = var.kind
  enable_automatic_failover = var.enable_automatic_failover

  capabilities {
    name = var.capabilities
  }

  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = var.max_interval_in_seconds
    max_staleness_prefix    = var.max_staleness_prefix
  }

  geo_location {
    location          = var.location
    failover_priority = var.failover_priority
  }

  tags = var.tags
}