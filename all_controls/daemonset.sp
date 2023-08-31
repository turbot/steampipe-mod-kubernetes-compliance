locals {
  all_controls_daemonset_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/DaemonSet"
  })
}

benchmark "all_controls_daemonset" {
  title       = "Daemonset"
  description = "This section contains recommendations for configuring Daemonset resources."
  children = [
    control.daemonset_container_liveness_probe,
    control.daemonset_container_privilege_disabled,
    control.daemonset_container_privilege_escalation_disabled,
    control.daemonset_container_privilege_port_mapped,
    control.daemonset_container_readiness_probe,
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
