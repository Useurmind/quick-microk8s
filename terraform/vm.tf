resource "azurerm_public_ip" "microk8s" {
  name                = "microk8s-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = local.common_tags
}

resource "azurerm_network_interface" "microk8s" {
  name                = "microk8s-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "public"
    public_ip_address_id = azurerm_public_ip.microk8s.id
    subnet_id                     = azurerm_subnet.sub.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = local.common_tags
}

resource "azurerm_linux_virtual_machine" "microk8s" {
  name                = "microk8s-server"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_D2as_v4"
  admin_username      = var.admin_username

#   availability_set_id = azurerm_availability_set._1.id

  network_interface_ids = [
    azurerm_network_interface.microk8s.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_pub_key)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
  
  tags = local.common_tags
}

output host_ip {
    value = azurerm_public_ip.microk8s.ip_address
}