locals {
  controls_by_component_common_tags = merge(local.kubernetes_compliance_common_tags, {
    type = "Benchmark"
  })
}

benchmark "controls_by_component" {
  title       = "Controls by Component"
  description = "This benchmark contains all controls grouped by component to help you detect resource configurations that do not meet best practices."
  documentation = file("./controls_by_component/docs/controls_by_component_overview.md")
  children = [
    benchmark.controls_by_component_cronjob,
    benchmark.controls_by_component_daemonset,
    benchmark.controls_by_component_deployment,
    benchmark.controls_by_component_job,
    benchmark.controls_by_component_pod,
    benchmark.controls_by_component_replicaset,
    benchmark.controls_by_component_replication_controller,
    benchmark.controls_by_component_service,
    benchmark.controls_by_component_statefulset
  ]

  tags = local.controls_by_component_common_tags
}
