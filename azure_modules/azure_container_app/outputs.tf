output "container_app_urls" {
  value = {
    for key, container_app in azurerm_container_app.container_app :
    key => container_app.latest_revision_fqdn
  }
}

output "static_ip" {

  value = azurerm_container_app_environment.container_app_environment.static_ip_address
  
}



output "app_urls" {
  value = {
    for key, container_app in azurerm_container_app.container_app :
    key => container_app.ingress[0].fqdn
  }
}

output "default_domain" {
  value = azurerm_container_app_environment.container_app_environment.default_domain
}



# output "app_url" {
#   value = azurerm_container_app.container_app[each.key].ingress[0].fqdn
# }