resource "azurerm_redis_cache" "rediscache" {
  name                = "${var.prefix}-redis-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = 0
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  tags = var.tags
}