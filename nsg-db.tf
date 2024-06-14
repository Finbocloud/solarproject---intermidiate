#Network security Group for database
resource "azurerm_subnet" "this_nsgdb_subnet" {
  name                 = "${local.owner}-${var.nsg_db_subnet}-${local.environment}"
  resource_group_name  = azurerm_resource_group.this_rg.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = ["10.0.4.0/24"]
}
resource "azurerm_network_security_group" "this_db_nsg" {
  name                = "${local.owner}-${var.db_nsg}-${local.environment}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
}

resource "azurerm_network_security_rule" "this_db_nsrule" {
  name                        = "${local.owner}-${var.db_nsrule}-${local.environment}"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = azurerm_network_interface.this_vm_nic.private_ip_address
  #The line 22 configures the IP address for our vm alone
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = azurerm_resource_group.this_rg.name
  network_security_group_name = azurerm_network_security_group.this_db_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "this_network_security_group_db_association" {
  subnet_id                 = azurerm_subnet.this_nsgdb_subnet.id
  network_security_group_id = azurerm_network_security_group.this_db_nsg.id
}