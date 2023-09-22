locals {
  statefulset_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/StatefulSet"
  })
}

control "statefulset_cpu_limit" {
  title       = replace(local.container_cpu_limit_title, "__KIND__", "StatefulSet")
  description = replace(local.container_cpu_limit_desc, "__KIND__", "StatefulSet")
  query       = query.statefulset_cpu_limit

  tags = merge(local.statefulset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "statefulset_cpu_request" {
  title       = replace(local.container_cpu_request_title, "__KIND__", "StatefulSet")
  description = replace(local.container_cpu_request_desc, "__KIND__", "StatefulSet")
  query       = query.statefulset_cpu_request

  tags = merge(local.statefulset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "statefulset_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "StatefulSet")
  description = replace(local.container_memory_limit_desc, "__KIND__", "StatefulSet")
  query       = query.statefulset_memory_limit

  tags = merge(local.statefulset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "statefulset_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "StatefulSet")
  description = replace(local.container_memory_request_desc, "__KIND__", "StatefulSet")
  query       = query.statefulset_memory_request

  tags = merge(local.statefulset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "statefulset_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "StatefulSet")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "StatefulSet")
  query       = query.statefulset_container_privilege_disabled

  tags = merge(local.statefulset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "statefulset_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "StatefulSet")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "StatefulSet")
  query       = query.statefulset_container_privilege_escalation_disabled

  tags = merge(local.statefulset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "statefulset_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "StatefulSet")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "StatefulSet")
  query       = query.statefulset_host_network_access_disabled

  tags = merge(local.statefulset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "statefulset_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "StatefulSet")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "StatefulSet")
  query       = query.statefulset_hostpid_hostipc_sharing_disabled

  tags = merge(local.statefulset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "statefulset_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "StatefulSet")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "StatefulSet")
  query       = query.statefulset_immutable_container_filesystem

  tags = merge(local.statefulset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "statefulset_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "StatefulSet")
  description = replace(local.non_root_container_desc, "__KIND__", "StatefulSet")
  query       = query.statefulset_non_root_container

  tags = merge(local.statefulset_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "statefulset_container_readiness_probe" {
  title       = "StatefulSet containers should have readiness probe"
  description = "Containers in StatefulSet definition should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill it’s work."
  query       = query.statefulset_container_readiness_probe

  tags = local.statefulset_common_tags
}

control "statefulset_container_liveness_probe" {
  title       = "StatefulSet containers should have liveness probe"
  description = "Containers in StatefulSet definition should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  query       = query.statefulset_container_liveness_probe

  tags = local.statefulset_common_tags
}

control "statefulset_container_privilege_port_mapped" {
  title       = "StatefulSet containers should not be mapped with privilege ports"
  description = "Privileged ports `0 to 1024` should not be mapped with StatefulSet containers. Normal users and processes are not allowed to use them for various security reasons."
  query       = query.statefulset_container_privilege_port_mapped

  tags = local.statefulset_common_tags
}

control "statefulset_default_namespace_used" {
  title       = "StatefulSet definition should not use default namespace"
  description = "Default namespace should not be used by StatefulSet definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.statefulset_default_namespace_used

  tags = merge(local.statefulset_common_tags, {
    cis = "true"
  })
}

control "statefulset_default_seccomp_profile_enabled" {
  title       = "Seccomp profile is set to docker/default in your StatefulSet definition"
  description = "In StatefulSet definition seccomp profile should be set to docker/default. Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  query       = query.statefulset_default_seccomp_profile_enabled

  tags = merge(local.statefulset_common_tags, {
    cis = "true"
  })
}

control "statefulset_container_with_added_capabilities" {
  title       = "StatefulSet containers should minimize the admission of containers with added capability"
  description = "Container in StatefulSet should minimize the admission of containers with added capability. Adding capabilities to container increases the risk of container breakout."
  query       = query.statefulset_container_with_added_capabilities

  tags = local.statefulset_common_tags
}

control "statefulset_container_security_context_exists" {
  title       = "Containers in StatefulSet should have securityContext defined"
  description = "This check ensures that the container is running with a defined security context."
  query       = query.statefulset_container_security_context_exists

  tags = local.statefulset_common_tags
}

control "statefulset_container_image_tag_specified" {
  title       = "StatefulSet containers have image tag specified which should be fixed not latest or blank"
  description = "This check ensures that the container in the StatefulSet has image tag fixed not latest or blank."
  query       = query.statefulset_container_image_tag_specified

  tags = local.statefulset_common_tags
}

control "statefulset_container_image_pull_policy_always" {
  title       = "StatefulSet containers has image pull policy set to Always"
  description = "This check ensures that the container in the StatefulSet has image pull policy set to Always."
  query       = query.statefulset_container_image_pull_policy_always

  tags = local.statefulset_common_tags
}

control "statefulset_container_admission_capability_restricted" {
  title       = "StatefulSet containers should has admission capability restricted"
  description = "This check ensures that the container in the StatefulSet has admission capability restricted."
  query       = query.statefulset_container_admission_capability_restricted

  tags = local.statefulset_common_tags
}

control "statefulset_container_encryption_providers_configured" {
  title       = "StatefulSet containers should has encryption providers configured appropriately"
  description = "This check ensures that the container in the StatefulSet has encryption providers configured appropriately."
  query       = query.statefulset_container_encryption_providers_configured

  tags = local.statefulset_common_tags
}

control "statefulset_container_sys_admin_capability_disabled" {
  title       = "StatefulSet containers should not use CAP_SYS_ADMIN linux capability"
  description = "This check ensures that the container in the StatefulSet does not use CAP_SYS_ADMIN Linux capability."
  query       = query.statefulset_container_sys_admin_capability_disabled

  tags = local.statefulset_common_tags
}

control "statefulset_container_capabilities_drop_all" {
  title       = "StatefulSet containers should minimize its admission with capabilities assigned"
  description = "This check ensures that the container in the StatefulSet minimizes its admission with capabilities assigned."
  query       = query.statefulset_container_capabilities_drop_all

  tags = local.statefulset_common_tags
}

control "statefulset_container_arg_peer_client_cert_auth_enabled" {
  title       = "StatefulSet containers peer client cert auth should be enabled"
  description = "This check ensures that the container in the StatefulSet has peer client cert auth enabled."
  query       = query.statefulset_container_arg_peer_client_cert_auth_enabled

  tags = local.statefulset_common_tags
}

control "statefulset_container_rotate_certificate_enabled" {
  title       = "StatefulSet containers certificate rotation should be enabled"
  description = "This check ensures that the container in the StatefulSet Controller has certificate rotation enabled."
  query       = query.statefulset_container_rotate_certificate_enabled

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_event_qps_less_than_5" {
  title       = "StatefulSet containers argument event qps should be less than 5"
  description = "This check ensures that the container in the StatefulSet has argument event qps set to less than 5."
  query       = query.statefulset_container_argument_event_qps_less_than_5

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_anonymous_auth_disabled" {
  title       = "StatefulSet Controller containers argument anonymous auth should be disabled"
  description = "This check ensures that the container in the StatefulSet Controller has anonymous auth disabled."
  query       = query.statefulset_container_argument_anonymous_auth_disabled

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_audit_log_path_configured" {
  title       = "StatefulSet containers should have audit log path configured appropriately"
  description = "This check ensures that the container in the  StatefulSet has audit log path configured appropriately."
  query       = query.statefulset_container_argument_audit_log_path_configured

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_audit_log_maxage_greater_than_30" {
  title       = "StatefulSet containers should have audit log maxage set to 30 or greater"
  description = "This check ensures that the container in the StatefulSet has audit log maxage set to 30 or greater."
  query       = query.statefulset_container_argument_audit_log_maxage_greater_than_30

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_audit_log_maxbackup_greater_than_10" {
  title       = "StatefulSet containers should have audit log maxbackup set to 10 or greater"
  description = "This check ensures that the container in the StatefulSet has audit log maxbackup set to 10 or greater."
  query       = query.statefulset_container_argument_audit_log_maxbackup_greater_than_10

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_audit_log_maxsize_greater_than_100" {
  title       = "StatefulSet containers should have audit log maxsize set to 100 or greater"
  description = "This check ensures that the container in the StatefulSet has audit log maxsize set to 100 or greater."
  query       = query.statefulset_container_argument_audit_log_maxsize_greater_than_100

  tags = local.statefulset_common_tags
}

control "statefulset_container_no_argument_basic_auth_file" {
  title       = "StatefulSet containers argument basic auth file should not be set"
  description = "This check ensures that the container in the StatefulSet has argument basic auth file not set."
  query       = query.statefulset_container_no_argument_basic_auth_file

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_etcd_cafile_configured" {
  title       = "StatefulSet containers argument etcd cafile should be set"
  description = "This check ensures that the container in the StatefulSet has argument etcd cafile set."
  query       = query.statefulset_container_argument_etcd_cafile_configured

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_authorization_mode_node" {
  title       = "StatefulSet containers argument authorization mode should have node"
  description = "This check ensures that the container in the StatefulSet has node included in the argument authorization mode."
  query       = query.statefulset_container_argument_authorization_mode_node

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_authorization_mode_no_always_allow" {
  title       = "StatefulSet containers argument authorization mode should not be set to always allow"
  description = "This check ensures that the container in the StatefulSet has argument authorization mode not set to always allow."
  query       = query.statefulset_container_argument_authorization_mode_no_always_allow

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_authorization_mode_rbac" {
  title       = "StatefulSet containers argument authorization mode should have RBAC"
  description = "This check ensures that the container in the StatefulSet has RBAC included in the argument authorization mode."
  query       = query.statefulset_container_argument_authorization_mode_rbac

  tags = local.statefulset_common_tags
}

control "statefulset_container_no_argument_insecure_bind_address" {
  title       = "StatefulSet containers argument insecure bind address should not be set"
  description = "This check ensures that the container in the StatefulSet has argument insecure bind address not set."
  query       = query.statefulset_container_no_argument_insecure_bind_address

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_kubelet_https_enabled" {
  title       = "StatefulSet containers argument kubelet HTTPS should be enabled"
  description = "This check ensures that the container in the StatefulSet has kubelet HTTPS argument enabled."
  query       = query.statefulset_container_argument_kubelet_https_enabled

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_insecure_port_0" {
  title       = "StatefulSet containers argument insecure port should be set to 0"
  description = "This check ensures that the container in the StatefulSet has insecure port set to 0."
  query       = query.statefulset_container_argument_insecure_port_0

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_kubelet_client_certificate_and_key_configured" {
  title       = "StatefulSet containers argument kubelet client certificate and key should be configured"
  description = "This check ensures that the container in the StatefulSet has kubelet client certificate and key argument configured."
  query       = query.statefulset_container_argument_kubelet_client_certificate_and_key_configured

  tags = local.statefulset_common_tags
}

control "statefulset_container_argument_etcd_certfile_and_keyfile_configured" {
  title       = "StatefulSet containers argument etcd certfile and keyfile should be configured"
  description = "This check ensures that the container in the StatefulSet has etcd certfile and keyfile argument configured."
  query       = query.statefulset_container_argument_etcd_certfile_and_keyfile_configured

  tags = local.statefulset_common_tags
}

control "statefulset_container_admission_control_plugin_always_pull_images" {
  title       = "StatefulSet containers admission control plugin should be set to always pull images"
  description = "This check ensures that the container in the StatefulSet has always pull images configured for admission control plugin."
  query       = query.statefulset_container_admission_control_plugin_always_pull_images

  tags = local.statefulset_common_tags
}

control "statefulset_container_admission_control_plugin_no_always_admit" {
  title       = "StatefulSet containers admission control plugin should not be set to always admit"
  description = "This check ensures that the container in the StatefulSet has admission control plugin not set to always admit."
  query       = query.statefulset_container_admission_control_plugin_no_always_admit

  tags = local.statefulset_common_tags
}