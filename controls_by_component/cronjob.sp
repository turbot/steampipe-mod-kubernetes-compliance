locals {
  controls_by_component_cronjob_common_tags = merge(local.controls_by_component_common_tags, {
  })
}

benchmark "controls_by_component_cronjob" {
  title       = "CronJob"
  description = "This section contains recommendations for configuring CronJob resources."
  children = [
    control.cronjob_container_liveness_probe,
    control.cronjob_container_privilege_port_mapped,
    control.cronjob_container_readiness_probe
  ]

  tags = merge(local.controls_by_component_cronjob_common_tags, {
    type = "Benchmark"
  })
}
