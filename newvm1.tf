provider "azurerm" {
    version = 1.38
    }
# Refer vNet
data "azurerm_subnet" "tfsubnet" {
    name                = "mySubnet"
    virtual_network_name = "myVnet"
    resource_group_name = "187-0029ba-deploying-an-azure-vm-with-terraform-nm"
}
#Deploy Public IP
resource "azurerm_public_ip" "example" {
  name                = "pubip1"
  location            = "East US"
  resource_group_name = "187-0029ba-deploying-an-azure-vm-with-terraform-nm"
  allocation_method   = "Dynamic"
  sku                 = "Basic"
#Create NIC
resource "azurerm_network_interface" "example" {
  name                = "vNic"  
  location            = "East US"
  resource_group_name = "187-0029ba-deploying-an-azure-vm-with-terraform-nm"

    ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.tfsubnet.id 
    private_ip_address_allocation  = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}
#Create Boot Diagnostic Account
resource "azurerm_storage_account" "sa" {
  name                     = "bootdiagtodaymay232020" 
  resource_group_name      = "187-0029ba-deploying-an-azure-vm-with-terraform-nm"
  location                 = "East US"
   account_tier            = "Standard"
   account_replication_type = "LRS"

   tags = {
    environment = "Boot Diagnostic Storage"
    CreatedBy = "Admin"
   }
  }
#Create Virtual Machine
resource "azurerm_virtual_machine" "example" {
  name                  = "my-VM"  
  location              = "East US"
  resource_group_name   = "187-0029ba-deploying-an-azure-vm-with-terraform-nm"
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = "Standard_B1s"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk1"
    disk_size_gb      = "128"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "my-VM"
    admin_username = "vmadmin"
    admin_password = "Password12345!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

boot_diagnostics {
        enabled     = "true"
        storage_uri = azurerm_storage_account.sa.primary_blob_endpoint
    }
}