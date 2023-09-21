locals {
  all_controls_pod_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Pod"
  })
}

benchmark "all_controls_pod" {
  title       = "Pod"
  description = "This section contains recommendations for configuring Pod resources."
  children = [
    control.pod_container_admission_capability_restricted,
    control.pod_container_arg_peer_client_cert_auth_enabled,
    control.pod_container_argument_event_qps_less_than_5,
    control.pod_container_capabilities_drop_all,
    control.pod_container_encryption_providers_configured,
    control.pod_container_image_pull_policy_always,
    control.pod_container_image_tag_specified,
    control.pod_container_liveness_probe,
    control.pod_container_memory_limit,
    control.pod_container_memory_request,
    control.pod_container_privilege_disabled,
    control.pod_container_privilege_escalation_disabled,
    control.pod_container_privilege_port_mapped,
    control.pod_container_readiness_probe,
    control.pod_container_rotate_certificate_enabled,
    control.pod_container_security_context_exists,
    control.pod_container_sys_admin_capability_disabled,
    control.pod_container_with_added_capabilities,
    control.pod_default_namespace_used,
    control.pod_default_seccomp_profile_enabled,
    control.pod_host_network_access_disabled,
    control.pod_hostpid_hostipc_sharing_disabled,
    control.pod_immutable_container_filesystem,
    control.pod_non_root_container,
    control.pod_service_account_not_exist,
    control.pod_service_account_token_disabled,
    control.pod_volume_host_path,
    control.pod_container_argument_anonymous_auth_disabled,
    control.pod_container_argument_audit_log_path_configured,
    control.pod_container_argument_audit_log_maxage_greater_than_30,
    control.pod_container_argument_audit_log_maxbackup_greater_than_10,
    control.pod_container_argument_audit_log_maxsize_greater_than_100,
    control.pod_container_no_argument_basic_auth_file,
  ]

  tags = merge(local.all_controls_pod_common_tags, {
    type = "Benchmark"
  })
}
