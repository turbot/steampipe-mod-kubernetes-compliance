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
    control.replication_controller_container_arg_peer_client_cert_auth_enabled,
    control.replication_controller_container_argument_event_qps_less_than_5,
    control.replication_controller_container_capabilities_drop_all,
    control.replication_controller_container_encryption_providers_configured,
    control.replication_controller_container_image_pull_policy_always,
    control.replication_controller_container_image_tag_specified,
    control.replication_controller_container_liveness_probe,
    control.replication_controller_container_privilege_disabled,
    control.replication_controller_container_privilege_escalation_disabled,
    control.replication_controller_container_privilege_port_mapped,
    control.replication_controller_container_readiness_probe,
    control.replication_controller_container_rotate_certificate_enabled,
    control.replication_controller_container_security_context_exists,
    control.replication_controller_container_sys_admin_capability_disabled,
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
    control.replication_controller_non_root_container,
    control.replication_controller_container_argument_anonymous_auth_disabled,
    control.replication_controller_container_argument_audit_log_path_configured,
    control.replication_controller_container_argument_audit_log_maxage_greater_than_30,
    control.replication_controller_container_argument_audit_log_maxbackup_greater_than_10,
    control.replication_controller_container_argument_audit_log_maxsize_greater_than_100,
    control.replication_controller_container_no_argument_basic_auth_file,
    control.replication_controller_container_argument_etcd_cafile_configured,
    control.replication_controller_container_argument_authorization_mode_node,
    control.replication_controller_container_argument_authorization_mode_no_always_allow,
    control.replication_controller_container_argument_authorization_mode_rbac,
  ]

  tags = merge(local.all_controls_replication_controller_common_tags, {
    type = "Benchmark"
  })
}
