resource "azurerm_linux_virtual_machine" "vm-dev" {
    name = "terraform-vm"
    resource_group_name = azurerm_resource_group.rg-dev.name
    location = azurerm_resource_group.rg-dev.location
    size = "Standard_B1s"
    admin_username = "azureuser"
    network_interface_ids = [azurerm_network_interface.myNic-dev.id]
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        name                 = "terraform-osdisk"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts"
        version   = "latest"
    }
    admin_ssh_key {
        username = "azureuser"
        public_key = file("~/.ssh/id_rsa.pub")
    }
}