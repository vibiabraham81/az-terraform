provider "azurerm" {
    version = 1.38
    }
resource "azurerm_storage_account" "lab" {
  name                     = "vibistorage5312020"
  resource_group_name      = "156-820806-deploy-an-azure-storage-account-with-te"
  location                 = "East US"
  account_tier            = "Standard"
  account_replication_type = "LRS"

   tags = {
    environment = "Terraform Storage"
    CreatedBy = "Admin"
      }
  }
