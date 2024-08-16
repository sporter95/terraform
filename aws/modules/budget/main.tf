resource "aws_budgets_budget" "entire_account" {
    name    = "budget-account-monthly"
    budget_type       = "COST"
    limit_amount      = "10.00"
    limit_unit        = "USD"
    time_period_end   = "2087-06-15_00:00"
    time_period_start = "2024-02-01_00:00"
    time_unit         = "MONTHLY"


  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["sporter.itpro@gmail.com"]
  }
}