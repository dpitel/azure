provider "azurerm" {
  version = "3.0.2"
}

resource "azurerm_resource_group" "example" {
  name     = "dimatest"
  location = "eastus"
}

resource "azurerm_storage_account" "example" {
  name                     = "dima_storage"
  resource_group_name     = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}


resource "azurerm_storage_account_network_rules" "example" {
  resource_group_name = azurerm_resource_group.example.name
  storage_account_name = azurerm_storage_account.example.name
  default_action       = "Allow"
  virtual_network_subnet_ids = []
}

resource "azurerm_static_web_site" "example" {
  name                = "dimastaticweb"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  storage_account_name= azurerm_storage_account.example.name

  index_document       = "index.html"
  error_document404_path = "404.html"
}
