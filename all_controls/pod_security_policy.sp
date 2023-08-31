locals {
  all_controls_pod_security_policy_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/PodSecurityPolicy"
  })
}

benchmark "all_controls_pod_security_policy" {
  title       = "Pod Security Policy"
  description = "This section contains recommendations for configuring Pod Security Policy resources."
  children = [
    control.pod_security_policy_allowed_host_path,
    control.pod_security_policy_container_privilege_disabled,
    control.pod_security_policy_container_privilege_escalation_disabled,
    control.pod_security_policy_default_seccomp_profile_enabled,
    control.pod_security_policy_host_network_access_disabled,
    control.pod_security_policy_hostipc_sharing_disabled,
    control.pod_security_policy_hostpid_hostipc_sharing_disabled,
    control.pod_security_policy_hostpid_sharing_disabled,
    control.pod_security_policy_immutable_container_filesystem,
    control.pod_security_policy_non_root_container,
    control.pod_security_policy_security_services_hardening,
  ]

  tags = merge(local.all_controls_pod_security_policy_common_tags, {
    type = "Benchmark"
  })
}
