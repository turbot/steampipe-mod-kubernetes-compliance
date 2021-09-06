benchmark "kubernetes_pod_security" {
  title    = "Kubernetes Pod security"
  children = [
    control.k8s_non_root_container,
    control.k8s_root_allowed_elevation,
    control.k8s_allowed_host_paths,
    control.k8s_host_network_access,
    control.k8s_hostpid_hostipc_namesapce_privilege,
    control.k8s_immutable_container_filesystem,
    control.k8s_pod_service_account_token,
    control.k8s_privileged_container,
    control.k8s_security_services_hardening
  ]
  tags     = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_non_root_container" {
  title       = "Containers should not be deployed with root privileges"
  description = "Use containers built to run applications as non-root users. A root user inside a container can basically run every command as a root user on a traditional host system. From an application perspective, this is undesirable."
  sql         = query.k8s_non_root_container.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_root_allowed_elevation" {
  title       = "Container should not have privilege escalation"
  description = "Container should not have privilege escalation. In case of a container breakout, the root user can access and execute anything on the underlying host as a highly privileged user as well. This means filesystem mounts are at risk, access to username/passwords which are configured on the host to connect to other services installing unwanted malware and accessing other cloud resources."
  sql         = query.k8s_root_allowed_elevation.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_allowed_host_paths" {
  title       = "Containers should use specified host paths"
  description = "Allowed host paths specifies a list of host paths that are allowed to be used by hostPath volumes. An empty list means there is no restriction on host paths used. This is defined as a list of objects with a single pathPrefix field, which allows hostPath volumes to mount a path that begins with an allowed prefix, and a readOnly field indicating it must be mounted read-only."
  sql         = query.k8s_allowed_host_paths.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_host_network_access" {
  title       = "Host network access should be disabled for the containers"
  description = "HostNetwork controls whether the pod may use the node network namespace. Doing so gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node."
  sql         = query.k8s_host_network_access.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_hostpid_hostipc_namesapce_privilege" {
  title       = "Containers should not share host process namespaces"
  description = "If the host’s process namespace is shared with containers, it would basically allow these to see all of the processes on the host system. This reduces the benefit of process level isolation between the host and the containers. Under these circumstances a malicious user who has access to a container could get access to processes on the host itself, manipulate them, and even be able to kill them. This could allow for the host itself being shut down, which could be extremely serious, particularly in a multi-tenanted environment. You should not share the host’s process namespace with the containers running on it."
  sql        = query.k8s_hostpid_hostipc_namesapce_privilege.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_immutable_container_filesystem" {
  title       = "Containers should always run with a read only root file system"
  description = "Using an immutable root filesystem and a verified boot mechanism prevents against attackers from "owning" the machine through permanent local changes. An immutable root filesystem can also prevent malicious binaries from writing to the host system."
  sql         = query.k8s_immutable_container_filesystem.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_pod_service_account_token" {
  title       = "Automatic mapping of the service account tokens should be disabled in pod service account"
  description = "By default, Kubernetes automatically provisions a service account when creating a Pod and mounts the account’s secret token within the Pod at runtime. Many containerized applications do not require direct access to the service account as Kubernetes orchestration occurs transparently in the background. If an application is compromised, account tokens in Pods can be gleaned by cyber actors and used to further compromise the cluster. When an application does not need to access the service account directly, Kubernetes administrators should ensure that Pod specifications disable the secret token being mounted. "
  sql         = query.k8s_pod_service_account_token.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_privileged_container" {
  title       = "Containers Should not have privileged access"
  description = "To prevent security issues, it is recommended that you do not run privileged containers in your environment. Instead, provide granular permissions and capabilities to the container environment. Giving containers full access to the host can create security flaws in your production environment."
  sql         = query.k8s_privileged_container.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_security_services_hardening" {
  title       = "Container applications should use security services such as SELinux or AppArmor or Seccomp"
  description = "The underlying host OS needs to be secured in order to prevent container breaches from affecting the host. For this, Linux provides several out-of-the-box security modules. Some of the popular ones are SELinux, AppArmor and seccomp."
  sql         = query.k8s_security_services_hardening.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}
