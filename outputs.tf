output "public_ip" {
  value = azurerm_public_ip.myPublicIP1.ip_address
}

output "security_group" {
  value = azurerm_network_security_group.nsg-prod.id  
}

output "security_rules" {
  value = azurerm_network_security_group.nsg-prod.security_rule
}