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
    control.daemonset_container_admission_control_plugin_always_pull_images,
    control.daemonset_container_admission_control_plugin_no_always_admit,
    control.daemonset_container_arg_peer_client_cert_auth_enabled,
    control.daemonset_container_argument_anonymous_auth_disabled,
    control.daemonset_container_argument_audit_log_maxage_greater_than_30,
    control.daemonset_container_argument_audit_log_maxbackup_greater_than_10,
    control.daemonset_container_argument_audit_log_maxsize_greater_than_100,
    control.daemonset_container_argument_audit_log_path_configured,
    control.daemonset_container_argument_authorization_mode_no_always_allow,
    control.daemonset_container_argument_authorization_mode_node,
    control.daemonset_container_argument_authorization_mode_rbac,
    control.daemonset_container_argument_etcd_auto_tls_disabled,
    control.daemonset_container_argument_etcd_cafile_configured,
    control.daemonset_container_argument_etcd_certfile_and_keyfile_configured,
    control.daemonset_container_argument_etcd_client_cert_auth_enabled,
    control.daemonset_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.daemonset_container_argument_event_qps_less_than_5,
    control.daemonset_container_argument_insecure_port_0,
    control.daemonset_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.daemonset_container_argument_kube_apiserver_profiling_disabled,
    control.daemonset_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured,
    control.daemonset_container_argument_kube_controller_manager_bind_address_127_0_0_1,
    control.daemonset_container_argument_kube_controller_manager_profiling_disabled,
    control.daemonset_container_argument_kube_controller_manager_root_ca_file_configured,
    control.daemonset_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.daemonset_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.daemonset_container_argument_kube_scheduler_bind_address_127_0_0_1,
    control.daemonset_container_argument_kube_scheduler_profiling_disabled,
    control.daemonset_container_argument_kubelet_authorization_mode_no_always_allow,
    control.daemonset_container_argument_kubelet_client_ca_file_configured,
    control.daemonset_container_argument_kubelet_client_certificate_and_key_configured,
    control.daemonset_container_argument_kubelet_https_enabled,
    control.daemonset_container_argument_kubelet_read_only_port_0,
    control.daemonset_container_argument_kubelet_terminated_pod_gc_threshold_configured,
    control.daemonset_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured,
    control.daemonset_container_argument_make_iptables_util_chains_enabled,
    control.daemonset_container_argument_namespace_lifecycle_enabled,
    control.daemonset_container_argument_node_restriction_enabled,
    control.daemonset_container_argument_pod_security_policy_enabled,
    control.daemonset_container_argument_protect_kernel_defaults_enabled,
    control.daemonset_container_argument_rotate_kubelet_server_certificate_enabled,
    control.daemonset_container_argument_secure_port_not_0,
    control.daemonset_container_argument_security_context_deny_enabled,
    control.daemonset_container_argument_service_account_enabled,
    control.daemonset_container_argument_service_account_key_file_appropriate,
    control.daemonset_container_argument_service_account_lookup_enabled,
    control.daemonset_container_capabilities_drop_all,
    control.daemonset_container_encryption_providers_configured,
    control.daemonset_container_image_pull_policy_always,
    control.daemonset_container_image_tag_specified,
    control.daemonset_container_kubelet_certificate_authority_configured,
    control.daemonset_container_kubernetes_dashboard_not_deployed,
    control.daemonset_container_liveness_probe,
    control.daemonset_container_no_argument_basic_auth_file,
    control.daemonset_container_no_argument_hostname_override_configured,
    control.daemonset_container_no_argument_insecure_bind_address,
    control.daemonset_container_privilege_disabled,
    control.daemonset_container_privilege_escalation_disabled,
    control.daemonset_container_privilege_port_mapped,
    control.daemonset_container_readiness_probe,
    control.daemonset_container_rotate_certificate_enabled,
    control.daemonset_container_security_context_exists,
    control.daemonset_container_streaming_connection_idle_timeout_not_zero,
    control.daemonset_container_strong_kube_apiserver_cryptographic_ciphers,
    control.daemonset_container_strong_kubelet_cryptographic_ciphers,
    control.daemonset_container_sys_admin_capability_disabled,
    control.daemonset_container_token_auth_file_not_configured,
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
    control.daemonset_container_host_port_not_specified,
  ]

  tags = merge(local.all_controls_daemonset_common_tags, {
    type = "Benchmark"
  })
}
