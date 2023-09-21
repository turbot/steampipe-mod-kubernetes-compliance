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
    control.daemonset_container_arg_peer_client_cert_auth_enabled,
    control.daemonset_container_argument_event_qps_less_than_5,
    control.daemonset_container_capabilities_drop_all,
    control.daemonset_container_encryption_providers_configured,
    control.daemonset_container_image_pull_policy_always,
    control.daemonset_container_image_tag_specified,
    control.daemonset_container_liveness_probe,
    control.daemonset_container_privilege_disabled,
    control.daemonset_container_privilege_escalation_disabled,
    control.daemonset_container_privilege_port_mapped,
    control.daemonset_container_readiness_probe,
    control.daemonset_container_rotate_certificate_enabled,
    control.daemonset_container_security_context_exists,
    control.daemonset_container_sys_admin_capability_disabled,
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
    control.daemonset_non_root_container,
    control.daemonset_container_argument_anonymous_auth_disabled,
    control.daemonset_container_argument_audit_log_path_configured,
    control.daemonset_container_argument_audit_log_maxage_greater_than_30,
    control.daemonset_container_argument_audit_log_maxbackup_greater_than_10,
    control.daemonset_container_argument_audit_log_maxsize_greater_than_100,
    control.daemonset_container_no_argument_basic_auth_file,
    control.daemonset_container_argument_etcd_cafile_configured,
    control.daemonset_container_argument_authorization_mode_node,
    control.daemonset_container_argument_authorization_mode_no_always_allow,
    control.daemonset_container_argument_authorization_mode_rbac,
  ]

  tags = merge(local.all_controls_daemonset_common_tags, {
    type = "Benchmark"
  })
}
