benchmark "nsa_cisa_v1_pod_security" {
  title    = "NSA and CISA v1.0 Kubernetes Pod Security"
  tags     = local.nsa_cisa_v1_common_tags
  children = [
    benchmark.nsa_cisa_v1_container_disallow_host_path,
    benchmark.nsa_cisa_v1_container_privilege_disabled,
    benchmark.nsa_cisa_v1_container_privilege_escalation_disabled,
    benchmark.nsa_cisa_v1_host_network_access_disabled,
    benchmark.nsa_cisa_v1_hostpid_hostipc_namespace_privilege_disabled,
    benchmark.nsa_cisa_v1_immutable_container_filesystem,
    benchmark.nsa_cisa_v1_non_root_container,
    benchmark.nsa_cisa_v1_security_services_hardening,
    benchmark.nsa_cisa_v1_service_account_token_disabled,
  ]
}

// Container disallow host paths benchmark
benchmark "nsa_cisa_v1_container_disallow_host_path" {
  title       = "Containers should not use hostPath mounts"
  description = "Containers should not able to access any specific paths of the host file system.  There are many ways a container with unrestricted access to the host filesystem can escalate privileges, including reading data from other containers, and abusing the credentials of system services, such as Kubelet."
  tags        = local.nsa_cisa_v1_common_tags
  children    = [
    control.nsa_cisa_v1_pod_security_policy_allowed_host_path,
    control.nsa_cisa_v1_pod_volume_host_path,
  ]
}

locals {
  title_container_disallow_host_path = "__KIND__ containers should not allow privilege escalation"
  desc_container_disallow_host_path  = "Containers in a __KIND__ should not able to access any specific paths of the host file system. There are many ways a container with unrestricted access to the host filesystem can escalate privileges, including reading data from other containers, and abusing the credentials of system services, such as Kubelet."
}

control "nsa_cisa_v1_pod_security_policy_allowed_host_path" {
  title       = "Pod Security Policy should prohibit hostPaths volumes"
  description = "The Pod Security Policy `allowedHostPaths` specifies a list of host paths that are allowed to be used by hostPath volumes. An empty list means there is no restriction on host paths used. This is defined as a list of objects with a single pathPrefix field, which allows hostPath volumes to mount a path that begins with an allowed prefix, and a readOnly field indicating it must be mounted read-only."
  sql         = query.pod_security_policy_allowed_host_path.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_volume_host_path" {
  title       = replace(local.title_container_disallow_host_path, "__KIND__", "Pod")
  description = replace(local.desc_container_disallow_host_path, "__KIND__", "Pod")
  sql         = query.pod_volume_host_path.sql
  tags        = local.nsa_cisa_v1_common_tags
}

// Container privilege disabled benchmark
benchmark "nsa_cisa_v1_container_privilege_disabled" {
  title       = "Containers should not have privileged access"
  description = "Containers should not have privileged access. To prevent security issues, it is recommended that you do not run privileged containers in your environment. Instead, provide granular permissions and capabilities to the container environment. Giving containers full access to the host can create security flaws in your production environment."
  tags        = local.nsa_cisa_v1_common_tags
  children    = [
    control.nsa_cisa_v1_daemonset_container_privilege_disabled,
    control.nsa_cisa_v1_deployment_container_privilege_disabled,
    control.nsa_cisa_v1_job_container_privilege_disabled,
    control.nsa_cisa_v1_pod_container_privilege_disabled,
    control.nsa_cisa_v1_pod_security_policy_container_privilege_disabled,
    control.nsa_cisa_v1_replicaset_container_privilege_disabled,
    control.nsa_cisa_v1_replication_controller_container_privilege_disabled,
  ]
}

locals {
  title_container_privilege_disabled = "__KIND__ containers should not have privileged access"
  desc_container_privilege_disabled  = "Containers in a __KIND__ should not have privileged access. To prevent security issues, it is recommended that you do not run privileged containers in your environment. Instead, provide granular permissions and capabilities to the container environment. Giving containers full access to the host can create security flaws in your production environment."
}

