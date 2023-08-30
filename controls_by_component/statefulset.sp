locals {
  controls_by_component_statefulset_common_tags = merge(local.controls_by_component_common_tags, {
  })
}

benchmark "controls_by_component_statefulset" {
  title       = "StatefulSet"
  description = "This section contains recommendations for configuring StatefulSet resources."
  children = [
    control.statefulset_container_liveness_probe,
    control.statefulset_container_privilege_port_mapped,
    control.statefulset_container_readiness_probe
  ]

  tags = merge(local.controls_by_component_statefulset_common_tags, {
    type = "Benchmark"
  })
}
