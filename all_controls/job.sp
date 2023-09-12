locals {
  all_controls_job_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Job"
  })
}

benchmark "all_controls_job" {
  title       = "Job"
  description = "This section contains recommendations for configuring Job resources."
  children = [
    control.job_container_liveness_probe,
    control.job_container_privilege_disabled,
    control.job_container_privilege_escalation_disabled,
    control.job_container_privilege_port_mapped,
    control.job_container_readiness_probe,
    control.job_container_security_context_exists,
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
    control.job_non_root_container
  ]

  tags = merge(local.all_controls_job_common_tags, {
    type = "Benchmark"
  })
}
