resource "azurerm_app_service_plan" "webapp" {
  name                = "${var.prefix}-SP"
  location            = azurerm_resource_group.webapp.location
  resource_group_name = azurerm_resource_group.webapp.name
  kind = "Linux"
  reserved = true

  sku {
    tier = "Free"
    size = "F1"
  }
}


resource "azurerm_linux_web_app" "webapp" {
  name = "${var.prefix}"
  resource_group_name = azurerm_resource_group.webapp.name
  location = var.location
  service_plan_id = azurerm_app_service_plan.webapp.id

  site_config {
    always_on = false
    application_stack {
      docker_image_name = "carpel/netflix"
      docker_registry_url = "https://index.docker.io"
    }
  }
}