resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "plan" {
  name                = "zero-linux-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "secureflaskapp54321"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }

  app_settings = {
    WEBSITES_PORT = "8000"
  }
}

resource "azurerm_postgresql_flexible_server" "pg" {
  name                = "zerotrustpg54321"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  administrator_login    = "pgadmin"
  administrator_password = var.db_password

  version    = "14"
  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768
}