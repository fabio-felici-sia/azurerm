resource "azurerm_app_service_plan" "this" {
  count               = var.plan_type == "internal" ? 1 : 0
  name                = var.plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  kind = var.plan_kind

  sku {
    tier = var.plan_sku_tier
    size = var.plan_sku_size
  }

  maximum_elastic_worker_count = var.plan_maximum_elastic_worker_count
  reserved                     = var.plan_reserved
  per_site_scaling             = var.plan_per_site_scaling

  tags = var.tags
}

resource "azurerm_app_service" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  app_service_plan_id = var.plan_type == "internal" ? azurerm_app_service_plan.this[0].id : var.plan_id
  https_only          = true
  client_cert_enabled = var.client_cert_enabled

  app_settings = var.app_settings

  site_config {
    always_on              = var.always_on
    linux_fx_version       = var.linux_fx_version
    app_command_line       = var.app_command_line
    min_tls_version        = "1.2"
    ftps_state             = var.ftps_state
    vnet_route_all_enabled = var.subnet_id == null ? false : var.vnet_route_all_enabled

    health_check_path = var.health_check_path != null ? var.health_check_path : null

    dynamic "ip_restriction" {
      for_each = var.allowed_subnets
      iterator = subnet

      content {
        ip_address                = null
        virtual_network_subnet_id = subnet.value
      }
    }

    dynamic "ip_restriction" {
      for_each = var.allowed_ips
      iterator = ip

      content {
        ip_address                = ip.value
        virtual_network_subnet_id = null
      }
    }
  }

  storage_account {
    name = var.storage_file_name
    type = var.storage_type
    account_name = var.storage_account_name
    share_name = var.storage_account_shared_name
    mount_path = var.storage_mount
    access_key = var.storage_access_key
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      site_config.0.scm_type,
      site_config.0.linux_fx_version, # deployments are made outside of Terraform
      app_settings["DOCKER_CUSTOM_IMAGE_NAME"]
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_service_virtual_network_swift_connection" {
  count = var.subnet_id != null ? 1 : 0

  app_service_id = azurerm_app_service.this.id
  subnet_id      = var.subnet_id
}
