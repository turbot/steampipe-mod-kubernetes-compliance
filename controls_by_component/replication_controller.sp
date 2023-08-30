locals {
  controls_by_component_replication_controller_common_tags = merge(local.controls_by_component_common_tags, {
  })
}

benchmark "controls_by_component_replication_controller" {
  title       = "ReplicationController"
  description = "This section contains recommendations for configuring ReplicationController resources."
  children = [
    control.replication_controller_container_liveness_probe,
    control.replication_controller_container_privilege_port_mapped,
    control.replication_controller_container_readiness_probe
  ]

  tags = merge(local.controls_by_component_replication_controller_common_tags, {
    type = "Benchmark"
  })
}
