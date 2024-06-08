resource "azurerm_subnet" "this_db_subnet" {
  name                 = var.db_subnet
  resource_group_name  = azurerm_resource_group.this_rg.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = ["10.0.9.0/24"]
  #delegation {
   # name = "myDelegation"
    #service_delegation {
    #  name = "Microsoft.DBforMySQL/flexibleServers"
    #  actions = [
     #   "Microsoft.Network/virtualNetworks/subnets/join/action",
     # ]
    #}
  #}
  depends_on = [ azurerm_virtual_network.this_vnet ]
}
resource "azurerm_network_security_group" "this_db_nsg" {
  name                = var.nsg_db_name
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
  depends_on = [ azurerm_subnet.this_db_subnet ]
}
resource "azurerm_network_security_rule" "this_db_server_inbound_rule" {
  name                        = "inboundfromvm"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = azurerm_network_interface.this_network_interface.private_ip_address
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.this_rg.name
  network_security_group_name = azurerm_network_security_group.this_db_nsg.name
  depends_on = [ azurerm_subnet.this_db_subnet ]
}
resource "azurerm_network_interface_security_group_association" "this_db_network_interface_security_group" {
  network_interface_id      = azurerm_network_interface.this_network_interface.id
  network_security_group_id = azurerm_network_security_group.this_db_nsg.id
  depends_on = [ azurerm_subnet.this_db_subnet ]
}
resource "azurerm_private_endpoint" "this_db_private_endpoint" {
  name                = "db-private-endpoint"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
  subnet_id           = azurerm_subnet.this_db_subnet.id  
  private_service_connection {
    name                           = "this-privateserviceconnection"
    private_connection_resource_id = azurerm_mysql_flexible_server.this_mysql_flexible_server.id
    is_manual_connection           = false
    subresource_names              = ["mysqlServer"]
  }  
  private_dns_zone_group {
    name                 = "mysqldns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.this_private_dns.id]
  }
    depends_on = [ azurerm_private_dns_zone.this_private_dns ]
}
resource "azurerm_private_dns_zone" "this_private_dns" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.this_rg.name
  depends_on = [ azurerm_resource_group.this_rg ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "this_private_dns_zone_virtual_network_link" {
  name                  = "this-db-private-dns-virtual-network"
  resource_group_name   = azurerm_resource_group.this_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.this_private_dns.name
  virtual_network_id    = azurerm_virtual_network.this_vnet.id
  depends_on = [ azurerm_private_dns_zone.this_private_dns ]
}
