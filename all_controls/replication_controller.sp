locals {
  all_controls_replication_controller_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/ReplicationController"
  })
}

benchmark "all_controls_replication_controller" {
  title       = "ReplicationController"
  description = "This section contains recommendations for configuring ReplicationController resources."
  children = [
    control.replication_controller_container_admission_capability_restricted,
    control.replication_controller_container_encryption_providers_configured,
    control.replication_controller_container_image_pull_policy_always,
    control.replication_controller_container_image_tag_specified,
    control.replication_controller_container_liveness_probe,
    control.replication_controller_container_privilege_disabled,
    control.replication_controller_container_privilege_escalation_disabled,
    control.replication_controller_container_privilege_port_mapped,
    control.replication_controller_container_readiness_probe,
    control.replication_controller_container_security_context_exists,
    control.replication_controller_container_with_added_capabilities,
    control.replication_controller_cpu_limit,
    control.replication_controller_cpu_request,
    control.replication_controller_default_namespace_used,
    control.replication_controller_default_seccomp_profile_enabled,
    control.replication_controller_host_network_access_disabled,
    control.replication_controller_hostpid_hostipc_sharing_disabled,
    control.replication_controller_immutable_container_filesystem,
    control.replication_controller_memory_limit,
    control.replication_controller_memory_request,
    control.replication_controller_non_root_container
  ]

  tags = merge(local.all_controls_replication_controller_common_tags, {
    type = "Benchmark"
  })
}
