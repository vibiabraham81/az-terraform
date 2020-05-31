provider "azurerm" {
    version = 1.38
    }

# Create virtual network
resource "azurerm_virtual_network" "TFNet" {
    name                = "TFVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "East US"
    resource_group_name = "187-275658-deploying-an-azure-vm-with-terraform-nm"

    tags = {
        environment = "Terraform VNET"
    }
}
# Create subnet
resource "azurerm_subnet" "tfsubnet" {
    name                 = "default"
    resource_group_name = "187-275658-deploying-an-azure-vm-with-terraform-nm"
    virtual_network_name = azurerm_virtual_network.TFNet.name
    address_prefix       = "10.0.1.0/24"
}