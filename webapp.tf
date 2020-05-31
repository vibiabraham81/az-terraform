provider "azurerm" {
    version = 1.38
    }

resource "azurerm_app_service_plan" "svcplan" {
  name                = "web-new-app"
  location            = "eastus"
  resource_group_name = "191-57b829-deploy-a-web-application-with-terraform"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "web-new-app"
  location            = "eastus"
  resource_group_name = "191-57b829-deploy-a-web-application-with-terraform"
  app_service_plan_id = azurerm_app_service_plan.svcplan.id


  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}