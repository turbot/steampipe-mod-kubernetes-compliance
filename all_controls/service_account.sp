locals {
  all_controls_service_account_common_tags = merge(local.all_controls_common_tags, {
  })
}

benchmark "all_controls_service_account" {
  title       = "Service Account"
  description = "This section contains recommendations for configuring Service Account resources."
  children = [
    control.service_account_default_namespace_used,
    control.service_account_token_disabled
  ]

  tags = merge(local.all_controls_service_account_common_tags, {
    type = "Benchmark"
  })
}
