locals {
  pod_security_policy_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/PodSecurityPolicy"
  })
}

control "pod_security_policy_allowed_host_path" {
  title       = "Pod Security Policy should prohibit hostPaths volumes"
  description = "The Pod Security Policy `allowedHostPaths` specifies a list of host paths that are allowed to be used by hostPath volumes. An empty list means there is no restriction on host paths used. This is defined as a list of objects with a single pathPrefix field, which allows hostPath volumes to mount a path that begins with an allowed prefix, and a readOnly field indicating it must be mounted read-only."
  query       = query.pod_security_policy_allowed_host_path

  tags = merge(local.pod_security_policy_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_security_policy_container_privilege_disabled" {
  title       = "Pod Security Policy should prohibit containers to run with privilege access"
  description = "Pod Security Policy `privileged` controls whether the Pod containers may run with `privileged` access. ${replace(local.container_privilege_disabled_desc, "__KIND__", "Pod")}"
  query       = query.pod_security_policy_container_privilege_disabled

  tags = merge(local.pod_security_policy_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_security_policy_container_privilege_escalation_disabled" {
  title       = "Pod Security Policy should prohibit privilege escalation"
  description = "Pod Security Policy `allowPrivilegeEscalation` controls whether the Pod containers may request for privilege escalation. ${replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "Pod")}"
  query       = query.pod_security_policy_container_privilege_escalation_disabled

  tags = merge(local.pod_security_policy_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_security_policy_security_services_hardening" {
  title       = "Containerized applications should use security services such as SELinux or AppArmor or Seccomp"
  description = "The underlying host OS needs to be secured in order to prevent container breaches from affecting the host. For this, Linux provides several out-of-the-box security modules. Some of the popular ones are SELinux, AppArmor and Seccomp."
  query       = query.pod_security_policy_security_services_hardening

  tags = merge(local.pod_security_policy_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_security_policy_host_network_access_disabled" {
  title       = "Pod Security Policy should prohibit host network access "
  description = "Pod Security Policy host network controls whether the Pod may use the node network namespace. Doing so gives the Pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other Pods on the same node."
  query       = query.pod_security_policy_host_network_access_disabled

  tags = merge(local.pod_security_policy_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_security_policy_hostpid_hostipc_sharing_disabled" {
  title       = "Pod Security Policy should prohibit containers from sharing the host process namespaces"
  description = "Pod Security Policy `hostPID` and `hostIPC` controls whether the Pod may share the host process namespaces. ${replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "Pod")}"
  query       = query.pod_security_policy_hostpid_hostipc_sharing_disabled

  tags = merge(local.pod_security_policy_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_security_policy_immutable_container_filesystem" {
  title       = "Pod Security Policy should force containers to run with read only root file system"
  description = "Pod Security Policy `readOnlyRootFilesystem` controls whether the Pod containers run with read only root file system. ${replace(local.immutable_container_filesystem_desc, "__KIND__", "Pod")}"
  query       = query.pod_security_policy_immutable_container_filesystem

  tags = merge(local.pod_security_policy_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_security_policy_non_root_container" {
  title       = "Pod Security Policy should prohibit containers from running as root"
  description = "Pod Security Policy should prohibit containers from running as root. ${replace(local.non_root_container_desc, "__KIND__", "Pod")}"
  query       = query.pod_security_policy_non_root_container

  tags = merge(local.pod_security_policy_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_security_policy_default_seccomp_profile_enabled" {
  title       = "Seccomp profile is set to docker/default in Pod security policy"
  description = "In Pod security policy seccomp profile should be set to docker/default. Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  query       = query.pod_security_policy_default_seccomp_profile_enabled

  tags = merge(local.pod_security_policy_common_tags, {
    cis = "true"
  })
}

control "pod_security_policy_hostpid_sharing_disabled" {
  title       = "Minimize the admission of containers wishing to share the host process ID namespace"
  description = "A container running in the host's PID namespace can inspect processes running outside the container. If the container also has access to ptrace capabilities this can be used to escalate privileges outside of the container. There should be at least one PodSecurityPolicy (PSP) defined which does not permit containers to share the host PID namespace."
  query       = query.pod_security_policy_hostpid_sharing_disabled

  tags = merge(local.pod_security_policy_common_tags, {
    cis = "true"
  })
}

control "pod_security_policy_hostipc_sharing_disabled" {
  title       = "Minimize the admission of containers wishing to share the host IPC namespace"
  description = "A container running in the host's IPC namespace can use IPC to interact with processes outside the container. There should be at least one PodSecurityPolicy (PSP) defined which does not permit containers to share the host IPC namespace."
  query       = query.pod_security_policy_hostipc_sharing_disabled

  tags = merge(local.pod_security_policy_common_tags, {
    cis = "true"
  })
}
