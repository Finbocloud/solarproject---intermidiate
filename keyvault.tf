#bad to put all current configuration
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "this_keyvault" {
  name                       = "${local.owner}-${var.kv_name}-${local.environment}"
  location                   = azurerm_resource_group.this_rg.location
  resource_group_name        = azurerm_resource_group.this_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7
  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = ["81.105.32.49"]
    virtual_network_subnet_ids = []
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    # HOW TO COPY object ID on the portal, search for ENTRA and, click users, copy object id
    #create a new user policy by coping the object ID and create a new user policy
    object_id = "d78ff511-9dec-4dbd-a574-36e6ada5e6bd"
    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "List"
    ]
  }
   access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    #copy object ID on the portal, search for ENTRA and, click users, copy object id
    #create a new user policy by coping the object ID and create a new user policy
    object_id = "d78ff511-9dec-4dbd-a574-36e6ada5e6bd"
    #change object id for onas and moji
    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "List"
    ]
  }
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    #copy object ID on the portal, search for ENTRA and, click users, copy object id
    #create a new user policy by coping the object ID and create a new user policy
    object_id = azurerm_user_assigned_identity.this_manageidentity.principal_id
    secret_permissions = [

      "Get"

    ]
  }
}



# Assuming you have a for_each loop defined
resource "azurerm_key_vault_secret" "this_vm_secret" {
  name         = var.vm_secret
  value        = random_password.this_password.result
  key_vault_id = azurerm_key_vault.this_keyvault.id
}
resource "azurerm_key_vault_secret" "this_felxible_Server_secret" {
  name         = var.felxible_server_secret
  value        = random_password.this_password.result
  key_vault_id = azurerm_key_vault.this_keyvault.id
}