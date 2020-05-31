provider "azurerm" {
    version = 1.38
    }
resource "azurerm_storage_account" "lab" {
  name                     = "storageforterraformlabs"
  resource_group_name      = "156-0337f8-deploy-an-azure-storage-account-with-te"
  location                 = "East US"
  account_tier            = "Standard"
  account_replication_type = "LRS"

   tags = {
    environment = "Terraform Storages"
    CreatedBy = "Admins"
      }
  }