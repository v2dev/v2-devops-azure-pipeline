resource "azurerm_log_analytics_workspace" "analytics_workspace" {
  name                = "${var.prefix}-${var.environment}analyticsworkspace"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "container_app_environment" {
  name                        = "${var.prefix}-${var.environment}conenv"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  log_analytics_workspace_id  = azurerm_log_analytics_workspace.analytics_workspace.id
  infrastructure_subnet_id    = var.container_app_subnet
  # internal_load_balancer_enabled = true

  timeouts {
    create = "3h"
    delete = "3h"
  }
}

resource "azurerm_container_app" "container_app" {
  for_each                  = { for app in var.container_apps : app.name => app }
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  name                       = each.key
  resource_group_name        = var.resource_group_name
  revision_mode              = each.value.revision_mode
  tags                       = each.value.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.containerapp.id]
  }

  registry {
    server   = var.container_registry_login_server
    identity = azurerm_user_assigned_identity.containerapp.id
  }

  template {
    max_replicas   = each.value.template.max_replicas
    min_replicas   = each.value.template.min_replicas
    revision_suffix = each.value.template.revision_suffix

    dynamic "container" {
      for_each = each.value.template.containers
      content {
        cpu   = container.value.cpu
        image = container.value.image
        memory = container.value.memory
        name  = container.value.name
      }
    }
  }

lifecycle {
    ignore_changes = [
      template[0].container[0].image,
      template[0].container[1].image,
      template[0].container[2].image,
      template[0].container[3].image,
      template[0].container[4].image,
      template[0].container[5].image,
      template[0].container[6].image,
      template[0].container[7].image,
      template[0].container[8].image,
      template[0].container[9].image,
      template[0].container[10].image,
    ]
  }

  dynamic "ingress" {
    for_each = each.value.ingress == null ? [] : [each.value.ingress]
    content {
      target_port                = ingress.value.target_port
      allow_insecure_connections = ingress.value.allow_insecure_connections
      external_enabled           = ingress.value.external_enabled

      dynamic "traffic_weight" {
        for_each = ingress.value.traffic_weight == null ? [] : [ingress.value.traffic_weight]
        content {
          percentage     = traffic_weight.value.percentage
          latest_revision = traffic_weight.value.latest_revision
        }
      }
    }
  }
}

resource "azurerm_user_assigned_identity" "containerapp" {
  location            = var.location
  name                = "${var.prefix}-${var.environment}-containerappuserassignedidentity"
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "containerapp" {
  scope              = var.container_registry_id
  role_definition_name = "acrpull"
  principal_id       = azurerm_user_assigned_identity.containerapp.principal_id
  depends_on         = [azurerm_user_assigned_identity.containerapp]
}

