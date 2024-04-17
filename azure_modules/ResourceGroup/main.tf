resource "azurerm_resource_group" "resource_group" {
  name        = "${var.prefix}rg${var.environment}"
  location    = var.location
  tags        = var.tags
}