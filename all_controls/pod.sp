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
    control.pod_container_admission_control_plugin_always_pull_images,
    control.pod_container_admission_control_plugin_no_always_admit,
    control.pod_container_arg_peer_client_cert_auth_enabled,
    control.pod_container_argument_anonymous_auth_disabled,
    control.pod_container_argument_audit_log_maxage_greater_than_30,
    control.pod_container_argument_audit_log_maxbackup_greater_than_10,
    control.pod_container_argument_audit_log_maxsize_greater_than_100,
    control.pod_container_argument_audit_log_path_configured,
    control.pod_container_argument_authorization_mode_no_always_allow,
    control.pod_container_argument_authorization_mode_node,
    control.pod_container_argument_authorization_mode_rbac,
    control.pod_container_argument_etcd_cafile_configured,
    control.pod_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.pod_container_argument_event_qps_less_than_5,
    control.pod_container_argument_insecure_port_0,
    control.pod_container_argument_kubelet_client_certificate_and_key_configured,
    control.pod_container_argument_kubelet_https_enabled,
    control.pod_container_capabilities_drop_all,
    control.pod_container_encryption_providers_configured,
    control.pod_container_image_pull_policy_always,
    control.pod_container_image_tag_specified,
    control.pod_container_liveness_probe,
    control.pod_container_memory_limit,
    control.pod_container_memory_request,
    control.pod_container_no_argument_basic_auth_file,
    control.pod_container_no_argument_insecure_bind_address,
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
    control.pod_container_argument_kube_scheduler_profiling_disabled,
    control.pod_container_argument_bind_address_127_0_0_1,
    control.pod_container_argument_protect_kernel_defaults_enabled,
    control.pod_container_argument_make_iptables_util_chains_enabled,
    control.pod_container_argument_tls_cert_file_and_tls_private_key_file_configured,
    control.pod_container_no_argument_hostname_override_configured,
    control.pod_container_argument_kube_controller_manager_profiling_disabled,
    control.pod_container_argument_etcd_auto_tls_disabled,
    control.pod_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.pod_container_argument_kubelet_authorization_mode_no_always_allow,
    control.pod_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.pod_container_argument_kubelet_read_only_port_0,
    control.pod_container_argument_kube_controller_manager_root_ca_file_configured,
    control.pod_container_argument_etcd_client_cert_auth_enabled,
    control.pod_container_argument_namespace_lifecycle_enabled,
    control.pod_container_argument_service_account_lookup_enabled,
    control.pod_container_token_auth_file_not_configured,
    control.pod_container_kubelet_certificate_authority_configured,
    control.pod_container_argument_node_restriction_enabled,
  ]

  tags = merge(local.all_controls_pod_common_tags, {
    type = "Benchmark"
  })
}
