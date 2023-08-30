locals {
  controls_by_component_service_common_tags = merge(local.controls_by_component_common_tags, {
  })
}

benchmark "controls_by_component_service" {
  title       = "Service"
  description = "This section contains recommendations for configuring ReplicationController resources."
  children = [
    control.service_type_forbidden
  ]

  tags = merge(local.controls_by_component_service_common_tags, {
    type = "Benchmark"
  })
}
