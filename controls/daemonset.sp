locals {
  daemonset_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/DaemonSet"
  })
}

control "daemonset_cpu_limit" {
  title       = replace(local.container_cpu_limit_title, "__KIND__", "DaemonSet")
  description = replace(local.container_cpu_limit_desc, "__KIND__", "DaemonSet")
  query       = query.daemonset_cpu_limit

  tags = merge(local.daemonset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "daemonset_cpu_request" {
  title       = replace(local.container_cpu_request_title, "__KIND__", "DaemonSet")
  description = replace(local.container_cpu_request_desc, "__KIND__", "DaemonSet")
  query       = query.daemonset_cpu_request

  tags = merge(local.daemonset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "daemonset_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "DaemonSet")
  description = replace(local.container_memory_limit_desc, "__KIND__", "DaemonSet")
  query       = query.daemonset_memory_limit

  tags = merge(local.daemonset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "daemonset_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "DaemonSet")
  description = replace(local.container_memory_request_desc, "__KIND__", "DaemonSet")
  query       = query.daemonset_memory_request

  tags = merge(local.daemonset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "daemonset_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "DaemonSet")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "DaemonSet")
  query       = query.daemonset_container_privilege_disabled

  tags = merge(local.daemonset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "daemonset_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "DaemonSet")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "DaemonSet")
  query       = query.daemonset_container_privilege_escalation_disabled

  tags = merge(local.daemonset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "daemonset_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "DaemonSet")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "DaemonSet")
  query       = query.daemonset_host_network_access_disabled

  tags = merge(local.daemonset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "daemonset_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "DaemonSet")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "DaemonSet")
  query       = query.daemonset_hostpid_hostipc_sharing_disabled

  tags = merge(local.daemonset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "daemonset_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "DaemonSet")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "DaemonSet")
  query       = query.daemonset_immutable_container_filesystem

  tags = merge(local.daemonset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "daemonset_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "DaemonSet")
  description = replace(local.non_root_container_desc, "__KIND__", "DaemonSet")
  query       = query.daemonset_non_root_container

  tags = merge(local.daemonset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "daemonset_container_readiness_probe" {
  title       = "DaemonSet containers should have readiness probe"
  description = "Containers in DaemonSet definition should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill it’s work."
  query       = query.daemonset_container_readiness_probe

  tags = local.daemonset_common_tags
}

control "daemonset_container_liveness_probe" {
  title       = "DaemonSet containers should have liveness probe"
  description = "Containers in DaemonSet definition should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  query       = query.daemonset_container_liveness_probe

  tags = local.daemonset_common_tags
}

control "daemonset_container_privilege_port_mapped" {
  title       = "DaemonSet containers should not be mapped with privilege ports"
  description = "Privileged ports `0 to 1024` should not be mapped with DaemonSet containers. Normal users and processes are not allowed to use them for various security reasons."
  query       = query.daemonset_container_privilege_port_mapped

  tags = local.daemonset_common_tags
}

control "daemonset_default_namespace_used" {
  title       = "DaemonSet definition should not use default namespace"
  description = "Default namespace should not be used by DaemonSet definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.daemonset_default_namespace_used

  tags = merge(local.daemonset_common_tags, {
    cis = "true"
  })
}

control "daemonset_default_seccomp_profile_enabled" {
  title       = "Seccomp profile is set to docker/default in DaemonSet definition"
  description = "In DaemonSet definition seccomp profile should be set to docker/default. Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  query       = query.daemonset_default_seccomp_profile_enabled

  tags = merge(local.daemonset_common_tags, {
    cis = "true"
  })
}

control "daemonset_container_with_added_capabilities" {
  title       = "DaemonSet containers should minimize the admission of containers with added capability"
  description = "Containers in DaemonSet should minimize the admission of containers with added capability. Adding capabilities to containers increases the risk of container breakout."
  query       = query.daemonset_container_with_added_capabilities

  tags = local.daemonset_common_tags
}