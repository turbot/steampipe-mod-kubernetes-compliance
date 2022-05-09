locals {
  pod_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Pod"
  })
}

control "pod_volume_host_path" {
  title       = replace(local.container_disallow_host_path_title, "__KIND__", "Pod")
  description = replace(local.container_disallow_host_path_desc, "__KIND__", "Pod")
  sql         = query.pod_volume_host_path.sql

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "Pod")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "Pod")
  sql         = query.pod_container_privilege_disabled.sql

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "Pod")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "Pod")
  sql         = query.pod_container_privilege_escalation_disabled.sql

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "Pod")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "Pod")
  sql         = query.pod_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "Pod")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "Pod")
  sql         = query.pod_hostpid_hostipc_sharing_disabled.sql

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "Pod")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "Pod")
  sql         = query.pod_immutable_container_filesystem.sql

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "Pod")
  description = replace(local.non_root_container_desc, "__KIND__", "Pod")
  sql         = query.pod_non_root_container.sql

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_service_account_not_exist" {
  title       = "Pods should not refer to a non existing service account"
  description = local.pod_service_account_not_exist_desc
  sql         = query.pod_service_account_not_exist.sql

  tags = merge(local.pod_common_tags, {
    extra_checks = "true"
  })
}

control "pod_service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled in Pod"
  description = local.service_account_token_disabled_desc
  sql         = query.pod_service_account_token_disabled.sql

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_container_readiness_probe" {
  title       = "Pod containers should have readiness probe"
  description = "Containers in Pods should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill it’s work."
  sql         = query.pod_container_readiness_probe.sql

  tags = merge(local.pod_common_tags, {
    extra_checks = "true"
  })
}

control "pod_container_liveness_probe" {
  title       = "Pod containers should have liveness probe"
  description = "Containers in Pods should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  sql         = query.pod_container_liveness_probe.sql

  tags = merge(local.pod_common_tags, {
    extra_checks = "true"
  })
}

control "pod_container_privilege_port_mapped" {
  title       = "Pod containers should not be mapped with privilege ports"
  description = "Privileged ports `0 to 1024` should not be mapped with Pod containers. Normal users and processes are not allowed to use them for various security reasons."
  sql         = query.pod_container_privilege_port_mapped.sql

  tags = merge(local.pod_common_tags, {
    extra_checks = "true"
  })
}

control "pod_default_namespace_used" {
  title       = "Pods should not use default namespace"
  description = "Default namespace should not be used by Pods. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.pod_default_namespace_used.sql

  tags = merge(local.pod_common_tags, {
    cis = "true"
  })
}

control "pod_default_seccomp_profile_enabled" {
  title       = "Seccomp profile is set to docker/default in your Pods"
  description = "In Pods seccomp profile should be set to docker/default. Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  sql         = query.pod_default_seccomp_profile_enabled.sql

  tags = merge(local.pod_common_tags, {
    cis = "true"
  })
}
