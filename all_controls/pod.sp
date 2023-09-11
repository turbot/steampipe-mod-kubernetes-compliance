locals {
  all_controls_pod_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Pod"
  })
}

benchmark "all_controls_pod" {
  title       = "Pod"
  description = "This section contains recommendations for configuring Pod resources."
  children = [
    control.pod_container_liveness_probe,
    control.pod_container_privilege_disabled,
    control.pod_container_privilege_escalation_disabled,
    control.pod_container_privilege_port_mapped,
    control.pod_container_readiness_probe,
    control.pod_container_with_added_capabilities,
    control.pod_default_namespace_used,
    control.pod_default_seccomp_profile_enabled,
    control.pod_host_network_access_disabled,
    control.pod_hostpid_hostipc_sharing_disabled,
    control.pod_immutable_container_filesystem,
    control.pod_non_root_container,
    control.pod_service_account_not_exist,
    control.pod_service_account_token_disabled,
    control.pod_volume_host_path
  ]

  tags = merge(local.all_controls_pod_common_tags, {
    type = "Benchmark"
  })
}
