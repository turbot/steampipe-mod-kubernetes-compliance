locals {
  all_controls_deployment_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Deployment"
  })
}

benchmark "all_controls_deployment" {
  title       = "Deployment"
  description = "This section contains recommendations for configuring Deployment resources."
  children = [
    control.deployment_container_liveness_probe,
    control.deployment_container_privilege_disabled,
    control.deployment_container_privilege_escalation_disabled,
    control.deployment_container_privilege_port_mapped,
    control.deployment_container_readiness_probe,
    control.deployment_cpu_limit,
    control.deployment_cpu_request,
    control.deployment_default_namespace_used,
    control.deployment_default_seccomp_profile_enabled,
    control.deployment_host_network_access_disabled,
    control.deployment_hostpid_hostipc_sharing_disabled,
    control.deployment_immutable_container_filesystem,
    control.deployment_memory_limit,
    control.deployment_memory_request,
    control.deployment_non_root_container,
    control.deployment_replica_minimum_3
  ]

  tags = merge(local.all_controls_deployment_common_tags, {
    type = "Benchmark"
  })
}
