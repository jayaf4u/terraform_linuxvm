resource "azurerm_resource_group" "main" {
    name        = var.resource_group
    location    = var.location 
}

resource "azurerm_network_security_group" "main" {
    resource_group_name     = azurerm_resource_group.main.name
    location                = azurerm_resource_group.main.location
    name                    = var.tfnsg 
}

resource "azurerm_virtual_network" "main" {
    name                    = var.Vnet_Name
    resource_group_name     = azurerm_resource_group.main.name
    location                = azurerm_resource_group.main.location
    address_space           = [var.Vnet_address_space]
    
}

resource "azurerm_subnet" "main" {
    name                    = var.subnet_name
    resource_group_name     = azurerm_resource_group.main.name
    virtual_network_name    = azurerm_virtual_network.main.name
    address_prefixes        = [var.address_prefix]
}

resource "azurerm_public_ip" "main" {
    name                    = var.public_Ip
    allocation_method       = "Dynamic"
    ip_version              = "IPv4"
    sku                     = "Basic"
    resource_group_name     = azurerm_resource_group.main.name
    location                = azurerm_resource_group.main.location
}

resource "azurerm_network_interface" "main" {
    name                    = var.Network_Interface_Name
    resource_group_name     = azurerm_resource_group.main.name
    location                = azurerm_resource_group.main.location

    ip_configuration {
        name                          = "ipconfig1"
        subnet_id                     = azurerm_subnet.main.id
        public_ip_address_id          = azurerm_public_ip.main.id
        private_ip_address_allocation = "Dynamic"
    
    }
}

resource "azurerm_network_interface_security_group_association" "main" {
    network_interface_id        = azurerm_network_interface.main.id
    network_security_group_id   = azurerm_network_security_group.main.id 
}




resource "azurerm_linux_virtual_machine" "main" {
    name                            = var.VM_NAME
    admin_username                  = var.admin_user
    admin_password                  = var.admin_password
    resource_group_name             = azurerm_resource_group.main.name
    location                        = azurerm_resource_group.main.location
    size                            = var.VM_SKU 
    network_interface_ids           = [ azurerm_network_interface.main.id]
    disable_password_authentication = false
    
    os_disk {
        caching                 = "ReadWrite"
        disk_size_gb            = var.OS_Disk_Size_in_GB
        storage_account_type    = "Standard_LRS" 
    }
    source_image_reference {
        publisher   = var.image_publisher
        offer       = var.image_offer
        sku         = var.image_sku
        version     = var.image_version 
    }

}

