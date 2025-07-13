
# Pro version: 1.0
# Virtual Network
/*
resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Subnets
resource "azurerm_subnet" "subnets" {
  for_each             = { for subnet in var.subnets : subnet.name => subnet }
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [each.value.address_prefix]
}

# Network Interface (NIC) - attaches to the first subnet by default
resource "azurerm_network_interface" "main" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets[values(var.subnets)[0].name].id
    private_ip_address_allocation = "Dynamic"
  }
}
*/

# Newbie version: 1.0

# Public IP Address declaration
resource "azurerm_public_ip" "myPublicIP1" {
    name = "k8s-prod-pip1"
    location = azurerm_resource_group.rg-prod.location
    resource_group_name = azurerm_resource_group.rg-prod.name
    allocation_method = "Static"
    sku = "Standard"

    tags = {
        environment = "dev"
    }
}

# Virtual Network and Subnets

# Network declaration
resource "azurerm_virtual_network" "myNet-dev" {
  name                = "kubernetesProd-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-prod.location
  resource_group_name = azurerm_resource_group.rg-prod.name
}

# Subnet declaration
resource "azurerm_subnet" "mySubnet" {
    name                 = "kubernetesDev-subnet1"
    resource_group_name = azurerm_resource_group.rg-dev.name
    virtual_network_name = azurerm_virtual_network.myNet-dev.name
    address_prefixes     = ["10.0.1.0/24"]
}

# Network Interface (NIC) declaration
resource "azurerm_network_interface" "myNic-dev" {
    name                = "kubernetesDev-nic1"
    location            = azurerm_resource_group.rg-dev.location
    resource_group_name = azurerm_resource_group.rg-dev.name

    ip_configuration {
        name                          = "internal-Dev"
        subnet_id                     = azurerm_subnet.mySubnet.id
        private_ip_address_allocation = "Static"
        private_ip_address = "10.0.1.10"
        public_ip_address_id = azurerm_public_ip.myPublicIP1.id
    }
    tags = {
        environment = "dev"
    }
}