terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = var.version1
    }
  }
}


provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion     = true
      graceful_shutdown              = false
      skip_shutdown_and_force_delete = false
    }
  }
}

#Create a resource group
resource "azurerm_resource_group" "myrg" {
  name     = var.resource_group["name"]
  location = var.resource_group["location"]
}

#create a virtual network in the above resource group
resource "azurerm_virtual_network" "myvn" {
  name                = var.vn_name
  resource_group_name = azurerm_resource_group.myrg.name
  location            = var.location_for_others
  address_space       = var.virtualnet 
}

resource "azurerm_subnet" "mysb" {
  name                 = var.mysubnet
  address_prefixes     = var.subnet
  resource_group_name  = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvn.name
}

resource "azurerm_network_interface" "mynic" {
  name                = var.nic
  location            = var.location_for_others
  resource_group_name = azurerm_resource_group.myrg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysb.id
    private_ip_address_allocation = "Dynamic"
  }
}

#The linux virtual machine config
resource "azurerm_linux_virtual_machine" "myvm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.myrg.name
  location            = var.location_for_others
  size                = var.vm_size
  admin_username      = var.username
  network_interface_ids = [
    azurerm_network_interface.mynic.id,
  ]

  admin_ssh_key {
    username = var.username
    public_key = file(var.publickeyfile)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.os_image[0]
    offer     = var.os_image[1]
    sku       = var.os_image[2]
    version   = var.os_image[3]
  }
}