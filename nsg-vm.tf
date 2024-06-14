#Network security Group for database
resource "azurerm_subnet" "this_vmnsg_subnet" {
  name                 = "${local.owner}-${var.vm_nsg_subnet}-${local.environment}"
  resource_group_name  = azurerm_resource_group.this_rg.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = ["10.0.11.0/24"]
}
resource "azurerm_network_security_group" "this_vm_nsg" {
  name                = "${local.owner}-${var.vm_nsg}-${local.environment}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
}

resource "azurerm_network_security_rule" "this_vm_nsrule" {
  name                        = "${local.owner}-${var.vm_nsrule}-${local.environment}"
  priority                    = 100
  direction                   = "inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "virtualnetwork"
  resource_group_name         = azurerm_resource_group.this_rg.name
  network_security_group_name = azurerm_network_security_group.this_vm_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "this_network_security_group_db_association" {
  subnet_id                 = azurerm_subnet.this_nsgdb_subnet.id
  network_security_group_id = azurerm_network_security_group.this_db_nsg.id
}