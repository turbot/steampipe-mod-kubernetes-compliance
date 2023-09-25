locals {
  all_controls_pod_template_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/PodTemplate"
  })
}

benchmark "all_controls_cronjob" {
  title       = "CronJob"
  description = "This section contains recommendations for configuring CronJob resources."

  children = [
    control.pod_template_container_privilege_escalation_disabled,
    control.pod_template_container_with_added_capabilities,
    control.pod_template_container_sys_admin_capability_disabled,
    control.pod_template_container_admission_control_plugin_no_always_admit,
    control.pod_template_container_admission_control_plugin_always_pull_images,
    control.pod_template_container_argument_anonymous_auth_disabled,
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
    control.pod_template_container_no_argument_insecure_bind_address
  ]

  tags = merge(local.all_controls_pod_template_common_tags, {
    type = "Benchmark"
  })
}
