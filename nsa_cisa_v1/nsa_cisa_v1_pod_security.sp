benchmark "nsa_cisa_v1_pod_security" {
  title = "Kubernetes Pod Security"
  tags  = local.nsa_cisa_v1_common_tags
  children = [
    benchmark.nsa_cisa_v1_pod_security_container_disallow_host_path,
    benchmark.nsa_cisa_v1_pod_security_container_privilege_disabled,
    benchmark.nsa_cisa_v1_pod_security_container_privilege_escalation_disabled,
    benchmark.nsa_cisa_v1_pod_security_container_security_service_hardening,
    benchmark.nsa_cisa_v1_pod_security_host_network_access_disabled,
    benchmark.nsa_cisa_v1_pod_security_hostpid_hostipc_sharing_disabled,
    benchmark.nsa_cisa_v1_pod_security_immutable_container_filesystem,
    benchmark.nsa_cisa_v1_pod_security_non_root_container,
    benchmark.nsa_cisa_v1_pod_security_service_account_token_disabled,
  ]
}

benchmark "nsa_cisa_v1_pod_security_container_disallow_host_path" {
  title       = "Containers should not use hostPath mounts"
  description = "Containers should not able to access any specific paths of the host file system. There are many ways a container with unrestricted access to the host filesystem can escalate privileges, including reading data from other containers, and abusing the credentials of system services, such as Kubelet."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.pod_security_policy_allowed_host_path,
    control.pod_volume_host_path,
  ]
}

benchmark "nsa_cisa_v1_pod_security_container_privilege_disabled" {
  title       = "Containers should not have privileged access"
  description = "Containers should not have privileged access. To prevent security issues, it is recommended that you do not run privileged containers in your environment. Instead, provide granular permissions and capabilities to the container environment. Giving containers full access to the host can create security flaws in your production environment."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.cronjob_container_privilege_disabled,
    control.daemonset_container_privilege_disabled,
    control.deployment_container_privilege_disabled,
    control.job_container_privilege_disabled,
    control.pod_container_privilege_disabled,
    control.pod_security_policy_container_privilege_disabled,
    control.replicaset_container_privilege_disabled,
    control.replication_controller_container_privilege_disabled,
    control.statefulset_container_privilege_disabled,
  ]
}

benchmark "nsa_cisa_v1_pod_security_container_privilege_escalation_disabled" {
  title       = "Containers should not allow privilege escalation"
  description = "Containers should not allow privilege escalation. A container running with the `allowPrivilegeEscalation` flag set to true may have processes that can gain more privileges than their parent."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.cronjob_container_privilege_escalation_disabled,
    control.daemonset_container_privilege_escalation_disabled,
    control.deployment_container_privilege_escalation_disabled,
    control.job_container_privilege_escalation_disabled,
    control.pod_container_privilege_escalation_disabled,
    control.pod_security_policy_container_privilege_escalation_disabled,
    control.replicaset_container_privilege_escalation_disabled,
    control.replication_controller_container_privilege_escalation_disabled,
    control.statefulset_container_privilege_escalation_disabled,
  ]
}

benchmark "nsa_cisa_v1_pod_security_container_security_service_hardening" {
  title       = "Containerized applications should use security services"
  description = "Linux provides several out-of-the-box security modules. Some of the popular ones are SELinux, AppArmor and Seccomp. Containerized applications should use these security services."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.pod_security_policy_security_services_hardening,
  ]
}

benchmark "nsa_cisa_v1_pod_security_host_network_access_disabled" {
  title       = "Containers should not run with host network access"
  description = "Pod host network controls whether the Pod may use the node network namespace. Doing so gives the Pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other Pods on the same node."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.cronjob_host_network_access_disabled,
    control.daemonset_host_network_access_disabled,
    control.deployment_host_network_access_disabled,
    control.job_host_network_access_disabled,
    control.pod_host_network_access_disabled,
    control.pod_security_policy_host_network_access_disabled,
    control.replicaset_host_network_access_disabled,
    control.replication_controller_host_network_access_disabled,
    control.statefulset_host_network_access_disabled,
  ]
}

benchmark "nsa_cisa_v1_pod_security_hostpid_hostipc_sharing_disabled" {
  title       = "Containers should not share the host process namespace"
  description = "Containers should not share the host process PID or IPC namespace. Sharing the host’s process namespace allows the container to see all of the processes on the host system. This reduces the benefit of process level isolation between the host and the containers. Under these circumstances a malicious user who has access to a container could get access to processes on the host itself, manipulate them, and even be able to kill them."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.cronjob_hostpid_hostipc_sharing_disabled,
    control.daemonset_hostpid_hostipc_sharing_disabled,
    control.deployment_hostpid_hostipc_sharing_disabled,
    control.job_hostpid_hostipc_sharing_disabled,
    control.pod_hostpid_hostipc_sharing_disabled,
    control.pod_security_policy_hostpid_hostipc_sharing_disabled,
    control.replicaset_hostpid_hostipc_sharing_disabled,
    control.replication_controller_hostpid_hostipc_sharing_disabled,
    control.statefulset_hostpid_hostipc_sharing_disabled,
  ]
}

benchmark "nsa_cisa_v1_pod_security_immutable_container_filesystem" {
  title       = "Containers should run with a read only root file system"
  description = "Containers should always run with a read only root file system. Using an immutable root filesystem and a verified boot mechanism prevents against attackers from owning the machine through permanent local changes. An immutable root filesystem can also prevent malicious binaries from writing to the host system."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.cronjob_immutable_container_filesystem,
    control.daemonset_immutable_container_filesystem,
    control.deployment_immutable_container_filesystem,
    control.job_immutable_container_filesystem,
    control.pod_immutable_container_filesystem,
    control.pod_security_policy_immutable_container_filesystem,
    control.replicaset_immutable_container_filesystem,
    control.replication_controller_immutable_container_filesystem,
    control.statefulset_immutable_container_filesystem,
  ]
}

benchmark "nsa_cisa_v1_pod_security_non_root_container" {
  title       = "Containers should not run with root privileges"
  description = "Containers should not be deployed with root privileges. By default, many container services run as the privileged root user, and applications execute inside the container as root despite not requiring privileged execution. Preventing root execution by using non-root containers or a rootless container engine limits the impact of a container compromise."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.cronjob_non_root_container,
    control.daemonset_non_root_container,
    control.deployment_non_root_container,
    control.job_non_root_container,
    control.pod_non_root_container,
    control.pod_security_policy_non_root_container,
    control.replicaset_non_root_container,
    control.replication_controller_non_root_container,
    control.statefulset_non_root_container,
  ]
}

benchmark "nsa_cisa_v1_pod_security_service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled"
  description = local.service_account_token_disabled_desc
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.pod_service_account_token_disabled,
    control.service_account_token_disabled,
  ]
}
