locals {
  pod_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Pod"
  })
}

control "pod_volume_host_path" {
  title       = replace(local.container_disallow_host_path_title, "__KIND__", "Pod")
  description = replace(local.container_disallow_host_path_desc, "__KIND__", "Pod")
  query       = query.pod_volume_host_path

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "Pod")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "Pod")
  query       = query.pod_container_privilege_disabled

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "Pod")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "Pod")
  query       = query.pod_container_privilege_escalation_disabled

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "Pod")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "Pod")
  query       = query.pod_host_network_access_disabled
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "Pod")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "Pod")
  query       = query.pod_hostpid_hostipc_sharing_disabled

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "Pod")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "Pod")
  query       = query.pod_immutable_container_filesystem

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "Pod")
  description = replace(local.non_root_container_desc, "__KIND__", "Pod")
  query       = query.pod_non_root_container

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_service_account_not_exist" {
  title       = "Pods should not refer to a non existing service account"
  description = local.pod_service_account_not_exist_desc
  query       = query.pod_service_account_not_exist

  tags = local.pod_common_tags
}

control "pod_service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled in Pod"
  description = local.service_account_token_disabled_desc
  query       = query.pod_service_account_token_disabled

  tags = merge(local.pod_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "pod_container_readiness_probe" {
  title       = "Pod containers should have readiness probe"
  description = "Containers in Pods should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill it’s work."
  query       = query.pod_container_readiness_probe

  tags = local.pod_common_tags
}

control "pod_container_liveness_probe" {
  title       = "Pod containers should have liveness probe"
  description = "Containers in Pods should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  query       = query.pod_container_liveness_probe

  tags = local.pod_common_tags
}

control "pod_container_privilege_port_mapped" {
  title       = "Pod containers should not be mapped with privilege ports"
  description = "Privileged ports `0 to 1024` should not be mapped with Pod containers. Normal users and processes are not allowed to use them for various security reasons."
  query       = query.pod_container_privilege_port_mapped

  tags = local.pod_common_tags
}

control "pod_default_namespace_used" {
  title       = "Pods should not use default namespace"
  description = "Default namespace should not be used by Pods. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.pod_default_namespace_used

  tags = merge(local.pod_common_tags, {
    cis = "true"
  })
}

control "pod_default_seccomp_profile_enabled" {
  title       = "Seccomp profile is set to docker/default in your Pods"
  description = "In Pods seccomp profile should be set to docker/default. Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  query       = query.pod_default_seccomp_profile_enabled

  tags = merge(local.pod_common_tags, {
    cis = "true"
  })
}

control "pod_container_with_added_capabilities" {
  title       = "Pod containers should minimize the admission of containers with added capability"
  description = "Container in Pod should minimize the admission of container with added capability. Adding capabilities to container increases the risk of container breakout."
  query       = query.pod_container_with_added_capabilities

  tags = local.pod_common_tags
}

control "pod_container_security_context_exists" {
  title       = "Pod containers should have security context"
  description = "This check ensures that the container in the Pod have security context defined."
  query       = query.pod_container_security_context_exists

  tags = local.pod_common_tags
}

control "pod_container_image_tag_specified" {
  title       = "Pod containers have image tag specified which should be fixed not latest or blank"
  description = "This check ensures that the container in the Pod have image tag fixed not latest or blank."
  query       = query.pod_container_image_tag_specified

  tags = local.pod_common_tags
}

control "pod_container_image_pull_policy_always" {
  title       = "Pod containers have image pull policy set to Always"
  description = "This check ensures that the container in the Pod have image pull policy set to Always."
  query       = query.pod_container_image_pull_policy_always

  tags = local.pod_common_tags
}

control "pod_container_admission_capability_restricted" {
  title       = "Pod containers should have admission capability restricted"
  description = "This check ensures that the container in the Pod have admission capability restricted."
  query       = query.pod_container_admission_capability_restricted

  tags = local.pod_common_tags
}

control "pod_container_encryption_providers_configured" {
  title       = "Pod containers should have encryption providers configured appropriately"
  description = "This check ensures that the container in the Pod have encryption providers configured appropriately."
  query       = query.pod_container_encryption_providers_configured

  tags = local.pod_common_tags
}

control "pod_container_sys_admin_capability_disabled" {
  title       = "Pod containers should not use CAP_SYS_ADMIN linux capability"
  description = "This check ensures that the container in the Pod does not use CAP_SYS_ADMIN linux capability."
  query       = query.pod_container_sys_admin_capability_disabled

  tags = local.pod_common_tags
}

control "pod_container_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "Pod")
  description = replace(local.container_memory_limit_desc, "__KIND__", "Pod")
  query       = query.pod_container_memory_limit

  tags = local.pod_common_tags
}

control "pod_container_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "Pod")
  description = replace(local.container_memory_request_desc, "__KIND__", "Pod")
  query       = query.pod_container_memory_request

  tags = local.pod_common_tags
}

control "pod_container_capabilities_drop_all" {
  title       = "Pod containers should minimize it's admission with capabilities assigned"
  description = "This check ensures that the container in the Pod minimizes it's admission with capabilities assigned."
  query       = query.pod_container_capabilities_drop_all

  tags = local.pod_common_tags
}

control "pod_container_arg_peer_client_cert_auth_enabled" {
  title       = "Pod containers peer client cert auth should be enabled"
  description = "This check ensures that the Pod container peer client cert auth is enabled."
  query       = query.pod_container_arg_peer_client_cert_auth_enabled

  tags = local.pod_common_tags
}

control "pod_container_rotate_certificate_enabled" {
  title       = "Pod containers certificate rotation should be enabled"
  description = "This check ensures that the container in the Pod have peer client cert auth enabled."
  query       = query.pod_container_rotate_certificate_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_event_qps_less_than_5" {
  title       = "Pod containers argument event qps should be less than 5"
  description = "This check ensures that the container in the Pod have argument event qps set to less than 5."
  query       = query.pod_container_argument_event_qps_less_than_5

  tags = local.pod_common_tags
}
