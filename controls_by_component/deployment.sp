locals {
  controls_by_component_deployment_common_tags = merge(local.controls_by_component_common_tags, {
  })
}

benchmark "controls_by_component_deployment" {
  title       = "Deployment"
  description = "This section contains recommendations for configuring Deployment resources."
  children = [
    control.deployment_container_liveness_probe,
    control.deployment_container_privilege_port_mapped,
    control.deployment_container_readiness_probe,
    control.deployment_replica_minimum_3
  ]

  tags = merge(local.controls_by_component_deployment_common_tags, {
    type = "Benchmark"
  })
}
