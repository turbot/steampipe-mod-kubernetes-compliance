locals {
  cronjob_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/CronJob"
  })
}

control "cronjob_cpu_limit" {
  title       = replace(local.container_cpu_limit_title, "__KIND__", "CronJob")
  description = replace(local.container_cpu_limit_desc, "__KIND__", "CronJob")
  query       = query.cronjob_cpu_limit

  tags = merge(local.cronjob_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "cronjob_cpu_request" {
  title       = replace(local.container_cpu_request_title, "__KIND__", "CronJob")
  description = replace(local.container_cpu_request_desc, "__KIND__", "CronJob")
  query       = query.cronjob_cpu_request

  tags = merge(local.cronjob_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "cronjob_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "CronJob")
  description = replace(local.container_memory_limit_desc, "__KIND__", "CronJob")
  query       = query.cronjob_memory_limit

  tags = merge(local.cronjob_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "cronjob_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "CronJob")
  description = replace(local.container_memory_request_desc, "__KIND__", "CronJob")
  query       = query.cronjob_memory_request

  tags = merge(local.cronjob_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "cronjob_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "CronJob")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "CronJob")
  query       = query.cronjob_container_privilege_disabled

  tags = merge(local.cronjob_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "cronjob_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "CronJob")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "CronJob")
  query       = query.cronjob_container_privilege_escalation_disabled

  tags = merge(local.cronjob_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "cronjob_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "CronJob")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "CronJob")
  query       = query.cronjob_host_network_access_disabled

  tags = merge(local.cronjob_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "cronjob_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "CronJob")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "CronJob")
  query       = query.cronjob_hostpid_hostipc_sharing_disabled

  tags = merge(local.cronjob_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "cronjob_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "CronJob")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "CronJob")
  query       = query.cronjob_immutable_container_filesystem

  tags = merge(local.cronjob_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "cronjob_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "CronJob")
  description = replace(local.non_root_container_desc, "__KIND__", "CronJob")
  query       = query.cronjob_non_root_container

  tags = merge(local.cronjob_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "cronjob_container_readiness_probe" {
  title       = "CronJob containers should have readiness probe"
  description = "Containers in CronJob definition should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill its work."
  query       = query.cronjob_container_readiness_probe

  tags = local.cronjob_common_tags
}

control "cronjob_container_liveness_probe" {
  title       = "CronJob containers should have liveness probe"
  description = "Containers in CronJob definition should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  query       = query.cronjob_container_liveness_probe

  tags = local.cronjob_common_tags
}

control "cronjob_container_privilege_port_mapped" {
  title       = "CronJob containers should not be mapped with privilege ports"
  description = "Privileged ports `0 to 1024` should not be mapped with CronJob containers. Normal users and processes are not allowed to use them for various security reasons."
  query       = query.cronjob_container_privilege_port_mapped

  tags = local.cronjob_common_tags
}

control "cronjob_default_namespace_used" {
  title       = "CronJob definition should not use default namespace"
  description = "Default namespace should not be used by CronJob definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.cronjob_default_namespace_used

  tags = merge(local.cronjob_common_tags, {
    cis = "true"
  })
}

control "cronjob_default_seccomp_profile_enabled" {
  title       = "Seccomp profile is set to docker/default in CronJob definition"
  description = "In CronJob definition seccomp profile should be set to docker/default. Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  query       = query.cronjob_default_seccomp_profile_enabled

  tags = merge(local.cronjob_common_tags, {
    cis = "true"
  })
}

control "cronjob_container_with_added_capabilities" {
  title       = "CronJob containers should not have added capabilities"
  description = "Containers in CronJob definition should not have added capabilities. Added capabilities can provide container processes with escalated privileges which can be used to access sensitive host resources or perform operations outside of the container."
  query       = query.cronjob_container_with_added_capabilities

  tags = local.cronjob_common_tags
}

control "cronjob_container_security_context_exists" {
  title       = "CronJob containers should have security context defined"
  description = "This check ensures that the containers in a CronJob definition have security context defined."
  query       = query.cronjob_container_security_context_exists

  tags = local.cronjob_common_tags
}