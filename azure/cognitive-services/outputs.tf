output "identity_id" {
  value = azurerm_user_assigned_identity.main.id
}

output "identity_principal_id" {
  value = azurerm_user_assigned_identity.main.principal_id
}

output "endpoint" {
  value = azurerm_cognitive_account.main.endpoint
}
