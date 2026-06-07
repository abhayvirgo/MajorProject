
resource "azurerm_resource_group" "rg" {
  name     = "rg-aks-sllm-${var.prefix}"
  location = "swedencentral"
}