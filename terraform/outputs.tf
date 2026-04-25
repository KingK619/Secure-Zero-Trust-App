output "app_url" {
  value = azurerm_linux_web_app.app.default_hostname
}
output "webapp_name" {
  value = azurerm_linux_web_app.app.name
}