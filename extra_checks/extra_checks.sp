locals {
  extra_checks_tags = {
    extra_checks = "true"
    plugin      = "kubernetes"
  }
}

benchmark "extra_checks" {
  title         = "Extra Checks"
  documentation = file("./extra_checks/docs/extra_checks_overview.md")
  tags          = local.extra_checks_tags
  children = [
    control.deployment_replica_minimum_3,
    control.pod_service_account_not_exist,
    control.service_type_forbidden,
    benchmark.container_liveness_probe,
    benchmark.container_readiness_probe,
    benchmark.container_privilege_port_mapped,
    benchmark.cis_benchmark_section_5,
     ]
}