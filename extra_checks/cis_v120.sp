benchmark "cis_v120" {
  title       = "CIS v1.2.0"
  description = "This document provides prescriptive guidance for establishing a secure configuration posture for Kubernetes 1.19 - 1.20."
  tags        = local.extra_checks_tags
  children = [
    benchmark.cis_v120_5
  ]
}

benchmark "cis_v120_5" {
  title       = "5 Policies"
  description = "This section contains recommendations for various Kubernetes policies which are important to the security of the environment."
  tags        = local.extra_checks_tags
  children = [
    benchmark.cis_v120_5_1_6,
    benchmark.cis_v120_5_2_1,
    benchmark.cis_v120_5_2_2,
    benchmark.cis_v120_5_2_3,
    benchmark.cis_v120_5_2_4,
    benchmark.cis_v120_5_2_5,
    benchmark.cis_v120_5_2_6,
    benchmark.cis_v120_5_3_2,
    benchmark.cis_v120_5_7_2,
    benchmark.cis_v120_5_7_4,
  ]
}

benchmark "cis_v120_5_3_2" {
  title       = "5.3.2 Ensure that all Namespaces have Network Policies defined"
  description = "Administrators should use default policies to isolate traffic in your cluster network."
  tags        = local.extra_checks_tags
  children = [
    control.network_policy_default_deny_egress,
    control.network_policy_default_deny_ingress,
    control.network_policy_default_dont_allow_egress,
    control.network_policy_default_dont_allow_ingress,
  ]
}

benchmark "cis_v120_5_7_4" {
  title       = "5.7.4 The default namespace should not be used"
  description = "Kubernetes provides a default namespace, where objects are placed if no namespace is specified for them. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_default_namesapce_used,
    control.deployment_default_namesapce_used,
    control.job_default_namesapce_used,
    control.pod_default_namesapce_used,
    control.replicaset_default_namesapce_used,
    control.replication_controller_default_namesapce_used,
    control.service_default_namesapce_used,
  ]
}

benchmark "cis_v120_5_2_1" {
  title       = "5.2.1 Minimize the admission of privileged containers"
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

benchmark "cis_v120_5_2_5" {
  title       = "5.2.5 Minimize the admission of containers with allowPrivilegeEscalation"
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

benchmark "cis_v120_5_2_4" {
  title       = "5.2.4 Minimize the admission of containers wishing to share the host network namespace"
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

benchmark "cis_v120_5_2_2" {
  title       = "5.2.2 Minimize the admission of containers wishing to share the host process ID namespace"
  description = "Containers should not share the host process PID namespace. Sharing the host’s process namespace allows the container to see all of the processes on the host system. This reduces the benefit of process level isolation between the host and the containers. Under these circumstances a malicious user who has access to a container could get access to processes on the host itself, manipulate them, and even be able to kill them."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_hostpid_sharing_disabled,
    control.deployment_hostpid_sharing_disabled,
    control.job_hostpid_sharing_disabled,
    control.pod_hostpid_sharing_disabled,
    control.pod_security_policy_hostpid_sharing_disabled,
    control.replicaset_hostpid_sharing_disabled,
    control.replication_controller_hostpid_sharing_disabled,
  ]
}

benchmark "cis_v120_5_2_3" {
  title       = "5.2.3 Minimize the admission of containers wishing to share the host IPC namespace"
  description = "Containers should not share the host process IPC namespace. Sharing the host’s process namespace allows the container to see all of the processes on the host system. This reduces the benefit of process level isolation between the host and the containers. Under these circumstances a malicious user who has access to a container could get access to processes on the host itself, manipulate them, and even be able to kill them."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_hostipc_sharing_disabled,
    control.deployment_hostipc_sharing_disabled,
    control.job_hostipc_sharing_disabled,
    control.pod_hostipc_sharing_disabled,
    control.pod_security_policy_hostipc_sharing_disabled,
    control.replicaset_hostipc_sharing_disabled,
    control.replication_controller_hostipc_sharing_disabled,
  ]
}

benchmark "cis_v120_5_2_6" {
  title       = "5.2.6 Minimize the admission of root containers"
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

benchmark "cis_v120_5_1_6" {
  title       = "5.1.6 Ensure that Service Account Tokens are only mounted where necessary"
  description = local.service_account_token_disabled_desc
  tags        = local.extra_checks_tags
  children = [
    control.pod_service_account_token_disabled,
    control.service_account_token_disabled,
  ]
}

benchmark "cis_v120_5_7_2" {
  title       = "5.7.2 Ensure that the seccomp profile is set to docker/default in your Pod definitions"
  description = "Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  tags        = local.extra_checks_tags
  children = [
    control.pod_default_seccomp_profile_enabled,
  ]
}