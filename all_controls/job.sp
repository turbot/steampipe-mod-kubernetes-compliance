locals {
  all_controls_job_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Job"
  })
}

benchmark "all_controls_job" {
  title       = "Job"
  description = "This section contains recommendations for configuring Job resources."
  children = [
    control.job_container_admission_capability_restricted,
    control.job_container_admission_control_plugin_always_pull_images,
    control.job_container_admission_control_plugin_no_always_admit,
    control.job_container_arg_peer_client_cert_auth_enabled,
    control.job_container_argument_anonymous_auth_disabled,
    control.job_container_argument_audit_log_maxage_greater_than_30,
    control.job_container_argument_audit_log_maxbackup_greater_than_10,
    control.job_container_argument_audit_log_maxsize_greater_than_100,
    control.job_container_argument_audit_log_path_configured,
    control.job_container_argument_authorization_mode_no_always_allow,
    control.job_container_argument_authorization_mode_node,
    control.job_container_argument_authorization_mode_rbac,
    control.job_container_argument_etcd_cafile_configured,
    control.job_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.job_container_argument_event_qps_less_than_5,
    control.job_container_argument_insecure_port_0,
    control.job_container_argument_kubelet_client_certificate_and_key_configured,
    control.job_container_argument_kubelet_https_enabled,
    control.job_container_capabilities_drop_all,
    control.job_container_encryption_providers_configured,
    control.job_container_image_pull_policy_always,
    control.job_container_image_tag_specified,
    control.job_container_liveness_probe,
    control.job_container_no_argument_basic_auth_file,
    control.job_container_no_argument_insecure_bind_address,
    control.job_container_privilege_disabled,
    control.job_container_privilege_escalation_disabled,
    control.job_container_privilege_port_mapped,
    control.job_container_readiness_probe,
    control.job_container_rotate_certificate_enabled,
    control.job_container_security_context_exists,
    control.job_container_sys_admin_capability_disabled,
    control.job_container_with_added_capabilities,
    control.job_cpu_limit,
    control.job_cpu_request,
    control.job_default_namespace_used,
    control.job_default_seccomp_profile_enabled,
    control.job_host_network_access_disabled,
    control.job_hostpid_hostipc_sharing_disabled,
    control.job_immutable_container_filesystem,
    control.job_memory_limit,
    control.job_memory_request,
    control.job_non_root_container,
    control.job_container_argument_kube_scheduler_profiling_disabled,
    control.job_container_argument_kube_scheduler_bind_address_127_0_0_1,
    control.job_container_argument_protect_kernel_defaults_enabled,
    control.job_container_argument_make_iptables_util_chains_enabled,
    control.job_container_argument_tls_cert_file_and_tls_private_key_file_configured,
    control.job_container_no_argument_hostname_override_configured,
    control.job_container_argument_kube_controller_manager_profiling_disabled,
    control.job_container_argument_etcd_auto_tls_disabled,
    control.job_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.job_container_argument_kubelet_authorization_mode_no_always_allow,
    control.job_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.job_container_argument_kubelet_read_only_port_0,
    control.job_container_argument_kube_controller_manager_root_ca_file_configured,
    control.job_container_argument_etcd_client_cert_auth_enabled,
    control.job_container_argument_namespace_lifecycle_enabled,
    control.job_container_argument_service_account_lookup_enabled,
    control.job_container_token_auth_file_not_configured,
    control.job_container_kubelet_certificate_authority_configured,
    control.job_container_argument_node_restriction_enabled,
    control.job_container_argument_pod_security_policy_enabled,
    control.job_container_argument_kube_apiserver_profiling_disabled,
    control.job_container_argument_etcd_certfile_and_keyfile_configured,
    control.job_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.job_container_argument_secure_port_not_0,
  ]

  tags = merge(local.all_controls_job_common_tags, {
    type = "Benchmark"
  })
}
