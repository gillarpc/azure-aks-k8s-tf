resource "azurerm_log_analytics_workspace" "inssas" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = var.log_analytics_workspace_location
    resource_group_name = var.resource_group_name
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "inssas" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.inssas.location
    resource_group_name   = var.resource_group_name
    workspace_resource_id = azurerm_log_analytics_workspace.inssas.id
    workspace_name        = azurerm_log_analytics_workspace.inssas.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}
resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}
