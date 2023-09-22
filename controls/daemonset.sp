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
  description = "Container in DaemonSet should minimize the admission of containers with added capability. Adding capabilities to container increases the risk of container breakout."
  query       = query.daemonset_container_with_added_capabilities

  tags = local.daemonset_common_tags
}

control "daemonset_container_security_context_exists" {
  title       = "DaemonSet containers should has security context defined"
  description = "This check ensures that the container in a DaemonSet definition has security context defined."
  query       = query.daemonset_container_security_context_exists

  tags = local.daemonset_common_tags
}

control "daemonset_container_image_tag_specified" {
  title       = "DaemonSet containers have image tag specified which should be fixed not latest or blank"
  description = "This check ensures that the container in the DaemonSet has image tag fixed not latest or blank."
  query       = query.daemonset_container_image_tag_specified

  tags = local.daemonset_common_tags
}

control "daemonset_container_image_pull_policy_always" {
  title       = "DaemonSet containers has image pull policy set to Always"
  description = "This check ensures that the container in the DaemonSet has image pull policy set to Always."
  query       = query.daemonset_container_image_pull_policy_always

  tags = local.daemonset_common_tags
}

control "daemonset_container_admission_capability_restricted" {
  title       = "DaemonSet containers should has admission capability restricted"
  description = "This check ensures that the container in the DaemonSet has admission capability restricted."
  query       = query.daemonset_container_admission_capability_restricted

  tags = local.daemonset_common_tags
}

control "daemonset_container_encryption_providers_configured" {
  title       = "DaemonSet containers should has encryption providers configured appropriately"
  description = "This check ensures that the container in the DaemonSet has encryption providers configured appropriately."
  query       = query.daemonset_container_encryption_providers_configured

  tags = local.daemonset_common_tags
}

control "daemonset_container_sys_admin_capability_disabled" {
  title       = "DaemonSet containers should not use CAP_SYS_ADMIN linux capability"
  description = "This check ensures that the container in the DaemonSet does not use CAP_SYS_ADMIN Linux capability."
  query       = query.daemonset_container_sys_admin_capability_disabled

  tags = local.daemonset_common_tags
}

control "daemonset_container_capabilities_drop_all" {
  title       = "DaemonSet containers should minimize its admission with capabilities assigned"
  description = "This check ensures that the container in the DaemonSet minimizes its admission with capabilities assigned."
  query       = query.daemonset_container_capabilities_drop_all

  tags = local.daemonset_common_tags
}

control "daemonset_container_arg_peer_client_cert_auth_enabled" {
  title       = "DaemonSet containers peer client cert auth should be enabled"
  description = "This check ensures that the container in the DaemonSet has peer client cert auth enabled."
  query       = query.daemonset_container_arg_peer_client_cert_auth_enabled

  tags = local.daemonset_common_tags
}

control "daemonset_container_rotate_certificate_enabled" {
  title       = "DaemonSet containers certificate rotation should be enabled"
  description = "This check ensures that the container in the DaemonSet has certificate rotation enabled."
  query       = query.daemonset_container_rotate_certificate_enabled

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_event_qps_less_than_5" {
  title       = "DaemonSet containers argument event qps should be less than 5"
  description = "This check ensures that the container in the DaemonSet has argument event qps set to less than 5."
  query       = query.daemonset_container_argument_event_qps_less_than_5

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_anonymous_auth_disabled" {
  title       = "DaemonSet containers argument anonymous auth should be disabled"
  description = "This check ensures that the container in the DaemonSet has anonymous auth disabled."
  query       = query.daemonset_container_argument_anonymous_auth_disabled

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_audit_log_path_configured" {
  title       = "DaemonSet containers should have audit log path configured appropriately"
  description = "This check ensures that the container in the DaemonSet has audit log path configured appropriately."
  query       = query.daemonset_container_argument_audit_log_path_configured

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_audit_log_maxage_greater_than_30" {
  title       = "DaemonSet containers should have audit log max-age set to 30 or greater"
  description = "This check ensures that the container in the DaemonSet has audit log max-age set to 30 or greater."
  query       = query.daemonset_container_argument_audit_log_maxage_greater_than_30

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_audit_log_maxbackup_greater_than_10" {
  title       = "DaemonSet containers should have audit log max backup set to 10 or greater"
  description = "This check ensures that the container in the DaemonSet has audit log max backup set to 10 or greater."
  query       = query.daemonset_container_argument_audit_log_maxbackup_greater_than_10

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_audit_log_maxsize_greater_than_100" {
  title       = "DaemonSet containers should have audit log max size set to 100 or greater"
  description = "This check ensures that the container in the DaemonSet has audit log max size set to 100 or greater."
  query       = query.daemonset_container_argument_audit_log_maxsize_greater_than_100

  tags = local.daemonset_common_tags
}

