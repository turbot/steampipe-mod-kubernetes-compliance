locals {
  all_controls_pod_template_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/PodTemplate"
  })
}

benchmark "all_controls_pod_template" {
  title       = "PodTemplate"
  description = "This section contains recommendations for configuring PodTemplate resources."

  children = [
    control.pod_template_container_privilege_escalation_disabled,
    control.pod_template_container_with_added_capabilities,
    control.pod_template_container_sys_admin_capability_disabled,
    control.pod_template_container_admission_control_plugin_no_always_admit,
    control.pod_template_container_admission_control_plugin_always_pull_images,
    control.pod_template_container_argument_api_server_anonymous_auth_disabled,
    control.pod_template_container_argument_audit_log_path_configured,
    control.pod_template_container_argument_audit_log_maxage_greater_than_30,
    control.pod_template_container_argument_audit_log_maxbackup_greater_than_10,
    control.pod_template_container_argument_audit_log_maxsize_greater_than_100,
    control.pod_template_container_argument_authorization_mode_node,
    control.pod_template_container_argument_authorization_mode_no_always_allow,
    control.pod_template_container_argument_authorization_mode_rbac,
    control.pod_template_container_no_argument_basic_auth_file,
    control.pod_template_container_encryption_providers_configured,
    control.pod_template_container_argument_etcd_cafile_configured,
    control.pod_template_container_argument_etcd_certfile_and_keyfile_configured,
    control.pod_template_container_no_argument_insecure_bind_address,
    control.pod_template_container_argument_insecure_port_0,
    control.pod_template_container_argument_kubelet_client_certificate_and_key_configured,
    control.pod_template_container_argument_kubelet_https_enabled,
    control.pod_template_cpu_limit,
    control.pod_template_cpu_request,
    control.pod_template_container_security_context_exists,
    control.pod_template_container_admission_capability_restricted,
    control.pod_template_container_image_pull_policy_always,
    control.pod_template_container_image_tag_specified,
    control.pod_template_container_argument_kubelet_anonymous_auth_disabled,
    control.pod_template_container_argument_event_qps_less_than_5,
    control.pod_template_container_rotate_certificate_enabled,
    control.pod_template_container_liveness_probe,
    control.pod_template_memory_limit,
    control.pod_template_memory_request,
    control.pod_template_container_capabilities_drop_all,
    control.pod_template_container_privilege_disabled,
    control.pod_template_immutable_container_filesystem,
    control.pod_template_container_readiness_probe
  ]

  tags = merge(local.all_controls_pod_template_common_tags, {
    type = "Benchmark"
  })
}
