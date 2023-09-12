locals {
  all_controls_replicaset_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/ReplicaSet"
  })
}

benchmark "all_controls_replicaset" {
  title       = "ReplicaSet"
  description = "This section contains recommendations for configuring ReplicaSet resources."
  children = [
    control.replicaset_container_liveness_probe,
    control.replicaset_container_privilege_disabled,
    control.replicaset_container_privilege_escalation_disabled,
    control.replicaset_container_privilege_port_mapped,
    control.replicaset_container_readiness_probe,
    control.replicaset_container_security_context_exists,
    control.replicaset_container_with_added_capabilities,
    control.replicaset_cpu_limit,
    control.replicaset_cpu_request,
    control.replicaset_default_namespace_used,
    control.replicaset_default_seccomp_profile_enabled,
    control.replicaset_host_network_access_disabled,
    control.replicaset_hostpid_hostipc_sharing_disabled,
    control.replicaset_immutable_container_filesystem,
    control.replicaset_memory_limit,
    control.replicaset_memory_request,
    control.replicaset_non_root_container
  ]

  tags = merge(local.all_controls_replicaset_common_tags, {
    type = "Benchmark"
  })
}
