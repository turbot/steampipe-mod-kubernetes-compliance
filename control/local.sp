locals {
  container_cpu_limit_title = "__KIND__ containers should have a CPU limit"
  container_cpu_limit_desc  = "Containers in a __KIND__  should have CPU limit which restricts the container to use no more than a given amount of CPU."

  container_cpu_request_title = "__KIND__ containers should have a CPU request"
  container_cpu_request_desc  = "Containers in a __KIND__ should have CPU request. If required Kubernetes will make sure your containers get the CPU they requested."

  container_memory_limit_title = "__KIND__ containers should have a memory limit"
  container_memory_limit_desc  = "Containers in a __KIND__ should have memory limit which restricts the container to use no more than a given amount of user or system memory."

  container_memory_request_title = "__KIND__ containers should have a memory request"
  container_memory_request_desc  = "Containers in a __KIND__ should have memory request. If required Kubernetes will make sure your containers get the memory they requested."

  container_disallow_host_path_title = "__KIND__ containers should not allow privilege escalation"
  container_disallow_host_path_desc  = "Containers in a __KIND__ should not able to access any specific paths of the host file system. There are many ways a container with unrestricted access to the host filesystem can escalate privileges, including reading data from other containers, and abusing the credentials of system services, such as Kubelet."

  container_privilege_disabled_title = "__KIND__ containers should not have privileged access"
  container_privilege_disabled_desc  = "Containers in a __KIND__ should not have privileged access. To prevent security issues, it is recommended that you do not run privileged containers in your environment. Instead, provide granular permissions and capabilities to the container environment. Giving containers full access to the host can create security flaws in your production environment."

  container_privilege_escalation_disabled_title = "__KIND__ containers should not allow privilege escalation"
  container_privilege_escalation_disabled_desc  = "Containers in a __KIND__ should not allow privilege escalation.  A container running with the `allowPrivilegeEscalation` flag set to true may have processes that can gain more privileges than their parent."

  host_network_access_disabled_title = "__KIND__ containers should not run with host network access"
  host_network_access_disabled_desc  = "Containers in a __KIND__ should not run in the host network of the node where the pod is deployed.  When running on the host network, the pod can use the network namespace and network resources of the node. In this case, the pod can access loopback devices, listen to addresses, and monitor the traffic of other pods on the node."

  hostpid_hostipc_sharing_disabled_title = "__KIND__ containers should not share the host process namespace"
  hostpid_hostipc_sharing_disabled_desc  = "Containers in a __KIND__ should not share the host process PID or IPC namespace.  Sharing the host’s process namespace allows the container to see all of the processes on the host system. This reduces the benefit of process level isolation between the host and the containers. Under these circumstances a malicious user who has access to a container could get access to processes on the host itself, manipulate them, and even be able to kill them."

  immutable_container_filesystem_title = "__KIND__ containers should run with a read only root file system"
  immutable_container_filesystem_desc  = "Containers in a __KIND__ should always run with a read only root file system. Using an immutable root filesystem and a verified boot mechanism prevents against attackers from owning the machine through permanent local changes. An immutable root filesystem can also prevent malicious binaries from writing to the host system."

  non_root_container_title = "__KIND__ containers should not run with root privileges"
  non_root_container_desc  = "Containers in a __KIND__ should not run with root privileges. By default, many container services run as the privileged root user, and applications execute inside the container as root despite not requiring privileged execution. Preventing root execution by using non-root containers or a rootless container engine limits the impact of a container compromise."

  service_account_token_disabled_desc = "Automatic mapping of service account token should be disabled. By default, Kubernetes automatically provisions a service account when creating a Pod and mounts the account’s secret token within the Pod at runtime. Many containerized applications do not require direct access to the service account as Kubernetes orchestration occurs transparently in the background. If an application is compromised, account tokens in Pods can be gleaned by cyber actors and used to further compromise the cluster. When an application does not need to access the service account directly, Kubernetes administrators should ensure that Pod specifications disable the secret token being mounted. This can be accomplished using the `automountServiceAccountToken: false` directive in the Pod’s YAML specification."
}
