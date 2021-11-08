benchmark "cis_benchmark_section_5" {
  title       = "cis benchmark section 5"
  description = "This section contains recommendations for various Kubernetes policies which are important to the security of the environment."
  tags        = local.extra_checks_tags
  children = [
    benchmark.default_namespace_not_used,
    benchmark.pod_security_non_root_container,
    benchmark.pod_security_container_privilege_disabled,
    benchmark.pod_security_hostpid_hostipc_sharing_disabled,
    benchmark.pod_security_host_network_access_disabled,
    benchmark.pod_security_container_privilege_escalation_disabled,
    benchmark.pod_security_service_account_token_disabled,
    control.pod_default_seccomp_profile_enabled,
  ]
}

benchmark "pod_security_container_privilege_disabled" {
  title       = "Containers should not have privileged access"
  description = "Containers should not have privileged access. To prevent security issues, it is recommended that you do not run privileged containers in your environment. Instead, provide granular permissions and capabilities to the container environment. Giving containers full access to the host can create security flaws in your production environment."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_container_privilege_disabled,
    control.deployment_container_privilege_disabled,
    control.job_container_privilege_disabled,
    control.pod_container_privilege_disabled,
    control.pod_security_policy_container_privilege_disabled,
    control.replicaset_container_privilege_disabled,
    control.replication_controller_container_privilege_disabled,
  ]
}

benchmark "pod_security_container_privilege_escalation_disabled" {
  title       = "Containers should not allow privilege escalation"
  description = "Containers should not allow privilege escalation. A container running with the `allowPrivilegeEscalation` flag set to true may have processes that can gain more privileges than their parent."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_container_privilege_escalation_disabled,
    control.deployment_container_privilege_escalation_disabled,
    control.job_container_privilege_escalation_disabled,
    control.pod_container_privilege_escalation_disabled,
    control.pod_security_policy_container_privilege_escalation_disabled,
    control.replicaset_container_privilege_escalation_disabled,
    control.replication_controller_container_privilege_escalation_disabled,
  ]
}

benchmark "pod_security_host_network_access_disabled" {
  title       = "Containers should not run with host network access"
  description = "Pod host network controls whether the Pod may use the node network namespace. Doing so gives the Pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other Pods on the same node."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_host_network_access_disabled,
    control.deployment_host_network_access_disabled,
    control.job_host_network_access_disabled,
    control.pod_host_network_access_disabled,
    control.pod_security_policy_host_network_access_disabled,
    control.replicaset_host_network_access_disabled,
    control.replication_controller_host_network_access_disabled,
  ]
}

benchmark "pod_security_hostpid_hostipc_sharing_disabled" {
  title       = "Containers should not share the host process namespace"
  description = "Containers should not share the host process PID or IPC namespace. Sharing the host’s process namespace allows the container to see all of the processes on the host system. This reduces the benefit of process level isolation between the host and the containers. Under these circumstances a malicious user who has access to a container could get access to processes on the host itself, manipulate them, and even be able to kill them."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.daemonset_hostpid_hostipc_sharing_disabled,
    control.deployment_hostpid_hostipc_sharing_disabled,
    control.job_hostpid_hostipc_sharing_disabled,
    control.pod_hostpid_hostipc_sharing_disabled,
    control.pod_security_policy_hostpid_hostipc_sharing_disabled,
    control.replicaset_hostpid_hostipc_sharing_disabled,
    control.replication_controller_hostpid_hostipc_sharing_disabled,
  ]
}

benchmark "pod_security_non_root_container" {
  title       = "Containers should not run with root privileges"
  description = "Containers should not be deployed with root privileges. By default, many container services run as the privileged root user, and applications execute inside the container as root despite not requiring privileged execution. Preventing root execution by using non-root containers or a rootless container engine limits the impact of a container compromise."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_non_root_container,
    control.deployment_non_root_container,
    control.job_non_root_container,
    control.pod_non_root_container,
    control.pod_security_policy_non_root_container,
    control.replicaset_non_root_container,
    control.replication_controller_non_root_container,
  ]
}

benchmark "pod_security_service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled"
  description = local.service_account_token_disabled_desc
  tags        = local.extra_checks_tags
  children = [
    control.pod_service_account_token_disabled,
    control.service_account_token_disabled,
  ]
}