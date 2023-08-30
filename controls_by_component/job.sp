locals {
  controls_by_component_job_common_tags = merge(local.controls_by_component_common_tags, {
  })
}

benchmark "controls_by_component_job" {
  title       = "Job"
  description = "This section contains recommendations for configuring Job resources."
  children = [
    control.job_container_liveness_probe,
    control.job_container_privilege_port_mapped,
    control.job_container_readiness_probe
  ]

  tags = merge(local.controls_by_component_job_common_tags, {
    type = "Benchmark"
  })
}
