output "openai_id" {
  description = "The ID of the Cognitive Service Account"
  value       = azurerm_cognitive_account.openai.id
}

output "openai_endpoint" {
  description = "The endpoint of the Cognitive Service Account"
  value       = azurerm_cognitive_account.openai.endpoint
}