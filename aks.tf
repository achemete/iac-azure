resource "azurerm_kubernetes_cluster" "aks-dev" {
    name = "terraform-aks-unir-dev"
    location = azurerm_resource_group.rg-dev.location
    resource_group_name = azurerm_resource_group.rg-dev.name
    dns_prefix = "terraformaksunir-dev"
    default_node_pool {
        name = "default"
        node_count = 1
        vm_size = "Standard_B2s"
    }
    identity {
        type = "SystemAssigned"
    }
}