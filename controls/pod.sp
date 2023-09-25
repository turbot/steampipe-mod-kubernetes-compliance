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
  description = "Container in Pod should minimize the admission of containers with added capability. Adding capabilities to container increases the risk of container breakout."
  query       = query.pod_container_with_added_capabilities

  tags = local.pod_common_tags
}

control "pod_container_security_context_exists" {
  title       = "Pod containers should have security context"
  description = "This check ensures that the container in the Pod has security context defined."
  query       = query.pod_container_security_context_exists

  tags = local.pod_common_tags
}

control "pod_container_image_tag_specified" {
  title       = "Pod containers have image tag specified which should be fixed not latest or blank"
  description = "This check ensures that the container in the Pod has image tag fixed not latest or blank."
  query       = query.pod_container_image_tag_specified

  tags = local.pod_common_tags
}

control "pod_container_image_pull_policy_always" {
  title       = "Pod containers has image pull policy set to Always"
  description = "This check ensures that the container in the Pod has image pull policy set to Always."
  query       = query.pod_container_image_pull_policy_always

  tags = local.pod_common_tags
}

control "pod_container_admission_capability_restricted" {
  title       = "Pod containers should has admission capability restricted"
  description = "This check ensures that the container in the Pod has admission capability restricted."
  query       = query.pod_container_admission_capability_restricted

  tags = local.pod_common_tags
}

control "pod_container_encryption_providers_configured" {
  title       = "Pod containers should has encryption providers configured appropriately"
  description = "This check ensures that the container in the Pod has encryption providers configured appropriately."
  query       = query.pod_container_encryption_providers_configured

  tags = local.pod_common_tags
}

control "pod_container_sys_admin_capability_disabled" {
  title       = "Pod containers should not use CAP_SYS_ADMIN linux capability"
  description = "This check ensures that the container in the Pod does not use CAP_SYS_ADMIN Linux capability."
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
  title       = "Pod containers should minimize its admission with capabilities assigned"
  description = "This check ensures that the container in the Pod minimizes its admission with capabilities assigned."
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
  description = "This check ensures that the container in the Pod has peer client cert auth enabled."
  query       = query.pod_container_rotate_certificate_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_event_qps_less_than_5" {
  title       = "Pod containers argument event qps should be less than 5"
  description = "This check ensures that the container in the Pod has argument event qps set to less than 5."
  query       = query.pod_container_argument_event_qps_less_than_5

  tags = local.pod_common_tags
}

control "pod_container_argument_anonymous_auth_disabled" {
  title       = "Pod containers argument anonymous auth should be disabled"
  description = "This check ensures that the container in the Pod has anonymous auth disabled."
  query       = query.pod_container_argument_anonymous_auth_disabled

  tags = local.pod_common_tags
}

control "pod_container_argument_audit_log_path_configured" {
  title       = "Pod containers should have audit log path configured appropriately"
  description = "This check ensures that the container in the Pod has audit log path configured appropriately."
  query       = query.pod_container_argument_audit_log_path_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_audit_log_maxage_greater_than_30" {
  title       = "Pod containers should have audit log max-age set to 30 or greater"
  description = "This check ensures that the container in the Pod has audit log max-age set to 30 or greater."
  query       = query.pod_container_argument_audit_log_maxage_greater_than_30

  tags = local.pod_common_tags
}

control "pod_container_argument_audit_log_maxbackup_greater_than_10" {
  title       = "Pod containers should have audit log max backup set to 10 or greater"
  description = "This check ensures that the container in the Pod has audit log max backup set to 10 or greater."
  query       = query.pod_container_argument_audit_log_maxbackup_greater_than_10

  tags = local.pod_common_tags
}

control "pod_container_argument_audit_log_maxsize_greater_than_100" {
  title       = "Pod containers should have audit log max size set to 100 or greater"
  description = "This check ensures that the container in the Pod has audit log max size set to 100 or greater."
  query       = query.pod_container_argument_audit_log_maxsize_greater_than_100

  tags = local.pod_common_tags
}

control "pod_container_no_argument_basic_auth_file" {
  title       = "Pod containers argument basic auth file should not be set"
  description = "This check ensures that the container in the Pod does not have an argument basic auth file set."
  query       = query.pod_container_no_argument_basic_auth_file

  tags = local.pod_common_tags
}

control "pod_container_argument_etcd_cafile_configured" {
  title       = "Pod containers argument etcd cafile should be set"
  description = "This check ensures that the container in the Pod has argument etcd cafile set."
  query       = query.pod_container_argument_etcd_cafile_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_authorization_mode_node" {
  title       = "Pod containers argument authorization mode should have node"
  description = "This check ensures that the container in the Pod has node included in the argument authorization mode."
  query       = query.pod_container_argument_authorization_mode_node

  tags = local.pod_common_tags
}

control "pod_container_argument_authorization_mode_no_always_allow" {
  title       = "Pod containers argument authorization mode should not be set to 'always allow'"
  description = "This check ensures that the container in the Pod has argument authorization mode not set to 'always allow'."
  query       = query.pod_container_argument_authorization_mode_no_always_allow

  tags = local.pod_common_tags
}

