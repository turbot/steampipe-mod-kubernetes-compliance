locals {
  all_controls_secret_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Secret"
  })
}

benchmark "all_controls_secret" {
  title       = "Secret"
  description = "This section contains recommendations for configuring Secret resources."
  children = [
    control.secret_default_namespace_used
  ]

  tags = merge(local.all_controls_secret_common_tags, {
    type = "Benchmark"
  })
}
