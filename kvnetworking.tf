resource "azurerm_subnet" "this_kv_subnet" {
  name                 = "${local.owner}-${var.kv_subnet}-${local.environment}"
  resource_group_name  = azurerm_resource_group.this_rg.name
  virtual_network_name = azurerm_virtual_network.this_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}
resource "azurerm_private_endpoint" "this_private_endpoint" {
  name                = "${local.owner}-${var.kv_private_subnet}-${local.environment}"
  location            = azurerm_resource_group.this_rg.location
  resource_group_name = azurerm_resource_group.this_rg.name
  subnet_id           = azurerm_subnet.this_kv_subnet.id
  

  private_service_connection {
    name                           = "secure-privateserviceconnection"
    private_connection_resource_id = azurerm_key_vault.this_keyvault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
    #vault name is a conactant, do not change the name
    #for dbnetworking.tf , use the name ["MySqlServer"]
  }
  private_dns_zone_group {
    name                 = "mykvdnsgroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.this_kv_private_zone.id]
  }
}
resource "azurerm_private_dns_zone" "this_kv_private_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.this_rg.name
}
resource "azurerm_private_dns_zone_virtual_network_link" "this_kv_private_dns_zone_virtual_network_link" {
  name                  = "kv-dns-private-network-link"
  resource_group_name   = azurerm_resource_group.this_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.this_kv_private_zone.name
  virtual_network_id    = azurerm_virtual_network.this_vnet.id
}