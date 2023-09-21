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
    control.job_container_arg_peer_client_cert_auth_enabled,
    control.job_container_argument_event_qps_less_than_5,
    control.job_container_capabilities_drop_all,
    control.job_container_encryption_providers_configured,
    control.job_container_image_pull_policy_always,
    control.job_container_image_tag_specified,
    control.job_container_liveness_probe,
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
    control.job_container_argument_audit_log_maxage_greater_than_30,
    control.job_container_argument_audit_log_maxbackup_greater_than_10,
    control.job_container_argument_audit_log_maxsize_greater_than_100,
    control.job_container_no_argument_basic_auth_file,
    control.job_container_argument_etcd_cafile_configured,
  ]

  tags = merge(local.all_controls_job_common_tags, {
    type = "Benchmark"
  })
}
