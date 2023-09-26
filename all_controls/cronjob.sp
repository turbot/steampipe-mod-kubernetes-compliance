locals {
  all_controls_cronjob_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/CronJob"
  })
}

benchmark "all_controls_cronjob" {
  title       = "CronJob"
  description = "This section contains recommendations for configuring CronJob resources."
  children = [
    control.cronjob_container_admission_capability_restricted,
    control.cronjob_container_admission_control_plugin_always_pull_images,
    control.cronjob_container_admission_control_plugin_no_always_admit,
    control.cronjob_container_arg_peer_client_cert_auth_enabled,
    control.cronjob_container_argument_anonymous_auth_disabled,
    control.cronjob_container_argument_audit_log_maxage_greater_than_30,
    control.cronjob_container_argument_audit_log_maxbackup_greater_than_10,
    control.cronjob_container_argument_audit_log_maxsize_greater_than_100,
    control.cronjob_container_argument_audit_log_path_configured,
    control.cronjob_container_argument_authorization_mode_no_always_allow,
    control.cronjob_container_argument_authorization_mode_node,
    control.cronjob_container_argument_authorization_mode_rbac,
    control.cronjob_container_argument_etcd_cafile_configured,
    control.cronjob_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.cronjob_container_argument_event_qps_less_than_5,
    control.cronjob_container_argument_insecure_port_0,
    control.cronjob_container_argument_kubelet_client_certificate_and_key_configured,
    control.cronjob_container_argument_kubelet_https_enabled,
    control.cronjob_container_capabilities_drop_all,
    control.cronjob_container_encryption_providers_configured,
    control.cronjob_container_image_pull_policy_always,
    control.cronjob_container_image_tag_specified,
    control.cronjob_container_liveness_probe,
    control.cronjob_container_no_argument_basic_auth_file,
    control.cronjob_container_no_argument_insecure_bind_address,
    control.cronjob_container_privilege_disabled,
    control.cronjob_container_privilege_escalation_disabled,
    control.cronjob_container_privilege_port_mapped,
    control.cronjob_container_readiness_probe,
    control.cronjob_container_rotate_certificate_enabled,
    control.cronjob_container_security_context_exists,
    control.cronjob_container_sys_admin_capability_disabled,
    control.cronjob_container_with_added_capabilities,
    control.cronjob_cpu_limit,
    control.cronjob_cpu_request,
    control.cronjob_default_namespace_used,
    control.cronjob_default_seccomp_profile_enabled,
    control.cronjob_host_network_access_disabled,
    control.cronjob_hostpid_hostipc_sharing_disabled,
    control.cronjob_immutable_container_filesystem,
    control.cronjob_memory_limit,
    control.cronjob_memory_request,
    control.cronjob_non_root_container,
    control.cronjob_container_argument_kube_scheduler_profiling_disabled,
    control.cronjob_container_argument_kube_scheduler_bind_address_127_0_0_1,
    control.cronjob_container_argument_protect_kernel_defaults_enabled,
    control.cronjob_container_argument_make_iptables_util_chains_enabled,
    control.cronjob_container_argument_tls_cert_file_and_tls_private_key_file_configured,
    control.cronjob_container_no_argument_hostname_override_configured,
    control.cronjob_container_argument_kube_controller_manager_profiling_disabled,
    control.cronjob_container_argument_etcd_auto_tls_disabled,
    control.cronjob_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.cronjob_container_argument_kubelet_authorization_mode_no_always_allow,
    control.cronjob_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.cronjob_container_argument_kubelet_read_only_port_0,
    control.cronjob_container_argument_kube_controller_manager_root_ca_file_configured,
    control.cronjob_container_argument_etcd_client_cert_auth_enabled,
    control.cronjob_container_argument_namespace_lifecycle_enabled,
    control.cronjob_container_argument_service_account_lookup_enabled,
    control.cronjob_container_token_auth_file_not_configured,
    control.cronjob_container_kubelet_certificate_authority_configured,
    control.cronjob_container_argument_node_restriction_enabled,
    control.cronjob_container_argument_pod_security_policy_enabled,
    control.cronjob_container_argument_kube_apiserver_profiling_disabled,
    control.cronjob_container_argument_etcd_certfile_and_keyfile_configured,
    control.cronjob_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.cronjob_container_argument_secure_port_not_0,
    control.cronjob_container_argument_kube_controller_manager_bind_address_127_0_0_1,
  ]

  tags = merge(local.all_controls_cronjob_common_tags, {
    type = "Benchmark"
  })
}
