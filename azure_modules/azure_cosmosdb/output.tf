output "cosmosdb_endpoint" {
  description = "The endpoint URL of the Cosmos DB account"
  value       = azurerm_cosmosdb_account.cosmosdb.endpoint
}

output "cosmosdb_id" {
  description = "The ID of the Cosmos DB account"
  value       = azurerm_cosmosdb_account.cosmosdb.id
}

output "cosmosdb_primary_master_key" {
  description = "The primary master key of the Cosmos DB account"
  value       = azurerm_cosmosdb_account.cosmosdb.primary_key
  sensitive   = true
}

output "cosmosdb_connection_strings" {
  description = "A list of connection strings available for the Cosmos DB account"
  value       = azurerm_cosmosdb_account.cosmosdb.connection_strings
  sensitive   = true
}