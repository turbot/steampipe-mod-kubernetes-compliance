locals {
  all_controls_common_tags = merge(local.kubernetes_compliance_common_tags, {
    type = "Benchmark"
  })
}

benchmark "all_controls" {
  title         = "All Controls"
  description   = "This benchmark contains all controls grouped by component to help you detect resource configurations that do not meet best practices."
  documentation = file("./all_controls/docs/all_controls_overview.md")
  children = [
    benchmark.all_controls_config_map,
    benchmark.all_controls_cronjob,
    benchmark.all_controls_daemonset,
    benchmark.all_controls_deployment,
    benchmark.all_controls_endpoint,
    benchmark.all_controls_ingress,
    benchmark.all_controls_job,
    benchmark.all_controls_namespace,
    benchmark.all_controls_network_policy,
    benchmark.all_controls_pod,
    benchmark.all_controls_pod_security_policy,
    benchmark.all_controls_replicaset,
    benchmark.all_controls_replication_controller,
    benchmark.all_controls_role,
    benchmark.all_controls_role_binding,
    benchmark.all_controls_secret,
    benchmark.all_controls_service,
    benchmark.all_controls_service_account,
    benchmark.all_controls_statefulset,
    benchmark.all_controls_pod_template
  ]

  tags = local.all_controls_common_tags
}