control "nsa_cisa_v1_daemonset_container_privilege_disabled" {
  title       = replace(local.title_container_privilege_disabled, "__KIND__", "DaemonSet")
  description = replace(local.desc_container_privilege_disabled, "__KIND__", "DaemonSet")
  sql         = query.daemonset_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_deployment_container_privilege_disabled" {
  title       = replace(local.title_container_privilege_disabled, "__KIND__", "Deployment")
  description = replace(local.desc_container_privilege_disabled, "__KIND__", "Deployment")
  sql         = query.deployment_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_job_container_privilege_disabled" {
  title       = replace(local.title_container_privilege_disabled, "__KIND__", "Job")
  description = replace(local.desc_container_privilege_disabled, "__KIND__", "Job")
  sql         = query.job_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_container_privilege_disabled" {
  title       = replace(local.desc_container_privilege_disabled, "__KIND__", "Pod")
  description = replace(local.desc_container_privilege_disabled, "__KIND__", "Pod")
  sql         = query.pod_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_security_policy_container_privilege_disabled" {
  title       = "Pod Security Policy should prohibit containers to run with privilege access"
  description = "Pod Security Policy `privileged` controls whether the Pod containers may run with `privileged` access. ${replace(local.desc_container_privilege_disabled, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replicaset_container_privilege_disabled" {
  title       = replace(local.title_container_privilege_disabled, "__KIND__", "ReplicaSet")
  description = replace(local.desc_container_privilege_disabled, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replication_controller_container_privilege_disabled" {
  title       = replace(local.title_container_privilege_disabled, "__KIND__", "ReplicationController")
  description = replace(local.desc_container_privilege_disabled, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

// Container privilege escalation disabled benchmark
benchmark "nsa_cisa_v1_container_privilege_escalation_disabled" {
  title       = "Containers should not allow privilege escalation"
  description = "Containers should not allow privilege escalation. A container running with the `allowPrivilegeEscalation` flag set to true may have processes that can gain more privileges than their parent."
  tags        = local.nsa_cisa_v1_common_tags
  children    = [
    control.nsa_cisa_v1_daemonset_container_privilege_escalation_disabled,
    control.nsa_cisa_v1_deployment_container_privilege_escalation_disabled,
    control.nsa_cisa_v1_job_container_privilege_escalation_disabled,
    control.nsa_cisa_v1_pod_container_privilege_escalation_disabled,
    control.nsa_cisa_v1_pod_security_policy_container_privilege_escalation_disabled,
    control.nsa_cisa_v1_replicaset_container_privilege_escalation_disabled,
    control.nsa_cisa_v1_replication_controller_container_privilege_escalation_disabled,
  ]
}

locals {
  title_container_privilege_escalation_disabled = "__KIND__ containers should not allow privilege escalation"
  desc_container_privilege_escalation_disabled  = "Containers in a __KIND__ should not allow privilege escalation.  A container running with the `allowPrivilegeEscalation` flag set to true may have processes that can gain more privileges than their parent."
}

control "nsa_cisa_v1_daemonset_container_privilege_escalation_disabled" {
  title       = replace(local.title_container_privilege_escalation_disabled, "__KIND__", "DaemonSet")
  description = replace(local.desc_container_privilege_escalation_disabled, "__KIND__", "DaemonSet")
  sql         = query.daemonset_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_deployment_container_privilege_escalation_disabled" {
  title       = replace(local.title_container_privilege_escalation_disabled, "__KIND__", "Deployment")
  description = replace(local.desc_container_privilege_escalation_disabled, "__KIND__", "Deployment")
  sql         = query.deployment_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_job_container_privilege_escalation_disabled" {
  title       = replace(local.title_container_privilege_escalation_disabled, "__KIND__", "Job")
  description = replace(local.desc_container_privilege_escalation_disabled, "__KIND__", "Job")
  sql         = query.job_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_container_privilege_escalation_disabled" {
  title       = replace(local.title_container_privilege_escalation_disabled, "__KIND__", "Pod")
  description = replace(local.desc_container_privilege_escalation_disabled, "__KIND__", "Pod")
  sql         = query.pod_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_security_policy_container_privilege_escalation_disabled" {
  title       = "Pod Security Policy should prohibit privilege escalation"
  description = "Pod Security Policy `allowPrivilegeEscalation` controls whether the Pod containers may request for privilege escalation. ${replace(local.desc_container_privilege_escalation_disabled, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replicaset_container_privilege_escalation_disabled" {
  title       = replace(local.title_container_privilege_escalation_disabled, "__KIND__", "ReplicaSet")
  description = replace(local.desc_container_privilege_escalation_disabled, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replication_controller_container_privilege_escalation_disabled" {
  title       = replace(local.title_container_privilege_escalation_disabled, "__KIND__", "ReplicationController")
  description = replace(local.desc_container_privilege_escalation_disabled, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

// Host network access disabled benchmark
benchmark "nsa_cisa_v1_host_network_access_disabled" {
  title       = "Containers should not run with host network access"
  description = "Pod host network controls whether the Pod may use the node network namespace. Doing so gives the Pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other Pods on the same node."
  tags        = local.nsa_cisa_v1_common_tags
  children    = [
    control.nsa_cisa_v1_daemonset_host_network_access_disabled,
    control.nsa_cisa_v1_deployment_host_network_access_disabled,
    control.nsa_cisa_v1_job_host_network_access_disabled,
    control.nsa_cisa_v1_pod_host_network_access_disabled,
    control.nsa_cisa_v1_pod_security_policy_host_network_access_disabled,
    control.nsa_cisa_v1_replicaset_host_network_access_disabled,
    control.nsa_cisa_v1_replication_controller_host_network_access_disabled,
  ]
}

locals {
  title_host_network_access_disabled = "__KIND__ containers should not run with host network access"
  desc_host_network_access_disabled  = "Containers in a __KIND__ should not run in the host network of the node where the pod is deployed.  When running on the host network, the pod can use the network namespace and network resources of the node. In this case, the pod can access loopback devices, listen to addresses, and monitor the traffic of other pods on the node."
}

control "nsa_cisa_v1_daemonset_host_network_access_disabled" {
  title       = replace(local.title_host_network_access_disabled, "__KIND__", "DaemonSet")
  description = replace(local.desc_host_network_access_disabled, "__KIND__", "DaemonSet")
  sql         = query.daemonset_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_deployment_host_network_access_disabled" {
  title       = replace(local.title_host_network_access_disabled, "__KIND__", "Deployment")
  description = replace(local.desc_host_network_access_disabled, "__KIND__", "Deployment")
  sql         = query.deployment_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_job_host_network_access_disabled" {
  title       = replace(local.title_host_network_access_disabled, "__KIND__", "Job")
  description = replace(local.desc_host_network_access_disabled, "__KIND__", "Job")
  sql         = query.job_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_host_network_access_disabled" {
  title       = replace(local.title_host_network_access_disabled, "__KIND__", "Pod")
  description = replace(local.desc_host_network_access_disabled, "__KIND__", "Pod")
  sql         = query.pod_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_security_policy_host_network_access_disabled" {
  title       = "Pod Security Policy should prohibit host network access "
  description = "Pod Security Policy host network controls whether the Pod may use the node network namespace. Doing so gives the Pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other Pods on the same node."
  sql         = query.pod_security_policy_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replicaset_host_network_access_disabled" {
  title       = replace(local.title_host_network_access_disabled, "__KIND__", "ReplicaSet")
  description = replace(local.desc_host_network_access_disabled, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replication_controller_host_network_access_disabled" {
  title       = replace(local.title_host_network_access_disabled, "__KIND__", "ReplicationController")
  description = replace(local.desc_host_network_access_disabled, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

// Host process namespace privilege disabled benchmark
benchmark "nsa_cisa_v1_hostpid_hostipc_namespace_privilege_disabled" {
  title       = "Containers should not share the host process namespace"
  description = "Containers should not share the host process PID or IPC namespace.  Sharing the host’s process namespace allows the container to see all of the processes on the host system. This reduces the benefit of process level isolation between the host and the containers. Under these circumstances a malicious user who has access to a container could get access to processes on the host itself, manipulate them, and even be able to kill them."
  tags        = local.nsa_cisa_v1_common_tags
  children    = [
    control.nsa_cisa_v1_pod_security_policy_hostpid_hostipc_namespace_privilege_disabled,
    control.nsa_cisa_v1_pod_hostpid_hostipc_namespace_privilege_disabled,
    control.nsa_cisa_v1_daemonset_hostpid_hostipc_namespace_privilege_disabled,
    control.nsa_cisa_v1_deployment_hostpid_hostipc_namespace_privilege_disabled,
    control.nsa_cisa_v1_job_hostpid_hostipc_namespace_privilege_disabled,
    control.nsa_cisa_v1_replicaset_hostpid_hostipc_namespace_privilege_disabled,
    control.nsa_cisa_v1_replication_controller_hostpid_hostipc_namespace_privilege_disabled,
  ]
}

locals {
  title_hostpid_hostipc_namespace_privilege_disabled = "__KIND__ containers should not share the host process namespace"
  desc_hostpid_hostipc_namespace_privilege_disabled  = "Containers in a __KIND__ should not share the host process PID or IPC namespace.  Sharing the host’s process namespace allows the container to see all of the processes on the host system. This reduces the benefit of process level isolation between the host and the containers. Under these circumstances a malicious user who has access to a container could get access to processes on the host itself, manipulate them, and even be able to kill them."
}

control "nsa_cisa_v1_daemonset_hostpid_hostipc_namespace_privilege_disabled" {
  title       = replace(local.title_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "DaemonSet")
  description = replace(local.desc_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "DaemonSet")
  sql         = query.daemonset_hostpid_hostipc_namespace_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_deployment_hostpid_hostipc_namespace_privilege_disabled" {
  title       = replace(local.title_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "Deployment")
  description = replace(local.desc_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "Deployment")
  sql         = query.deployment_hostpid_hostipc_namespace_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_job_hostpid_hostipc_namespace_privilege_disabled" {
  title       = replace(local.title_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "Job")
  description = replace(local.desc_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "Job")
  sql         = query.job_hostpid_hostipc_namespace_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_hostpid_hostipc_namespace_privilege_disabled" {
  title       = replace(local.title_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "Pod")
  description = replace(local.desc_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "Pod")
  sql         = query.pod_hostpid_hostipc_namespace_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_security_policy_hostpid_hostipc_namespace_privilege_disabled" {
  title       = "Pod Security Policy should prohibit containers from sharing the host process namespaces"
  description = "Pod Security Policy `hostPID` and `hostIPC` controls whether the Pod may share the host process namespaces. ${replace(local.desc_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_hostpid_hostipc_namespace_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replicaset_hostpid_hostipc_namespace_privilege_disabled" {
  title       = replace(local.title_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "ReplicaSet")
  description = replace(local.desc_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_hostpid_hostipc_namespace_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replication_controller_hostpid_hostipc_namespace_privilege_disabled" {
  title       = replace(local.title_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "ReplicationController")
  description = replace(local.desc_hostpid_hostipc_namespace_privilege_disabled, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_hostpid_hostipc_namespace_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

// Immutable container filesystem benchmark
benchmark "nsa_cisa_v1_immutable_container_filesystem" {
  title       = "Containers should run with a read only root file system"
  description = "Containers should always run with a read only root file system. Using an immutable root filesystem and a verified boot mechanism prevents against attackers from owning the machine through permanent local changes. An immutable root filesystem can also prevent malicious binaries from writing to the host system."
  tags        = local.nsa_cisa_v1_common_tags
  children    = [
    control.nsa_cisa_v1_daemonset_immutable_container_filesystem,
    control.nsa_cisa_v1_deployment_immutable_container_filesystem,
    control.nsa_cisa_v1_job_immutable_container_filesystem,
    control.nsa_cisa_v1_pod_immutable_container_filesystem,
    control.nsa_cisa_v1_pod_security_policy_immutable_container_filesystem,
    control.nsa_cisa_v1_replicaset_immutable_container_filesystem,
    control.nsa_cisa_v1_replication_controller_immutable_container_filesystem,
  ]
}

locals {
  title_immutable_container_filesystem = "__KIND__ containers should run with a read only root file system"
  desc_immutable_container_filesystem  = "Containers in a __KIND__ should always run with a read only root file system. Using an immutable root filesystem and a verified boot mechanism prevents against attackers from owning the machine through permanent local changes. An immutable root filesystem can also prevent malicious binaries from writing to the host system."
}

control "nsa_cisa_v1_daemonset_immutable_container_filesystem" {
  title       = replace(local.title_immutable_container_filesystem, "__KIND__", "DaemonSet")
  description = replace(local.desc_immutable_container_filesystem, "__KIND__", "DaemonSet")
  sql         = query.daemonset_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_deployment_immutable_container_filesystem" {
  title       = replace(local.title_immutable_container_filesystem, "__KIND__", "Deployment")
  description = replace(local.desc_immutable_container_filesystem, "__KIND__", "Deployment")
  sql         = query.deployment_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_job_immutable_container_filesystem" {
  title       = replace(local.title_immutable_container_filesystem, "__KIND__", "Job")
  description = replace(local.desc_immutable_container_filesystem, "__KIND__", "Job")
  sql         = query.job_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_immutable_container_filesystem" {
  title       = replace(local.desc_immutable_container_filesystem, "__KIND__", "Pod")
  description = replace(local.desc_immutable_container_filesystem, "__KIND__", "Pod")
  sql         = query.pod_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_security_policy_immutable_container_filesystem" {
  title       = "Pod Security Policy should force containers to run with read only root file system"
  description = "Pod Security Policy `readOnlyRootFilesystem` controls whether the Pod containers run with read only root file system. ${replace(local.desc_immutable_container_filesystem, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replicaset_immutable_container_filesystem" {
  title       = replace(local.title_immutable_container_filesystem, "__KIND__", "ReplicaSet")
  description = replace(local.desc_immutable_container_filesystem, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replication_controller_immutable_container_filesystem" {
  title       = replace(local.title_immutable_container_filesystem, "__KIND__", "ReplicationController")
  description = replace(local.desc_immutable_container_filesystem, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

// Non root container benchmark
benchmark "nsa_cisa_v1_non_root_container" {
  title       = "Containers should not run with root privileges"
  description = "Containers should not be deployed with root privileges. By default, many container services run as the privileged root user, and applications execute inside the container as root despite not requiring privileged execution. Preventing root execution by using non-root containers or a rootless container engine limits the impact of a container compromise."
  tags        = local.nsa_cisa_v1_common_tags
  children    = [
    control.nsa_cisa_v1_daemonset_non_root_container,
    control.nsa_cisa_v1_deployment_non_root_container,
    control.nsa_cisa_v1_job_non_root_container,
    control.nsa_cisa_v1_pod_non_root_container,
    control.nsa_cisa_v1_pod_security_policy_run_as_non_root,
    control.nsa_cisa_v1_replicaset_non_root_container,
    control.nsa_cisa_v1_replication_controller_non_root_container,
  ]
}

locals {
  title_non_root_container = "__KIND__ containers should not run with root privileges"
  desc_non_root_container  = "Containers in a __KIND__ should not run with root privileges. By default, many container services run as the privileged root user, and applications execute inside the container as root despite not requiring privileged execution. Preventing root execution by using non-root containers or a rootless container engine limits the impact of a container compromise."
}

control "nsa_cisa_v1_daemonset_non_root_container" {
  title       = replace(local.title_non_root_container, "__KIND__", "DaemonSet")
  description = replace(local.desc_non_root_container, "__KIND__", "DaemonSet")
  sql         = query.daemonset_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_deployment_non_root_container" {
  title       = replace(local.title_non_root_container, "__KIND__", "Deployment")
  description = replace(local.desc_non_root_container, "__KIND__", "Deployment")
  sql         = query.deployment_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_job_non_root_container" {
  title       = replace(local.title_non_root_container, "__KIND__", "Job")
  description = replace(local.desc_non_root_container, "__KIND__", "Job")
  sql         = query.job_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_non_root_container" {
  title       = replace(local.title_non_root_container, "__KIND__", "Pod")
  description = replace(local.desc_non_root_container, "__KIND__", "Pod")
  sql         = query.pod_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_pod_security_policy_run_as_non_root" {
  title       = "Pod Security Policy should prohibit containers from running as root"
  description = "Pod Security Policy should prohibit containers from running as root.  ${replace(local.desc_non_root_container, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_run_as_non_root.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replicaset_non_root_container" {
  title       = replace(local.title_non_root_container, "__KIND__", "ReplicaSet")
  description = replace(local.desc_non_root_container, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_replication_controller_non_root_container" {
  title       = replace(local.title_non_root_container, "__KIND__", "ReplicationController")
  description = replace(local.desc_non_root_container, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}

// Security services hardening benchmark
benchmark "nsa_cisa_v1_security_services_hardening" {
  title       = "Containerized applications should use security services"
  description = "Linux provides several out-of-the-box security modules. Some of the popular ones are SELinux, AppArmor and Seccomp. Containerized applications should use these security services."
  tags        = local.nsa_cisa_v1_common_tags
  children    = [
    control.nsa_cisa_v1_pod_security_policy_security_services_hardening,
  ]
}

control "nsa_cisa_v1_pod_security_policy_security_services_hardening" {
  title       = "Containerized applications should use security services such as SELinux or AppArmor or Seccomp"
  description = "The underlying host OS needs to be secured in order to prevent container breaches from affecting the host. For this, Linux provides several out-of-the-box security modules. Some of the popular ones are SELinux, AppArmor and Seccomp."
  sql         = query.pod_security_policy_security_services_hardening.sql
  tags        = local.nsa_cisa_v1_common_tags
}

// Service account token disabled benchmark
benchmark "nsa_cisa_v1_service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled"
  description = local.desc_service_account_token_disabled
  tags        = local.nsa_cisa_v1_common_tags
  children    = [
    control.nsa_cisa_v1_pod_service_account_token_disabled,
    control.nsa_cisa_v1_service_account_token_disabled,
  ]
}

locals {
  desc_service_account_token_disabled = "Automatic mapping of service account token should be disabled. By default, Kubernetes automatically provisions a service account when creating a Pod and mounts the account’s secret token within the Pod at runtime. Many containerized applications do not require direct access to the service account as Kubernetes orchestration occurs transparently in the background. If an application is compromised, account tokens in Pods can be gleaned by cyber actors and used to further compromise the cluster. When an application does not need to access the service account directly, Kubernetes administrators should ensure that Pod specifications disable the secret token being mounted. This can be accomplished using the `automountServiceAccountToken: false` directive in the Pod’s YAML specification."
}

control "nsa_cisa_v1_pod_service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled in Pod"
  description = local.desc_service_account_token_disabled
  sql         = query.pod_service_account_token_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "nsa_cisa_v1_service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled in service account"
  description = local.desc_service_account_token_disabled
  sql         = query.service_account_token_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}
