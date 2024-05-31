#Resource for managed Identity
resource "azurerm_user_assigned_identity" "this_manageidentity" {
  location            = azurerm_resource_group.this_rg.location
  name                = "user-assigned-identity"
  resource_group_name = azurerm_resource_group.this_rg.name
}