locals {
  deployment_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Deployment"
  })
}

control "deployment_cpu_limit" {
  title       = replace(local.container_cpu_limit_title, "__KIND__", "Deployment")
  description = replace(local.container_cpu_limit_desc, "__KIND__", "Deployment")
  query       = query.deployment_cpu_limit

  tags = merge(local.deployment_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "deployment_cpu_request" {
  title       = replace(local.container_cpu_request_title, "__KIND__", "Deployment")
  description = replace(local.container_cpu_request_desc, "__KIND__", "Deployment")
  query       = query.deployment_cpu_request

  tags = merge(local.deployment_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "deployment_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "Deployment")
  description = replace(local.container_memory_limit_desc, "__KIND__", "Deployment")
  query       = query.deployment_memory_limit

  tags = merge(local.deployment_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "deployment_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "Deployment")
  description = replace(local.container_memory_request_desc, "__KIND__", "Deployment")
  query       = query.deployment_memory_request

  tags = merge(local.deployment_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "deployment_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "Deployment")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "Deployment")
  query       = query.deployment_container_privilege_disabled

  tags = merge(local.deployment_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "deployment_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "Deployment")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "Deployment")
  query       = query.deployment_container_privilege_escalation_disabled

  tags = merge(local.deployment_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "deployment_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "Deployment")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "Deployment")
  query       = query.deployment_host_network_access_disabled

  tags = merge(local.deployment_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "deployment_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "Deployment")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "Deployment")
  query       = query.deployment_hostpid_hostipc_sharing_disabled

  tags = merge(local.deployment_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "deployment_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "Deployment")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "Deployment")
  query       = query.deployment_immutable_container_filesystem

  tags = merge(local.deployment_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "deployment_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "Deployment")
  description = replace(local.non_root_container_desc, "__KIND__", "Deployment")
  query       = query.deployment_non_root_container

  tags = merge(local.deployment_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "deployment_container_readiness_probe" {
  title       = "Deployment containers should have readiness probe"
  description = "Containers in Deployment definition should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill it’s work."
  query       = query.deployment_container_readiness_probe

  tags = local.deployment_common_tags
}

control "deployment_container_liveness_probe" {
  title       = "Deployment containers should have liveness probe"
  description = "Containers in Deployment definition should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  query       = query.deployment_container_liveness_probe

  tags = local.deployment_common_tags
}

control "deployment_container_privilege_port_mapped" {
  title       = "Deployment containers should not be mapped with privilege ports"
  description = "Privileged ports `0 to 1024` should not be mapped with deployment containers. Normal users and processes are not allowed to use them for various security reasons."
  query       = query.deployment_container_privilege_port_mapped

  tags = local.deployment_common_tags
}

control "deployment_default_namespace_used" {
  title       = "Deployment definition should not use default namespace"
  description = "Default namespace should not be used by deployment definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.deployment_default_namespace_used

  tags = merge(local.deployment_common_tags, {
    cis = "true"
  })
}

control "deployment_replica_minimum_3" {
  title       = "Deployment should have a minimum of 3 replicas"
  description = "Replicas in the deployment should be at least 3 to increase the fault tolerance of the deployment."
  query       = query.deployment_replica_minimum_3

  tags = local.deployment_common_tags
}

control "deployment_default_seccomp_profile_enabled" {
  title       = "Seccomp profile is set to docker/default in Deployment definition"
  description = "In Deployment definition seccomp profile should be set to docker/default. Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  query       = query.deployment_default_seccomp_profile_enabled

  tags = merge(local.deployment_common_tags, {
    cis = "true"
  })
}

control "deployment_container_with_added_capabilities" {
  title       = "Deployment containers should minimize the admission of containers with added capability"
  description = "Container in Deployment should minimize the admission of containers with added capability. Adding capabilities to container increases the risk of container breakout."
  query       = query.deployment_container_with_added_capabilities

  tags = local.deployment_common_tags
}

control "deployment_container_security_context_exists" {
  title       = "Deployment containers should has security context defined"
  description = "This check ensures that the container in a Deployment definition has security context defined."
  query       = query.deployment_container_security_context_exists

  tags = local.deployment_common_tags
}

control "deployment_container_image_tag_specified" {
  title       = "Deployment containers have image tag specified which should be fixed not latest or blank"
  description = "This check ensures that the container in the Deployment has image tag fixed not latest or blank."
  query       = query.deployment_container_image_tag_specified

  tags = local.deployment_common_tags
}

control "deployment_container_image_pull_policy_always" {
  title       = "Deployment containers has image pull policy set to Always"
  description = "This check ensures that the container in the Deployment has image pull policy set to Always."
  query       = query.deployment_container_image_pull_policy_always

  tags = local.deployment_common_tags
}

control "deployment_container_admission_capability_restricted" {
  title       = "Deployment containers should has admission capability restricted"
  description = "This check ensures that the container in the Deployment has admission capability restricted."
  query       = query.deployment_container_admission_capability_restricted

  tags = local.deployment_common_tags
}

control "deployment_container_encryption_providers_configured" {
  title       = "Deployment containers should has encryption providers configured appropriately"
  description = "This check ensures that the container in the Deployment has encryption providers configured appropriately."
  query       = query.deployment_container_encryption_providers_configured

  tags = local.deployment_common_tags
}

control "deployment_container_sys_admin_capability_disabled" {
  title       = "Deployment containers should not use CAP_SYS_ADMIN linux capability"
  description = "This check ensures that the container in the Deployment does not use CAP_SYS_ADMIN Linux capability."
  query       = query.deployment_container_sys_admin_capability_disabled

  tags = local.deployment_common_tags
}

control "deployment_container_capabilities_drop_all" {
  title       = "Deployment containers should minimize its admission with capabilities assigned"
  description = "This check ensures that the container in the Deployment minimizes its admission with capabilities assigned."
  query       = query.deployment_container_capabilities_drop_all

  tags = local.deployment_common_tags
}

control "deployment_container_arg_peer_client_cert_auth_enabled" {
  title       = "Deployment containers peer client cert auth should be enabled"
  description = "This check ensures that the container in the Deployment has peer client cert auth enabled."
  query       = query.deployment_container_arg_peer_client_cert_auth_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_rotate_certificate_enabled" {
  title       = "Deployment containers certificate rotation should be enabled"
  description = "This check ensures that the container in the Deployment has certificate rotation enabled."
  query       = query.deployment_container_rotate_certificate_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_event_qps_less_than_5" {
  title       = "Deployment containers argument event qps should be less than 5"
  description = "This check ensures that the container in the Deployment has argument event qps set to less than 5."
  query       = query.deployment_container_argument_event_qps_less_than_5

  tags = local.deployment_common_tags
}

control "deployment_container_argument_anonymous_auth_disabled" {
  title       = "Deployment containers argument anonymous auth should be disabled"
  description = "This check ensures that the container in the Deployment has anonymous auth disabled."
  query       = query.deployment_container_argument_anonymous_auth_disabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_audit_log_path_configured" {
  title       = "Deployment containers should have audit log path configured appropriately"
  description = "This check ensures that the container in the Deployment has audit log path configured appropriately."
  query       = query.deployment_container_argument_audit_log_path_configured

  tags = local.deployment_common_tags
}

control "deployment_container_argument_audit_log_maxage_greater_than_30" {
  title       = "Deployment containers should have audit log max-age set to 30 or greater"
  description = "This check ensures that the container in the Deployment has audit log max-age set to 30 or greater."
  query       = query.deployment_container_argument_audit_log_maxage_greater_than_30

  tags = local.deployment_common_tags
}

control "deployment_container_argument_audit_log_maxbackup_greater_than_10" {
  title       = "Deployment containers should have audit log max backup set to 10 or greater"
  description = "This check ensures that the container in the Deployment has audit log max backup set to 10 or greater."
  query       = query.deployment_container_argument_audit_log_maxbackup_greater_than_10

  tags = local.deployment_common_tags
}

control "deployment_container_argument_audit_log_maxsize_greater_than_100" {
  title       = "Deployment containers should have audit log max size set to 100 or greater"
  description = "This check ensures that the container in the Deployment has audit log max size set to 100 or greater."
  query       = query.deployment_container_argument_audit_log_maxsize_greater_than_100

  tags = local.deployment_common_tags
}

control "deployment_container_no_argument_basic_auth_file" {
  title       = "Deployment containers argument basic auth file should not be set"
  description = "This check ensures that the container in the Deployment does not have an argument basic auth file set."
  query       = query.deployment_container_no_argument_basic_auth_file

  tags = local.deployment_common_tags
}

control "deployment_container_argument_etcd_cafile_configured" {
  title       = "Deployment containers argument etcd cafile should be set"
  description = "This check ensures that the container in the Deployment has argument etcd cafile set."
  query       = query.deployment_container_argument_etcd_cafile_configured

  tags = local.deployment_common_tags
}

control "deployment_container_argument_authorization_mode_node" {
  title       = "Deployment containers argument authorization mode should have node"
  description = "This check ensures that the container in the Deployment has node included in the argument authorization mode."
  query       = query.deployment_container_argument_authorization_mode_node

  tags = local.deployment_common_tags
}

control "deployment_container_argument_authorization_mode_no_always_allow" {
  title       = "Deployment containers argument authorization mode should not be set to 'always allow'"
  description = "This check ensures that the container in the Deployment has argument authorization mode not set to 'always allow'."
  query       = query.deployment_container_argument_authorization_mode_no_always_allow

  tags = local.deployment_common_tags
}

control "deployment_container_argument_authorization_mode_rbac" {
  title       = "Deployment containers argument authorization mode should have RBAC"
  description = "This check ensures that the container in the Deployment has RBAC included in the argument authorization mode."
  query       = query.deployment_container_argument_authorization_mode_rbac

  tags = local.deployment_common_tags
}

control "deployment_container_no_argument_insecure_bind_address" {
  title       = "Deployment containers argument insecure bind address should not be set"
  description = "This check ensures that the container in the Deployment does not have an argument insecure bind address set."
  query       = query.deployment_container_no_argument_insecure_bind_address

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kubelet_https_enabled" {
  title       = "Deployment containers argument kubelet HTTPS should be enabled"
  description = "This check ensures that the container in the Deployment has kubelet HTTPS argument enabled."
  query       = query.deployment_container_argument_kubelet_https_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_insecure_port_0" {
  title       = "Deployment containers argument insecure port should be set to 0"
  description = "This check ensures that the container in the Deployment has insecure port set to 0."
  query       = query.deployment_container_argument_insecure_port_0

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kubelet_client_certificate_and_key_configured" {
  title       = "Deployment containers argument kubelet client certificate and key should be configured"
  description = "This check ensures that the container in the Deployment has kubelet client certificate and key argument configured."
  query       = query.deployment_container_argument_kubelet_client_certificate_and_key_configured

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured" {
  title       = "Deployment containers argument apiserver etcd certfile and keyfile should be configured"
  description = "This check ensures that the container in the Deployment has apiserver etcd certfile and keyfile argument configured."
  query       = query.deployment_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured

  tags = local.deployment_common_tags
}

control "deployment_container_admission_control_plugin_always_pull_images" {
  title       = "Deployment containers admission control plugin should be set to 'always pull images'"
  description = "This check ensures that the container in the Deployment has 'always pull images' configured for admission control plugin."
  query       = query.deployment_container_admission_control_plugin_always_pull_images

  tags = local.deployment_common_tags
}

control "deployment_container_admission_control_plugin_no_always_admit" {
  title       = "Deployment containers admission control plugin should not be set to 'always admit'"
  description = "This check ensures that the container in the Deployment has an admission control plugin not set to 'always admit'."
  query       = query.deployment_container_admission_control_plugin_no_always_admit

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kube_scheduler_profiling_disabled" {
  title       = "Deployment containers kube scheduler profiling should be disabled"
  description = "This check ensures that the container in the Deployment has kube scheduler profiling disabled."
  query       = query.deployment_container_argument_kube_scheduler_profiling_disabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kube_scheduler_bind_address_127_0_0_1" {
  title       = "Deployment containers argument kube-scheduler bind address should be set to 127.0.0.1"
  description = "This check ensures that the container in the Deployment has argument kube-scheduler bind address set to 127.0.0.1."
  query       = query.deployment_container_argument_kube_scheduler_bind_address_127_0_0_1

  tags = local.deployment_common_tags
}

control "deployment_container_argument_protect_kernel_defaults_enabled" {
  title       = "Deployment containers argument protect kernel defaults should be enabled"
  description = "This check ensures that the container in the Deployment has argument protect kernel defaults enabled."
  query       = query.deployment_container_argument_protect_kernel_defaults_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_make_iptables_util_chains_enabled" {
  title       = "Deployment containers argument make iptables util chains should be enabled"
  description = "This check ensures that the container in the Deployment has argument make iptables util chains enabled."
  query       = query.deployment_container_argument_make_iptables_util_chains_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_tls_cert_file_and_tls_private_key_file_configured" {
  title       = "Deployment containers should have TLS cert file and TLS private key file configured appropriately"
  description = "This check ensures that the container in the Deployment has TLS cert file and TLS private key file configured appropriately."
  query       = query.deployment_container_argument_tls_cert_file_and_tls_private_key_file_configured

  tags = local.deployment_common_tags
}

control "deployment_container_no_argument_hostname_override_configured" {
  title       = "Deployment containers argument hostname override should not be configured"
  description = "This check ensures that the container in the Deployment has argument hostname override not configured."
  query       = query.deployment_container_no_argument_hostname_override_configured

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kube_controller_manager_profiling_disabled" {
  title       = "Deployment containers kube controller manager profiling should be disabled"
  description = "This check ensures that the container in the Deployment has kube controller manager profiling disabled."
  query       = query.deployment_container_argument_kube_controller_manager_profiling_disabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_etcd_auto_tls_disabled" {
  title       = "Deployment containers argument etcd auto TLS should be disabled"
  description = "This check ensures that the container in the Deployment has argument etcd auto TLS disabled."
  query       = query.deployment_container_argument_etcd_auto_tls_disabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kube_controller_manager_service_account_credentials_enabled" {
  title       = "Deployment containers argument kube controller manager service account credentials should be enabled"
  description = "This check ensures that the container in the Deployment has argument kube controller manager service account credentials enabled."
  query       = query.deployment_container_argument_kube_controller_manager_service_account_credentials_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kubelet_authorization_mode_no_always_allow" {
  title       = "Deployment containers argument kubelet authorization mode should not be set to 'always allow'"
  description = "This check ensures that the container in the Deployment has argument kubelet authorization mode not set to 'always allow'."
  query       = query.deployment_container_argument_kubelet_authorization_mode_no_always_allow

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kube_controller_manager_service_account_private_key_file_configured" {
  title       = "Deployment containers should have kube controller manager service account private key file configured appropriately"
  description = "This check ensures that the container in the Deployment has kube controller manager service account private key file configured appropriately."
  query       = query.deployment_container_argument_kube_controller_manager_service_account_private_key_file_configured

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kubelet_read_only_port_0" {
  title       = "Deployment containers argument kubelet read only port shoule be set 0"
  description = "This check ensures that the container in the Deployment has argument kubelet read only port set to 0."
  query       = query.deployment_container_argument_kubelet_read_only_port_0

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kube_controller_manager_root_ca_file_configured" {
  title       = "Deployment containers should have kube controller manager root ca file configured appropriately"
  description = "This check ensures that the container in the Deployment has kube controller manager root ca file configured appropriately."
  query       = query.deployment_container_argument_kube_controller_manager_root_ca_file_configured

  tags = local.deployment_common_tags
}

control "deployment_container_argument_etcd_client_cert_auth_enabled" {
  title       = "Deployment containers argument etcd client cert auth should be enabled"
  description = "This check ensures that the container in the Deployment has argument etcd client cert auth enabled."
  query       = query.deployment_container_argument_etcd_client_cert_auth_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_namespace_lifecycle_enabled" {
  title       = "Deployment containers argument admission control plugin where NamespaceLifecycle is enabled"
  description = "This check ensures that the container in the Deployment has argument admission control plugin where NamespaceLifecycle is enabled."
  query       = query.deployment_container_argument_namespace_lifecycle_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_service_account_lookup_enabled" {
  title       = "Deployment containers argument service account lookup should be enabled"
  description = "This check ensures that the container in the Deployment has argument service account lookup enabled."
  query       = query.deployment_container_argument_service_account_lookup_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_token_auth_file_not_configured" {
  title       = "Deployment containers token auth file should not be configured"
  description = "This check ensures that the container in the Deployment does not have token auth file configured."
  query       = query.deployment_container_token_auth_file_not_configured

  tags = local.deployment_common_tags
}

control "deployment_container_kubelet_certificate_authority_configured" {
  title       = "Deployment containers should have kubelet certificate authority configured appropriately"
  description = "This check ensures that the container in the Deployment has kubelet certificate authority configured appropriately."
  query       = query.deployment_container_kubelet_certificate_authority_configured

  tags = local.deployment_common_tags
}

control "deployment_container_argument_node_restriction_enabled" {
  title       = "Deployment containers argument admission control plugin where NodeRestriction is enabled"
  description = "This check ensures that the container in the Deployment has argument admission control plugin where NodeRestriction is enabled."
  query       = query.deployment_container_argument_node_restriction_enabled

  tags = local.deployment_common_tags
}


### KP - start

control "deployment_container_argument_pod_security_policy_enabled" {
  title       = "Deployment containers argument admission control plugin where PodSecurityPolicy is enabled"
  description = "This check ensures that the container in the Deployment has argument admission control plugin where PodSecurityPolicy is enabled."
  query       = query.deployment_container_argument_pod_security_policy_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_security_context_deny_enabled" {
  title       = "Deployment containers argument admission control plugin where either PodSecurityPolicy or SecurityContextDeny is enabled"
  description = "This check ensures that the container in the Deployment has argument admission control plugin where either PodSecurityPolicy or SecurityContextDeny is enabled."
  query       = query.deployment_container_argument_security_context_deny_enabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kube_apiserver_profiling_disabled" {
  title       = "Deployment containers kube apiserver profiling should be disabled"
  description = "This check ensures that the container in the Deployment has kube apiserver profiling disabled."
  query       = query.deployment_container_argument_kube_apiserver_profiling_disabled

  tags = local.deployment_common_tags
}

control "deployment_container_argument_secure_port_not_0" {
  title       = "Deployment containers argument secure port should not be set to 0"
  description = "This check ensures that the container in the Deployment has secure port not set to 0."
  query       = query.deployment_container_argument_secure_port_not_0

  tags = local.deployment_common_tags
}

### KP - end


### PC - start

control "deployment_container_argument_etcd_certfile_and_keyfile_configured" {
  title       = "Deployment containers should have etcd certfile and keyfile configured appropriately"
  description = "This check ensures that the container in the Deployment has etcd certfile and keyfile configured appropriately."
  query       = query.deployment_container_argument_etcd_certfile_and_keyfile_configured

  tags = local.deployment_common_tags
}

control "deployment_container_argument_etcd_peer_certfile_and_peer_keyfile_configured" {
  title       = "Deployment containers should have etcd peer certfile and peer keyfile configured appropriately"
  description = "This check ensures that the container in the Deployment has etcd peer certfile and peer keyfile configured appropriately."
  query       = query.deployment_container_argument_etcd_peer_certfile_and_peer_keyfile_configured

  tags = local.deployment_common_tags
}

control "deployment_container_argument_kube_controller_manager_bind_address_127_0_0_1" {
  title       = "Deployment containers argument kube-controller-manager bind address should be set to 127.0.0.1"
  description = "This check ensures that the container in the Deployment has argument kube-controller-manager bind address set to 127.0.0.1."
  query       = query.deployment_container_argument_kube_controller_manager_bind_address_127_0_0_1

  tags = local.deployment_common_tags
}
### PC - end