locals {
  controls_by_component_pod_common_tags = merge(local.controls_by_component_common_tags, {
  })
}

benchmark "controls_by_component_pod" {
  title       = "Pod"
  description = "This section contains recommendations for configuring Pod resources."
  children = [
    control.pod_container_liveness_probe,
    control.pod_container_privilege_port_mapped,
    control.pod_container_readiness_probe,
    control.pod_service_account_not_exist
  ]

  tags = merge(local.controls_by_component_pod_common_tags, {
    type = "Benchmark"
  })
}
