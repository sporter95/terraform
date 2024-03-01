resource "azurerm_monitor_action_group" "auto-shutdown" {
  name                = "auto-shutdown"
  resource_group_name = var.rg_name
  short_name          = "shutdown"
}

resource "azurerm_consumption_budget_resource_group" "cost-monitor" {
  name              = "sporter-cost-monitor"
  resource_group_id = var.rg_id

  amount     = 10
  time_grain = "Monthly"

  time_period {
    start_date = "2024-03-01T00:00:00Z"
    end_date   = "2025-07-01T00:00:00Z"
  }

 
  notification {
    enabled        = true
    threshold      = 90.0
    operator       = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = [
      "sporter.itpro@gmail.com",
    ]

    contact_groups = [
      azurerm_monitor_action_group.auto-shutdown.id,
    ]

    contact_roles = [
      "Owner",
    ]
  }
} 