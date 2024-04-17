resource "azurerm_cognitive_account" "openai" {
  name                  = "${var.prefix}-openai-${var.environment}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  kind                  = "OpenAI"
  sku_name              = "S0"
  custom_subdomain_name = "${var.prefix}openaisubdomain${var.environment}"

  tags = var.tags
}

resource "azurerm_cognitive_deployment" "deploy_model" {
  name                 = "${var.prefix}-openai-deployment-${var.environment}"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-4-32k"
    version = "0613"
  }

  scale {
    type = "Standard"
  }

}