control "daemonset_container_no_argument_basic_auth_file" {
  title       = "DaemonSet containers argument basic auth file should not be set"
  description = "This check ensures that the container in the DaemonSet does not have an argument basic auth file set."
  query       = query.daemonset_container_no_argument_basic_auth_file

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_etcd_cafile_configured" {
  title       = "DaemonSet containers argument etcd cafile should be set"
  description = "This check ensures that the container in the DaemonSet has argument etcd cafile set."
  query       = query.daemonset_container_argument_etcd_cafile_configured

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_authorization_mode_node" {
  title       = "DaemonSet containers argument authorization mode should have node"
  description = "This check ensures that the container in the DaemonSet has node included in the argument authorization mode."
  query       = query.daemonset_container_argument_authorization_mode_node

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_authorization_mode_no_always_allow" {
  title       = "DaemonSet containers argument authorization mode should not be set to 'always allow'"
  description = "This check ensures that the container in the DaemonSet has argument authorization mode not set to 'always allow'."
  query       = query.daemonset_container_argument_authorization_mode_no_always_allow

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_authorization_mode_rbac" {
  title       = "DaemonSet containers argument authorization mode should have RBAC"
  description = "This check ensures that the container in the DaemonSet has RBAC included in the argument authorization mode."
  query       = query.daemonset_container_argument_authorization_mode_rbac

  tags = local.daemonset_common_tags
}

control "daemonset_container_no_argument_insecure_bind_address" {
  title       = "DaemonSet containers argument insecure bind address should not be set"
  description = "This check ensures that the container in the DaemonSet does not have an argument insecure bind address set."
  query       = query.daemonset_container_no_argument_insecure_bind_address

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_kubelet_https_enabled" {
  title       = "DaemonSet containers argument kubelet HTTPS should be enabled"
  description = "This check ensures that the container in the DaemonSet has kubelet HTTPS argument enabled."
  query       = query.daemonset_container_argument_kubelet_https_enabled

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_insecure_port_0" {
  title       = "DaemonSet containers argument insecure port should be set to 0"
  description = "This check ensures that the container in the DaemonSet has insecure port set to 0."
  query       = query.daemonset_container_argument_insecure_port_0

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_kubelet_client_certificate_and_key_configured" {
  title       = "DaemonSet containers argument kubelet client certificate and key should be configured"
  description = "This check ensures that the container in the DaemonSet has kubelet client certificate and key argument configured."
  query       = query.daemonset_container_argument_kubelet_client_certificate_and_key_configured

  tags = local.daemonset_common_tags
}

control "daemonset_container_argument_etcd_certfile_and_keyfile_configured" {
  title       = "DaemonSet containers argument etcd certfile and keyfile should be configured"
  description = "This check ensures that the container in the DaemonSet has etcd certfile and keyfile argument configured."
  query       = query.daemonset_container_argument_etcd_certfile_and_keyfile_configured

  tags = local.daemonset_common_tags
}

control "daemonset_container_admission_control_plugin_always_pull_images" {
  title       = "DaemonSet containers admission control plugin should be set to 'always pull images'"
  description = "This check ensures that the container in the DaemonSet has 'always pull images' configured for admission control plugin."
  query       = query.daemonset_container_admission_control_plugin_always_pull_images

  tags = local.daemonset_common_tags
}

control "daemonset_container_admission_control_plugin_no_always_admit" {
  title       = "DaemonSet containers admission control plugin should not be set to 'always admit'"
  description = "This check ensures that the container in the DaemonSet has an admission control plugin not set to 'always admit'."
  query       = query.daemonset_container_admission_control_plugin_no_always_admit

  tags = local.daemonset_common_tags
}
