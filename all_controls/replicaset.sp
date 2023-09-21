locals {
  all_controls_replicaset_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/ReplicaSet"
  })
}

benchmark "all_controls_replicaset" {
  title       = "ReplicaSet"
  description = "This section contains recommendations for configuring ReplicaSet resources."
  children = [
    control.replicaset_container_admission_capability_restricted,
    control.replicaset_container_arg_peer_client_cert_auth_enabled,
    control.replicaset_container_argument_event_qps_less_than_5,
    control.replicaset_container_capabilities_drop_all,
    control.replicaset_container_encryption_providers_configured,
    control.replicaset_container_image_pull_policy_always,
    control.replicaset_container_image_tag_specified,
    control.replicaset_container_liveness_probe,
    control.replicaset_container_privilege_disabled,
    control.replicaset_container_privilege_escalation_disabled,
    control.replicaset_container_privilege_port_mapped,
    control.replicaset_container_readiness_probe,
    control.replicaset_container_rotate_certificate_enabled,
    control.replicaset_container_security_context_exists,
    control.replicaset_container_sys_admin_capability_disabled,
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
    control.replicaset_non_root_container,
    control.replicaset_container_argument_anonymous_auth_disabled,
    control.replicaset_container_argument_audit_log_path_configured,
    control.replicaset_container_argument_audit_log_maxage_greater_than_30,
    control.replicaset_container_argument_audit_log_maxbackup_greater_than_10,
    control.replicaset_container_argument_audit_log_maxsize_greater_than_100,
    control.replicaset_container_no_argument_basic_auth_file,
    control.replicaset_container_argument_etcd_cafile_configured,
    control.replicaset_container_argument_authorization_mode_node,
    control.replicaset_container_argument_authorization_mode_no_always_allow,
    control.replicaset_container_argument_authorization_mode_rbac,
  ]


  tags = merge(local.all_controls_replicaset_common_tags, {
    type = "Benchmark"
  })
}
