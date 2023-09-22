locals {
  all_controls_deployment_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Deployment"
  })
}

benchmark "all_controls_deployment" {
  title       = "Deployment"
  description = "This section contains recommendations for configuring Deployment resources."
  children = [
    control.deployment_container_admission_capability_restricted,
    control.deployment_container_admission_control_plugin_always_pull_images,
    control.deployment_container_admission_control_plugin_no_always_admit,
    control.deployment_container_arg_peer_client_cert_auth_enabled,
    control.deployment_container_argument_anonymous_auth_disabled,
    control.deployment_container_argument_audit_log_maxage_greater_than_30,
    control.deployment_container_argument_audit_log_maxbackup_greater_than_10,
    control.deployment_container_argument_audit_log_maxsize_greater_than_100,
    control.deployment_container_argument_audit_log_path_configured,
    control.deployment_container_argument_authorization_mode_no_always_allow,
    control.deployment_container_argument_authorization_mode_node,
    control.deployment_container_argument_authorization_mode_rbac,
    control.deployment_container_argument_etcd_cafile_configured,
    control.deployment_container_argument_etcd_certfile_and_keyfile_configured,
    control.deployment_container_argument_event_qps_less_than_5,
    control.deployment_container_argument_insecure_port_0,
    control.deployment_container_argument_kubelet_client_certificate_and_key_configured,
    control.deployment_container_argument_kubelet_https_enabled,
    control.deployment_container_capabilities_drop_all,
    control.deployment_container_encryption_providers_configured,
    control.deployment_container_image_pull_policy_always,
    control.deployment_container_image_tag_specified,
    control.deployment_container_liveness_probe,
    control.deployment_container_no_argument_basic_auth_file,
    control.deployment_container_no_argument_insecure_bind_address,
    control.deployment_container_privilege_disabled,
    control.deployment_container_privilege_escalation_disabled,
    control.deployment_container_privilege_port_mapped,
    control.deployment_container_readiness_probe,
    control.deployment_container_rotate_certificate_enabled,
    control.deployment_container_security_context_exists,
    control.deployment_container_sys_admin_capability_disabled,
    control.deployment_container_with_added_capabilities,
    control.deployment_cpu_limit,
    control.deployment_cpu_request,
    control.deployment_default_namespace_used,
    control.deployment_default_seccomp_profile_enabled,
    control.deployment_host_network_access_disabled,
    control.deployment_hostpid_hostipc_sharing_disabled,
    control.deployment_immutable_container_filesystem,
    control.deployment_memory_limit,
    control.deployment_memory_request,
    control.deployment_non_root_container,
    control.deployment_replica_minimum_3,
  ]

  tags = merge(local.all_controls_deployment_common_tags, {
    type = "Benchmark"
  })
}
