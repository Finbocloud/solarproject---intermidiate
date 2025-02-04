resource "azurerm_windows_virtual_machine" "this_winvm" {
  name                = "${local.owner}-${var.win_vm_name}-${local.environment}"
  resource_group_name = azurerm_resource_group.this_rg.name
  location            = azurerm_resource_group.this_rg.location
  size                = "Standard_F2"
  admin_username      = var.win_vm_username
  #value for password will be in the KV
  #and accessed only by managed identity resource
  admin_password = azurerm_key_vault_secret.this_vm_secret.value
  network_interface_ids = [
    azurerm_network_interface.this_vm_nic.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this_manageidentity.id]
  }
}
