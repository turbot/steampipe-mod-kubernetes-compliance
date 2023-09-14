locals {
  all_controls_statefulset_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/StatefulSet"
  })
}

benchmark "all_controls_statefulset" {
  title       = "StatefulSet"
  description = "This section contains recommendations for configuring StatefulSet resources."
  children = [
    control.statefulset_container_admission_capability_restricted,
    control.statefulset_container_arg_peer_client_cert_auth_enabled,
    control.statefulset_container_argument_event_qps_less_than_5,
    control.statefulset_container_capabilities_drop_all,
    control.statefulset_container_encryption_providers_configured,
    control.statefulset_container_image_pull_policy_always,
    control.statefulset_container_image_tag_specified,
    control.statefulset_container_liveness_probe,
    control.statefulset_container_privilege_disabled,
    control.statefulset_container_privilege_escalation_disabled,
    control.statefulset_container_privilege_port_mapped,
    control.statefulset_container_readiness_probe,
    control.statefulset_container_rotate_certificate_enabled,
    control.statefulset_container_security_context_exists,
    control.statefulset_container_sys_admin_capability_disabled,
    control.statefulset_container_with_added_capabilities,
    control.statefulset_cpu_limit,
    control.statefulset_cpu_request,
    control.statefulset_default_namespace_used,
    control.statefulset_default_seccomp_profile_enabled,
    control.statefulset_host_network_access_disabled,
    control.statefulset_hostpid_hostipc_sharing_disabled,
    control.statefulset_immutable_container_filesystem,
    control.statefulset_memory_limit,
    control.statefulset_memory_request,
    control.statefulset_non_root_container
  ]

  tags = merge(local.all_controls_statefulset_common_tags, {
    type = "Benchmark"
  })
}
