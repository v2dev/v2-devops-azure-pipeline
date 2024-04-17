resource "azurerm_application_insights" "example" {
  name                = "vtest-app-insights"
  resource_group_name = var.resource_group_name
  location            = var.location
  application_type    = "web"
}

resource "azurerm_signalr_service" "signalr_service" {
  name                = "${var.prefix}-signalr-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  
  sku {
    name     = "Premium_P1"
    capacity = 1
  }

  tags = var.tags
}

resource "azurerm_storage_account" "function_storage" {
  name                     = "${var.prefix}stfuncapp${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_app_service_plan" "function_app_plan" {
  name                = "${var.prefix}-function-app-plan-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = var.tags
}

resource "azurerm_function_app" "callmindui_function_app" {
  name                       = "${var.prefix}-CallmindUI-${var.environment}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = azurerm_app_service_plan.function_app_plan.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  version                    = "~4"

  app_settings = {  
  
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "AzureSignalRConnectionString" = azurerm_signalr_service.signalr_service.primary_connection_string
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.example.instrumentation_key
    "WEBSITE_NODE_DEFAULT_VERSION"= "~18"

  }

  tags = var.tags
}

resource "azurerm_function_app_function" "negotiate" {
  name            = "negotiate"
  function_app_id = azurerm_function_app.callmindui_function_app.id
  language        = "Javascript"
  config_json = jsonencode({
  "disabled": false,
  "bindings": [
    {
      "authLevel": "anonymous",
      "type": "httpTrigger",
      "direction": "in",
      "methods": [
        "post"
      ],
      "name": "req",
      "route": "negotiate"
    },
    {
      "type": "http",
      "direction": "out",
      "name": "res"
    },
    {
      "type": "signalRConnectionInfo",
      "name": "connectionInfo",
      "hubName": "default",
      "connectionStringSetting": "AzureSignalRConnectionString",
      "direction": "in"
    }
  ]
})

  file {
    name = "index.js"
    content = <<EOF
module.exports = async function (context, req, connectionInfo) {
    context.res.body = connectionInfo;
};
EOF
  }
}


resource "azurerm_function_app" "callminduidata_function_app" {
  name                       = "${var.prefix}-CallmindUIData-${var.environment}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = azurerm_app_service_plan.function_app_plan.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  version                    = "~4"

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "AzureSignalRConnectionString" = azurerm_signalr_service.signalr_service.primary_connection_string
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.example.instrumentation_key
    "WEBSITE_NODE_DEFAULT_VERSION"= "~18"

    
  }
  

  tags = var.tags
}

resource "azurerm_function_app_function" "broadcast" {
  name            = "broadcast"
  function_app_id = azurerm_function_app.callminduidata_function_app.id
  language        = "Javascript"
  config_json = jsonencode({
  "bindings": [
    {
      "authLevel": "anonymous",
      "type": "httpTrigger",
      "direction": "in",
      "name": "req",
      "methods": [
        "post"
      ]
    },
    {
      "type": "http",
      "name": "res",
      "direction": "out"
    },
    {
      "type": "signalR",
      "name": "signalRMessages",
      "hubName": "default",
      "connectionStringSetting": "AzureSignalRConnectionString",
      "direction": "out"
    }
  ]
})

  file {
    name = "index.js"
    content = <<EOF
module.exports = async function (context, req) {
    try {
      // Get the event data from the request body
      const eventData = req.body;
  
      // Broadcast the event to all clients
      context.bindings.signalRMessages = [{
        "target": "SendEventToClient",
        "arguments": [eventData]
      }];
  
      context.res = {
        status: 200,
        body: 'Event broadcasted successfully',
        headers: {
          'Content-Type': 'text/plain'
        }
      };
    } catch (error) {
      context.log.error('Error broadcasting event:', error);
      context.res = {
        status: 500,
        body: 'Error broadcasting event',
        headers: {
          'Content-Type': 'text/plain'
        }
      };
    }
  };
  
EOF
  }
}