control "pod_container_argument_authorization_mode_rbac" {
  title       = "Pod containers argument authorization mode should have RBAC"
  description = "This check ensures that the container in the Pod has RBAC included in the argument authorization mode."
  query       = query.pod_container_argument_authorization_mode_rbac

  tags = local.pod_common_tags
}

control "pod_container_no_argument_insecure_bind_address" {
  title       = "Pod containers argument insecure bind address should not be set"
  description = "This check ensures that the container in the Pod does not have an argument insecure bind address set."
  query       = query.pod_container_no_argument_insecure_bind_address

  tags = local.pod_common_tags
}

control "pod_container_argument_kubelet_https_enabled" {
  title       = "Pod containers argument kubelet HTTPS should be enabled"
  description = "This check ensures that the container in the Pod has kubelet HTTPS argument enabled."
  query       = query.pod_container_argument_kubelet_https_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_insecure_port_0" {
  title       = "Pod containers argument insecure port should be set to 0"
  description = "This check ensures that the container in the Pod has insecure port set to 0."
  query       = query.pod_container_argument_insecure_port_0

  tags = local.pod_common_tags
}

control "pod_container_argument_kubelet_client_certificate_and_key_configured" {
  title       = "Pod containers argument kubelet client certificate and key should be configured"
  description = "This check ensures that the container in the Pod has kubelet client certificate and key argument configured."
  query       = query.pod_container_argument_kubelet_client_certificate_and_key_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_etcd_certfile_and_keyfile_configured" {
  title       = "Pod containers argument etcd certfile and keyfile should be configured"
  description = "This check ensures that the container in the Pod has etcd certfile and keyfile argument configured."
  query       = query.pod_container_argument_etcd_certfile_and_keyfile_configured

  tags = local.pod_common_tags
}

control "pod_container_admission_control_plugin_always_pull_images" {
  title       = "Pod containers admission control plugin should be set to 'always pull images'"
  description = "This check ensures that the container in the Pod has 'always pull images' configured for admission control plugin."
  query       = query.pod_container_admission_control_plugin_always_pull_images

  tags = local.pod_common_tags
}

control "pod_container_admission_control_plugin_no_always_admit" {
  title       = "Pod containers admission control plugin should not be set to 'always admit'"
  description = "This check ensures that the container in the Pod has an admission control plugin not set to 'always admit'."
  query       = query.pod_container_admission_control_plugin_no_always_admit

  tags = local.pod_common_tags
}

control "pod_container_argument_kube_scheduler_profiling_disabled" {
  title       = "Pod containers kube scheduler profiling should be disabled"
  description = "This check ensures that the container in the Pod has kube scheduler profiling disabled."
  query       = query.pod_container_argument_kube_scheduler_profiling_disabled

  tags = local.pod_common_tags
}

control "pod_container_argument_bind_address_127_0_0_1" {
  title       = "Pod containers argument bind address should be set to 127.0.0.1"
  description = "This check ensures that the container in the Pod has argument bind address set to 127.0.0.1."
  query       = query.pod_container_argument_bind_address_127_0_0_1

  tags = local.pod_common_tags
}

control "pod_container_argument_protect_kernel_defaults_enabled" {
  title       = "Pod containers argument protect kernel defaults should be enabled"
  description = "This check ensures that the container in the Pod has argument protect kernel defaults enabled."
  query       = query.pod_container_argument_protect_kernel_defaults_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_make_iptables_util_chains_enabled" {
  title       = "Pod containers argument make iptables util chains should be enabled"
  description = "This check ensures that the container in the Pod has argument make iptables util chains enabled."
  query       = query.pod_container_argument_make_iptables_util_chains_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_tls_cert_file_and_tls_private_key_file_configured" {
  title       = "Pod containers should have TLS cert file and TLS private key file configured appropriately"
  description = "This check ensures that the container in the Pod has TLS cert file and TLS private key file configured appropriately."
  query       = query.pod_container_argument_tls_cert_file_and_tls_private_key_file_configured

  tags = local.pod_common_tags
}

control "pod_container_no_argument_hostname_override_configured" {
  title       = "Pod containers argument hostname override should not be configured"
  description = "This check ensures that the container in the Pod has argument hostname override not configured."
  query       = query.pod_container_no_argument_hostname_override_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_kube_controller_manager_profiling_disabled" {
  title       = "Pod containers kube controller manager profiling should be disabled"
  description = "This check ensures that the container in the Pod has kube controller manager profiling disabled."
  query       = query.pod_container_argument_kube_controller_manager_profiling_disabled

  tags = local.pod_common_tags
}

control "pod_container_argument_etcd_auto_tls_disabled" {
  title       = "Pod containers argument etcd auto TLS should be disabled"
  description = "This check ensures that the container in the Pod has argument etcd auto TLS disabled."
  query       = query.pod_container_argument_etcd_auto_tls_disabled

  tags = local.pod_common_tags
}