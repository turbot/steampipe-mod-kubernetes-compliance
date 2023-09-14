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
    control.cronjob_container_arg_peer_client_cert_auth_enabled,
    control.cronjob_container_argument_event_qps_less_than_5,
    control.cronjob_container_capabilities_drop_all,
    control.cronjob_container_encryption_providers_configured,
    control.cronjob_container_image_pull_policy_always,
    control.cronjob_container_image_tag_specified,
    control.cronjob_container_liveness_probe,
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
    control.cronjob_non_root_container
  ]

  tags = merge(local.all_controls_cronjob_common_tags, {
    type = "Benchmark"
  })
}
