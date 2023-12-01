resource "azurerm_resource_group" "webapp" {
    name     = "${var.prefix}-rg"
    location = var.location
    tags = "${var.tag}"
}