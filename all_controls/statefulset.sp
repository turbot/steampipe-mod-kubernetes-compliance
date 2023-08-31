locals {
  all_controls_statefulset_common_tags = merge(local.all_controls_common_tags, {
  })
}

benchmark "all_controls_statefulset" {
  title       = "StatefulSet"
  description = "This section contains recommendations for configuring StatefulSet resources."
  children = [
    control.statefulset_container_liveness_probe,
    control.statefulset_container_privilege_disabled,
    control.statefulset_container_privilege_escalation_disabled,
    control.statefulset_container_privilege_port_mapped,
    control.statefulset_container_readiness_probe,
    control.statefulset_cpu_limit,
    control.statefulset_cpu_request,
    control.statefulset_default_namespace_used,
    control.statefulset_default_seccomp_profile_enabled,
    control.statefulset_host_network_access_disabled,
    control.statefulset_hostpid_hostipc_sharing_disabled,
    control.statefulset_immutable_container_filesystem,
    control.statefulset_memory_limit,
    control.statefulset_memory_request,
    control.statefulset_non_root_container
  ]

  tags = merge(local.all_controls_statefulset_common_tags, {
    type = "Benchmark"
  })
}
