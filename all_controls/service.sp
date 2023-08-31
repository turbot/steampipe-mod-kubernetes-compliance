locals {
  all_controls_service_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Service"
  })
}

benchmark "all_controls_service" {
  title       = "Service"
  description = "This section contains recommendations for configuring ReplicationController resources."
  children = [
    control.service_default_namespace_used,
    control.service_type_forbidden
  ]

  tags = merge(local.all_controls_service_common_tags, {
    type = "Benchmark"
  })
}
