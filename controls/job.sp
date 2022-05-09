locals {
  job_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Job"
  })
}

control "job_cpu_limit" {
  title       = replace(local.container_cpu_limit_title, "__KIND__", "Job")
  description = replace(local.container_cpu_limit_desc, "__KIND__", "Job")
  sql         = query.job_cpu_limit.sql

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_cpu_request" {
  title       = replace(local.container_cpu_request_title, "__KIND__", "Job")
  description = replace(local.container_cpu_request_desc, "__KIND__", "Job")
  sql         = query.job_cpu_request.sql

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "Job")
  description = replace(local.container_memory_limit_desc, "__KIND__", "Job")
  sql         = query.job_memory_limit.sql

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "Job")
  description = replace(local.container_memory_request_desc, "__KIND__", "Job")
  sql         = query.job_memory_request.sql

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "Job")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "Job")
  sql         = query.job_container_privilege_disabled.sql

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "Job")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "Job")
  sql         = query.job_container_privilege_escalation_disabled.sql

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "Job")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "Job")
  sql         = query.job_host_network_access_disabled.sql

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "Job")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "Job")
  sql         = query.job_hostpid_hostipc_sharing_disabled.sql

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "Job")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "Job")
  sql         = query.job_immutable_container_filesystem.sql

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "Job")
  description = replace(local.non_root_container_desc, "__KIND__", "Job")
  sql         = query.job_non_root_container.sql

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_container_readiness_probe" {
  title       = "Job containers should have readiness probe"
  description = "Containers in Job definition should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill it’s work."
  sql         = query.job_container_readiness_probe.sql

  tags = merge(local.job_common_tags, {
    extra_checks = "true"
  })
}

control "job_container_liveness_probe" {
  title       = "Job containers should have liveness probe"
  description = "Containers in Job definition should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  sql         = query.job_container_liveness_probe.sql

  tags = merge(local.job_common_tags, {
    extra_checks = "true"
  })
}

control "job_container_privilege_port_mapped" {
  title       = "Job containers should not be mapped with privilege ports"
  description = "Privileged ports `0 to 1024` should not be mapped with Job containers. Normal users and processes are not allowed to use them for various security reasons."
  sql         = query.job_container_privilege_port_mapped.sql
  tags        = local.extra_checks_tags
}

control "job_default_namespace_used" {
  title       = "Job definition should not use default namespace"
  description = "Default namespace should not be used by Job definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.job_default_namespace_used.sql

  tags = merge(local.job_common_tags, {
    cis = "true"
  })
}

control "job_default_seccomp_profile_enabled" {
  title       = "Seccomp profile is set to docker/default in Job definition"
  description = "In Job definition seccomp profile should be set to docker/default. Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  sql         = query.job_default_seccomp_profile_enabled.sql

  tags = merge(local.job_common_tags, {
    cis = "true"
  })
}
