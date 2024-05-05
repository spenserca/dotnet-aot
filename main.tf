terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.102.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

locals {
  location = "centralus"
}

resource "azurerm_resource_group" "aot_api" {
  name     = "aot-api"
  location = local.location
}

resource "azurerm_service_plan" "plan" {
  name                = "asp-aot-api"
  resource_group_name = azurerm_resource_group.aot_api.name
  location            = local.location

  os_type  = "Linux"
  sku_name = "P1v2"
}

resource "azurerm_linux_web_app" "api" {
  name                = "app-aot-api-01"
  resource_group_name = azurerm_resource_group.aot_api.name
  location            = local.location

  https_only      = true
  service_plan_id = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
  }
}