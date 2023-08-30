locals {
  controls_by_component_daemonset_common_tags = merge(local.controls_by_component_common_tags, {
  })
}

benchmark "controls_by_component_daemonset" {
  title       = "Daemonset"
  description = "This section contains recommendations for configuring Daemonset resources."
  children = [
    control.daemonset_container_liveness_probe,
    control.daemonset_container_privilege_port_mapped,
    control.daemonset_container_readiness_probe
  ]

  tags = merge(local.controls_by_component_daemonset_common_tags, {
    type = "Benchmark"
  })
}
