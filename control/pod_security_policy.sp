control "pod_security_policy_allowed_host_path" {
  title       = "Pod Security Policy should prohibit hostPaths volumes"
  description = "The Pod Security Policy `allowedHostPaths` specifies a list of host paths that are allowed to be used by hostPath volumes. An empty list means there is no restriction on host paths used. This is defined as a list of objects with a single pathPrefix field, which allows hostPath volumes to mount a path that begins with an allowed prefix, and a readOnly field indicating it must be mounted read-only."
  sql         = query.pod_security_policy_allowed_host_path.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_security_policy_container_privilege_disabled" {
  title       = "Pod Security Policy should prohibit containers to run with privilege access"
  description = "Pod Security Policy `privileged` controls whether the Pod containers may run with `privileged` access. ${replace(local.container_privilege_disabled_desc, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_security_policy_container_privilege_escalation_disabled" {
  title       = "Pod Security Policy should prohibit privilege escalation"
  description = "Pod Security Policy `allowPrivilegeEscalation` controls whether the Pod containers may request for privilege escalation. ${replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_security_policy_security_services_hardening" {
  title       = "Containerized applications should use security services such as SELinux or AppArmor or Seccomp"
  description = "The underlying host OS needs to be secured in order to prevent container breaches from affecting the host. For this, Linux provides several out-of-the-box security modules. Some of the popular ones are SELinux, AppArmor and Seccomp."
  sql         = query.pod_security_policy_security_services_hardening.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_security_policy_host_network_access_disabled" {
  title       = "Pod Security Policy should prohibit host network access "
  description = "Pod Security Policy host network controls whether the Pod may use the node network namespace. Doing so gives the Pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other Pods on the same node."
  sql         = query.pod_security_policy_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_security_policy_hostpid_hostipc_sharing_disabled" {
  title       = "Pod Security Policy should prohibit containers from sharing the host process namespaces"
  description = "Pod Security Policy `hostPID` and `hostIPC` controls whether the Pod may share the host process namespaces. ${replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_hostpid_hostipc_sharing_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_security_policy_hostpid_sharing_disabled" {
  title       = "Pod Security Policy should prohibit containers from sharing the host process ID"
  description = "Pod Security Policy `hostPID` controls whether the Pod may share the host process namespaces. ${replace(local.hostpid_sharing_disabled_desc, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_hostpid_sharing_disabled.sql
  tags        = local.extra_checks_tags
}

control "pod_security_policy_hostipc_sharing_disabled" {
  title       = "Pod Security Policy should prohibit containers from sharing the host process IPC"
  description = "Pod Security Policy `hostIPC` controls whether the Pod may share the host process namespaces. ${replace(local.hostipc_sharing_disabled_desc, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_hostipc_sharing_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}


control "pod_security_policy_immutable_container_filesystem" {
  title       = "Pod Security Policy should force containers to run with read only root file system"
  description = "Pod Security Policy `readOnlyRootFilesystem` controls whether the Pod containers run with read only root file system. ${replace(local.immutable_container_filesystem_desc, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_security_policy_non_root_container" {
  title       = "Pod Security Policy should prohibit containers from running as root"
  description = "Pod Security Policy should prohibit containers from running as root. ${replace(local.non_root_container_desc, "__KIND__", "Pod")}"
  sql         = query.pod_security_policy_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}
