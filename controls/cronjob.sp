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
  description = "Container in CronJob definition should not have added capabilities. Added capabilities can provide container processes with escalated privileges which can be used to access sensitive host resources or perform operations outside of the container."
  query       = query.cronjob_container_with_added_capabilities

  tags = local.cronjob_common_tags
}

control "cronjob_container_security_context_exists" {
  title       = "CronJob containers should has security context defined"
  description = "This check ensures that the container in a CronJob definition has security context defined."
  query       = query.cronjob_container_security_context_exists

  tags = local.cronjob_common_tags
}

control "cronjob_container_image_tag_specified" {
  title       = "CronJob containers have image tag specified which should be fixed not latest or blank"
  description = "This check ensures that the container in the CronJob has image tag fixed not latest or blank."
  query       = query.cronjob_container_image_tag_specified

  tags = local.cronjob_common_tags
}

control "cronjob_container_image_pull_policy_always" {
  title       = "CronJob containers should has image pull policy set to Always"
  description = "This check ensures that the container in the CronJob has image pull policy set to Always."
  query       = query.cronjob_container_image_pull_policy_always

  tags = local.cronjob_common_tags
}

control "cronjob_container_admission_capability_restricted" {
  title       = "CronJob containers should has admission capability restricted"
  description = "This check ensures that the container in the CronJob has admission capability restricted."
  query       = query.cronjob_container_admission_capability_restricted

  tags = local.cronjob_common_tags
}

control "cronjob_container_encryption_providers_configured" {
  title       = "CronJob containers should has encryption providers configured appropriately"
  description = "This check ensures that the container in the CronJob has encryption providers configured appropriately."
  query       = query.cronjob_container_encryption_providers_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_sys_admin_capability_disabled" {
  title       = "CronJob containers should not use CAP_SYS_ADMIN linux capability"
  description = "This check ensures that the container in the CronJob does not use CAP_SYS_ADMIN Linux capability."
  query       = query.cronjob_container_sys_admin_capability_disabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_capabilities_drop_all" {
  title       = "CronJob containers should minimize its admission with capabilities assigned"
  description = "This check ensures that the container in the CronJob minimizes its admission with capabilities assigned."
  query       = query.cronjob_container_capabilities_drop_all

  tags = local.cronjob_common_tags
}

control "cronjob_container_arg_peer_client_cert_auth_enabled" {
  title       = "CronJob containers peer client cert auth should be enabled"
  description = "This check ensures that the container in the CronJob has peer client cert auth enabled."
  query       = query.cronjob_container_arg_peer_client_cert_auth_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_rotate_certificate_enabled" {
  title       = "CronJob containers certificate rotation should be enabled"
  description = "This check ensures that the container in the CronJob has certificate rotation enabled."
  query       = query.cronjob_container_rotate_certificate_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_event_qps_less_than_5" {
  title       = "CronJob containers argument event qps should be less than 5"
  description = "This check ensures that the container in the CronJob has argument event qps set to less than 5."
  query       = query.cronjob_container_argument_event_qps_less_than_5

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_anonymous_auth_disabled" {
  title       = "CronJob containers argument anonymous auth should be disabled"
  description = "This check ensures that the container in the CronJob has anonymous auth disabled."
  query       = query.cronjob_container_argument_anonymous_auth_disabled

  tags = local.pod_common_tags
}

control "cronjob_container_argument_audit_log_path_configured" {
  title       = "CronJob containers should has audit log path configured appropriately"
  description = "This check ensures that the container in the CronJob has audit log path configured  appropriately."
  query       = query.cronjob_container_argument_audit_log_path_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_audit_log_maxage_greater_than_30" {
  title       = "CronJob containers should have audit log maxage set to 30 or greater"
  description = "This check ensures that the container in the CronJob has audit log maxage set to 30 or greater."
  query       = query.cronjob_container_argument_audit_log_maxage_greater_than_30

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_audit_log_maxbackup_greater_than_10" {
  title       = "CronJob containers should have audit log maxbackup set to 10 or greater"
  description = "This check ensures that the container in the CronJob has audit log maxbackup set to 10 or greater."
  query       = query.cronjob_container_argument_audit_log_maxbackup_greater_than_10

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_audit_log_maxsize_greater_than_100" {
  title       = "CronJob containers should have audit log maxsize set to 100 or greater"
  description = "This check ensures that the container in the CronJob has audit log maxsize set to 100 or greater."
  query       = query.cronjob_container_argument_audit_log_maxsize_greater_than_100

  tags = local.cronjob_common_tags
}

control "cronjob_container_no_argument_basic_auth_file" {
  title       = "CronJob containers argument basic auth file should not be set"
  description = "This check ensures that the container in the CronJob has argument basic auth file not set."
  query       = query.cronjob_container_no_argument_basic_auth_file

  tags = local.cronjob_common_tags
}
