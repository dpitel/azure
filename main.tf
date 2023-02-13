provider "azurerm" {
  version = "3.0.2"

  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "dimatest"
  location = "eastus"
}

resource "azurerm_storage_account" "example" {
  name                     = "dimateststorage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}


resource "azurerm_storage_account_network_rules" "example" {
  storage_account_id = "/subscriptions/06e22377-2c09-458d-a96a-99dc6dad2079/resourceGroups/dimatest/providers/Microsoft.Storage/storageAccounts/dimateststorage"
  default_action             = "Allow"
  virtual_network_subnet_ids = []
}

resource "azurerm_static_site" "example" {
  name                 = "dimastaticweb"
  location             = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name

}
