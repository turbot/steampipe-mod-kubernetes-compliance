locals {
  all_controls_daemonset_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/DaemonSet"
  })
}

benchmark "all_controls_daemonset" {
  title       = "DaemonSet"
  description = "This section contains recommendations for configuring DaemonSet resources."
  children = [
    control.daemonset_container_admission_capability_restricted,
    control.daemonset_container_image_pull_policy_always,
    control.daemonset_container_image_tag_specified,
    control.daemonset_container_liveness_probe,
    control.daemonset_container_privilege_disabled,
    control.daemonset_container_privilege_escalation_disabled,
    control.daemonset_container_privilege_port_mapped,
    control.daemonset_container_readiness_probe,
    control.daemonset_container_security_context_exists,
    control.daemonset_container_with_added_capabilities,
    control.daemonset_cpu_limit,
    control.daemonset_cpu_request,
    control.daemonset_default_namespace_used,
    control.daemonset_default_seccomp_profile_enabled,
    control.daemonset_host_network_access_disabled,
    control.daemonset_hostpid_hostipc_sharing_disabled,
    control.daemonset_immutable_container_filesystem,
    control.daemonset_memory_limit,
    control.daemonset_memory_request,
    control.daemonset_non_root_container
  ]

  tags = merge(local.all_controls_daemonset_common_tags, {
    type = "Benchmark"
  })
}
