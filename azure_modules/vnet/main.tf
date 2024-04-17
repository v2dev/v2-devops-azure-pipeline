# Create a virtual network
resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.prefix}-${var.environment}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.network_address_space]
  
  tags = merge(
    {
      Environment = var.environment
    },
    var.tags
  )
}

# Create a subnet for container apps
resource "azurerm_subnet" "container_app_subnet" {
  name                 = "${var.prefix}-${var.environment}-container-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.container_subnet_address_prefix]
}

# Create a subnet for the application gateway
resource "azurerm_subnet" "app_gw_subnet" {
  name                 = "${var.prefix}-${var.environment}-appgw-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.appgw_subnet_address_prefix]
}

# Create a subnet for storage
resource "azurerm_subnet" "storage_subnet" {
  name                 = "${var.prefix}-${var.environment}-storage-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.storage_subnet_address_prefix]
}