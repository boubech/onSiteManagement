

provider "azurerm" {
    version = "=2.2.0"
    features {}
}
resource "azurerm_resource_group" "group" {
    name                  = var.azure_group
    location              = var.azure_region
}

