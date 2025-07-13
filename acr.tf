resource "azurerm_container_registry" "acr" {
    name = "terraformacrunir"
    resource_group_name = azurerm_resource_group.rg-dev.name
    location = azurerm_resource_group.rg-dev.location
    sku = "Basic"
    admin_enabled = true
}
