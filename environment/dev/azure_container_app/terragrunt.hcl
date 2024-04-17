terraform {
  source = "../../../azure_modules//azure_container_app"
}

include {
  path = find_in_parent_folders()
}

dependency "resourcegroup" {
  config_path = "../resourcegroup"
  mock_outputs = {
    resource_name = "mockOutput"
  }
}

dependency "resourcegroup" {
  config_path = "../resourcegroup"
  mock_outputs = {
    location = "mockOutput"
  }
}


dependency "vnet" {
  config_path = "../vnet"
  mock_outputs = {
    container_app_subnet = "mockOutput"
  }
}

dependency "azure_container_registry" {
  config_path = "../azure_container_registry"
  mock_outputs = {
    login_server = "mockOutput"
    container_registry_id = "mockOutput"
  }
}

include "env_vars" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  prefix = include.env_vars.locals.prefix
  environment = include.env_vars.locals.environment
  location                   = dependency.resourcegroup.outputs.location
  resource_group_name        = dependency.resourcegroup.outputs.resource_name
  container_app_subnet       = dependency.vnet.outputs.container_app_subnet
  container_registry_login_server = dependency.azure_container_registry.outputs.login_server
  container_registry_id      = dependency.azure_container_registry.outputs.container_registry_id
  container_env_name         = "containerenv"
  log_analytics_workspace_name = "analyticsworkspace"
  sku                        = "PerGB2018"
  # default_image = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
  container_apps = [
    {
      name          = "five9eventforwarder"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "five9eventforwarder"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 3
        min_replicas    = 1
      } 
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 3000
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    },
    {
      name          = "conversa"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "conversa"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 5
        min_replicas    = 1
      }
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 3000
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    },
    {
      name          = "dbrunner"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "dbrunner"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 5
        min_replicas    = 1
      }
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 3000
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    },
    {
      name          = "callmindui"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "callmindui"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 5
        min_replicas    = 1
      }
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 3000
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    },
    {
      name          = "sarunner"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "sarunner"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 5
        min_replicas    = 1
      }
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 3000
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    },
    {
      name          = "speechrunner"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "speechrunner"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 5
        min_replicas    = 2
      }
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 3000
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    },
    {
      name          = "callmindvoice"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "callmindvoice"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 5
        min_replicas    = 2
      }
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 50051
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    },

    {
      name          = "customerui"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "customerui"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 5
        min_replicas    = 1
      }
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 3000
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    },

    {
      name          = "callmindadmin"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "callmindadmin"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 5
        min_replicas    = 1
      }
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 3000
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    },

    {
      name          = "customerapi"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "customerapi"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 1
        min_replicas    = 1
      }
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 3000
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    },

    {
      name          = "adminui"
      revision_mode = "Single"
      template = {
        containers = [
          {
            name   = "adminui"
            image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
            cpu    = "0.5"
            memory = "1Gi"
          }
        ]
        max_replicas    = 2
        min_replicas    = 1
      }
      ingress = {
        allow_insecure_connections = true
        external_enabled           = true
        target_port                = 3000
        transport                  = "HTTP"
        traffic_weight = {
          latest_revision = true
          percentage      = 100
        }
      }
    }
  ]
}
