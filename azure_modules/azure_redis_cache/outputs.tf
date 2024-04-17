output "redis_cache_id" {
  description = "The ID of the Redis Cache"
  value       = azurerm_redis_cache.rediscache.id
}

output "redis_cache_hostname" {
  description = "The hostname of the Redis Cache"
  value       = azurerm_redis_cache.rediscache.hostname
}

output "redis_cache_ssl_port" {
  description = "The SSL port of the Redis Cache"
  value       = azurerm_redis_cache.rediscache.ssl_port
}

output "redis_cache_primary_access_key" {
  description = "The primary access key of the Redis Cache"
  value       = azurerm_redis_cache.rediscache.primary_access_key
  sensitive   = true
}