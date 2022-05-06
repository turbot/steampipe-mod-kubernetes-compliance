locals {
  extra_checks_tags = merge(local.kubernetes_compliance_common_tags,{
    extra_checks = "true"
  })
}

benchmark "extra_checks" {
  title         = "Extra Checks"
  documentation = file("./extra_checks/docs/extra_checks_overview.md")
  children = [
    benchmark.container_liveness_probe,
    benchmark.container_privilege_port_mapped,
    benchmark.container_readiness_probe,
    control.deployment_replica_minimum_3,
    control.pod_service_account_not_exist,
    control.service_type_forbidden
  ]

  tags = merge(local.extra_checks_tags, {
    type = "Benchmark"
  })
}
