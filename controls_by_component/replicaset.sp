locals {
  controls_by_component_replicaset_common_tags = merge(local.controls_by_component_common_tags, {
  })
}

benchmark "controls_by_component_replicaset" {
  title       = "ReplicaSet"
  description = "This section contains recommendations for configuring ReplicaSet resources."
  children = [
    control.replicaset_container_liveness_probe,
    control.replicaset_container_privilege_port_mapped,
    control.replicaset_container_readiness_probe
  ]

  tags = merge(local.controls_by_component_replicaset_common_tags, {
    type = "Benchmark"
  })
}
