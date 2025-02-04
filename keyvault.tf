#bad to put all current configuration
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "this_keyvault" {
  name                       = "${local.owner}-${var.key_vault}-${local.environment}"
  location                   = azurerm_resource_group.this_rg.location
  resource_group_name        = azurerm_resource_group.this_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7
  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = ["82.6.69.66"] #system IP
    virtual_network_subnet_ids = []
  }
}

resource "azurerm_key_vault_access_policy" "this_rasheed_access_policy" {
  key_vault_id = azurerm_key_vault.this_keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "e56f3662-0ea4-4e14-83a5-a1e4939aa208"

  secret_permissions = [
    "Set",
    "Get",
    "Delete",
    "List"
  ]
}

resource "azurerm_key_vault_access_policy" "this_eka_access_policy" {
  key_vault_id = azurerm_key_vault.this_keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "edb0e8ca-1bad-4b88-b498-cd3bb9b44e52"

  secret_permissions = [
    "Set",
    "Get",
    "Delete",
    "List"
  ]
}

resource "azurerm_key_vault_access_policy" "this_user_assigned_identity" {
  key_vault_id = azurerm_key_vault.this_keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.this_manageidentity.principal_id
  secret_permissions = [

    "Get"

  ]
}

# Assuming you have a for_each loop defined
resource "azurerm_key_vault_secret" "this_vm_secret" {
  name         = "${local.owner}-${var.vm_secret}-${local.environment}"
  value        = random_password.this_password.result
  key_vault_id = azurerm_key_vault.this_keyvault.id
}
resource "azurerm_key_vault_secret" "this_felxible_Server_secret" {
  name         = "${local.owner}-${var.flexible_server_secret}-${local.environment}"
  value        = random_password.this_password.result
  key_vault_id = azurerm_key_vault.this_keyvault.id
}