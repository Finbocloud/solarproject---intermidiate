resource "azurerm_subnet" "this_db_subnet" {
  name                 = "${local.owner}-${var.db_subnet}-${local.environment}"
  resource_group_name  = azurerm_resource_group.this_rg.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = ["10.0.9.0/24"]

  #delegating a datebase server to a particular subnet will make the subnet be used for only that server
  /* delegation {
   name = "myDelegation"
   service_delegation {
    name = "Microsoft.DBforMySQL/flexibleServers"
    actions = [
     "Microsoft.Network/virtualNetworks/subnets/join/action",
   ] 
  }
  }*/
  depends_on = [azurerm_virtual_network.this_vnet]
}
/*resource "azurerm_network_security_group" "this_db_nsg" {
  name                = var.db_nsg
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
  depends_on          = [azurerm_subnet.this_db_subnet]
}
resource "azurerm_network_security_rule" "this_db_server_inbound_rule" {
  name                        = "inboundfromvm"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = azurerm_network_interface.this_nic.private_ip_address
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.this_rg.name
  network_security_group_name = azurerm_network_security_group.this_db_nsg.name
  depends_on                  = [azurerm_subnet.this_db_subnet]
}
resource "azurerm_network_interface_security_group_association" "this_db_network_interface_security_group" {
  network_interface_id      = azurerm_network_interface.this_nic.id
  network_security_group_id = azurerm_network_security_group.this_db_nsg.id
  depends_on                = [azurerm_subnet.this_db_subnet]
}*/
resource "azurerm_private_endpoint" "this_db_private_endpoint" {
  name                = var.db_private_endpoint
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
  subnet_id           = azurerm_subnet.this_db_subnet.id
  private_service_connection {
    name                           = var.db_private_service_connection
    private_connection_resource_id = azurerm_mysql_flexible_server.this_mysql_flexible_server.id
    is_manual_connection           = false
    subresource_names              = ["mysqlServer"]
  }
  private_dns_zone_group {
    name                 = var.db_private_dns_group
    private_dns_zone_ids = [azurerm_private_dns_zone.this_db_private_dns.id]
  }
  depends_on = [azurerm_private_dns_zone.this_db_private_dns]
}
resource "azurerm_private_dns_zone" "this_db_private_dns" {
  name                = var.db_private_dns_zone
  resource_group_name = azurerm_resource_group.this_rg.name
  depends_on          = [azurerm_resource_group.this_rg]
}
resource "azurerm_private_dns_zone_virtual_network_link" "this_db_net_private_dns_zone_virtual_network_link" {
  name                  = var.db_private_dns_vnet_link
  resource_group_name   = azurerm_resource_group.this_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.this_db_private_dns.name
  virtual_network_id    = azurerm_virtual_network.this_vnet.id
  depends_on            = [azurerm_private_dns_zone.this_db_private_dns]
}
