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

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_audit_log_path_configured" {
  title       = "CronJob containers should have audit log path configured appropriately"
  description = "This check ensures that the container in the CronJob has audit log path configured appropriately."
  query       = query.cronjob_container_argument_audit_log_path_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_audit_log_maxage_greater_than_30" {
  title       = "CronJob containers should have audit log max-age set to 30 or greater"
  description = "This check ensures that the container in the CronJob has audit log max-age set to 30 or greater."
  query       = query.cronjob_container_argument_audit_log_maxage_greater_than_30

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_audit_log_maxbackup_greater_than_10" {
  title       = "CronJob containers should have audit log max backup set to 10 or greater"
  description = "This check ensures that the container in the CronJob has audit log max backup set to 10 or greater."
  query       = query.cronjob_container_argument_audit_log_maxbackup_greater_than_10

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_audit_log_maxsize_greater_than_100" {
  title       = "CronJob containers should have audit log max size set to 100 or greater"
  description = "This check ensures that the container in the CronJob has audit log max size set to 100 or greater."
  query       = query.cronjob_container_argument_audit_log_maxsize_greater_than_100

  tags = local.cronjob_common_tags
}

control "cronjob_container_no_argument_basic_auth_file" {
  title       = "CronJob containers argument basic auth file should not be set"
  description = "This check ensures that the CronJob container does not have an argument basic auth file set."
  query       = query.cronjob_container_no_argument_basic_auth_file

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_etcd_cafile_configured" {
  title       = "CronJob containers argument etcd cafile should be set"
  description = "This check ensures that the container in the CronJob has argument etcd cafile set."
  query       = query.cronjob_container_argument_etcd_cafile_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_authorization_mode_node" {
  title       = "CronJob containers argument authorization mode should have node"
  description = "This check ensures that the container in the CronJob has node included in the argument authorization mode."
  query       = query.cronjob_container_argument_authorization_mode_node

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_authorization_mode_no_always_allow" {
  title       = "CronJob containers argument authorization mode should not be set to 'always allow'"
  description = "This check ensures that the container in the CronJob has argument authorization mode not set to 'always allow'."
  query       = query.cronjob_container_argument_authorization_mode_no_always_allow

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_authorization_mode_rbac" {
  title       = "CronJob containers argument authorization mode should have RBAC"
  description = "This check ensures that the container in the CronJob has RBAC included in the argument authorization mode."
  query       = query.cronjob_container_argument_authorization_mode_rbac

  tags = local.cronjob_common_tags
}

control "cronjob_container_no_argument_insecure_bind_address" {
  title       = "CronJob containers argument insecure bind address should not be set"
  description = "This check ensures that the CronJob container does not have an argument insecure bind address set."
  query       = query.cronjob_container_no_argument_insecure_bind_address

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kubelet_https_enabled" {
  title       = "CronJob containers argument kubelet HTTPS should be enabled"
  description = "This check ensures that the container in the CronJob has kubelet HTTPS argument enabled."
  query       = query.cronjob_container_argument_kubelet_https_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_insecure_port_0" {
  title       = "CronJob containers argument insecure port should be set to 0"
  description = "This check ensures that the container in the CronJob has insecure port set to 0."
  query       = query.cronjob_container_argument_insecure_port_0

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kubelet_client_certificate_and_key_configured" {
  title       = "CronJob containers argument kubelet client certificate and key should be configured"
  description = "This check ensures that the container in the CronJob has kubelet client certificate and key argument configured."
  query       = query.cronjob_container_argument_kubelet_client_certificate_and_key_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured" {
  title       = "CronJob containers argument apiserver etcd certfile and keyfile should be configured"
  description = "This check ensures that the container in the CronJob has apiserver etcd certfile and keyfile argument configured."
  query       = query.cronjob_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_admission_control_plugin_always_pull_images" {
  title       = "CronJob containers admission control plugin should be set to 'always pull images'"
  description = "This check ensures that the container in the CronJob has 'always pull images' configured for the admission control plugin."
  query       = query.cronjob_container_admission_control_plugin_always_pull_images

  tags = local.cronjob_common_tags
}

control "cronjob_container_admission_control_plugin_no_always_admit" {
  title       = "CronJob containers admission control plugin should not be set to 'always admit'"
  description = "This check ensures that the container in the CronJob has an admission control plugin not set to 'always admit'."
  query       = query.cronjob_container_admission_control_plugin_no_always_admit

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kube_scheduler_profiling_disabled" {
  title       = "CronJob containers kube scheduler profiling should be disabled"
  description = "This check ensures that the container in the CronJob has kube scheduler profiling disabled."
  query       = query.cronjob_container_argument_kube_scheduler_profiling_disabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kube_scheduler_bind_address_127_0_0_1" {
  title       = "CronJob containers argument kube-scheduler bind address should be set to 127.0.0.1"
  description = "This check ensures that the container in the CronJob has argument kube-scheduler bind address set to 127.0.0.1."
  query       = query.cronjob_container_argument_kube_scheduler_bind_address_127_0_0_1

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_protect_kernel_defaults_enabled" {
  title       = "CronJob containers argument protect kernel defaults should be enabled"
  description = "This check ensures that the container in the CronJob has argument protect kernel defaults enabled."
  query       = query.cronjob_container_argument_protect_kernel_defaults_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_make_iptables_util_chains_enabled" {
  title       = "CronJob containers argument make iptables util chains should be enabled"
  description = "This check ensures that the container in the CronJob has argument make iptables util chains enabled."
  query       = query.cronjob_container_argument_make_iptables_util_chains_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured" {
  title       = "CronJob containers should have kubelet TLS cert file and TLS private key file configured appropriately"
  description = "This check ensures that the container in the CronJob has kubelet TLS cert file and TLS private key file configured appropriately."
  query       = query.cronjob_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_no_argument_hostname_override_configured" {
  title       = "CronJob containers argument hostname override should not be configured"
  description = "This check ensures that the container in the CronJob has argument hostname override not configured."
  query       = query.cronjob_container_no_argument_hostname_override_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kube_controller_manager_profiling_disabled" {
  title       = "CronJob containers kube controller manager profiling should be disabled"
  description = "This check ensures that the container in the CronJob has kube controller manager profiling disabled."
  query       = query.cronjob_container_argument_kube_controller_manager_profiling_disabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_etcd_auto_tls_disabled" {
  title       = "CronJob containers argument etcd auto TLS should be disabled"
  description = "This check ensures that the container in the CronJob has argument etcd auto TLS disabled."
  query       = query.cronjob_container_argument_etcd_auto_tls_disabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kube_controller_manager_service_account_credentials_enabled" {
  title       = "CronJob containers argument kube controller manager service account credentials should be enabled"
  description = "This check ensures that the container in the CronJob has argument kube controller manager service account credentials enabled."
  query       = query.cronjob_container_argument_kube_controller_manager_service_account_credentials_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kubelet_authorization_mode_no_always_allow" {
  title       = "CronJob containers argument kubelet authorization mode should not be set to 'always allow'"
  description = "This check ensures that the container in the CronJob has argument kubelet authorization mode not set to 'always allow'."
  query       = query.cronjob_container_argument_kubelet_authorization_mode_no_always_allow

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kube_controller_manager_service_account_private_key_file_configured" {
  title       = "CronJob containers should have kube controller manager service account private key file configured appropriately"
  description = "This check ensures that the container in the CronJob has kube controller manager service account private key file configured appropriately."
  query       = query.cronjob_container_argument_kube_controller_manager_service_account_private_key_file_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kubelet_read_only_port_0" {
  title       = "CronJob containers argument kubelet read only port shoule be set 0"
  description = "This check ensures that the container in the CronJob has argument kubelet read only port set to 0."
  query       = query.cronjob_container_argument_kubelet_read_only_port_0

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kube_controller_manager_root_ca_file_configured" {
  title       = "CronJob containers should have kube controller manager root ca file configured appropriately"
  description = "This check ensures that the container in the CronJob has kube controller manager root ca file configured appropriately."
  query       = query.cronjob_container_argument_kube_controller_manager_root_ca_file_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_namespace_lifecycle_enabled" {
  title       = "CronJob containers argument admission control plugin NamespaceLifecycle is enabled"
  description = "This check ensures that the container in the CronJob has argument admission control plugin NamespaceLifecycle disabled."
  query       = query.cronjob_container_argument_namespace_lifecycle_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_etcd_client_cert_auth_enabled" {
  title       = "CronJob containers argument etcd client cert auth should be enabled"
  description = "This check ensures that the container in the CronJob has argument etcd client cert auth enabled."
  query       = query.cronjob_container_argument_etcd_client_cert_auth_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_service_account_lookup_enabled" {
  title       = "CronJob containers argument service account lookup should be enabled"
  description = "This check ensures that the container in the CronJob has argument service account lookup enabled."
  query       = query.cronjob_container_argument_service_account_lookup_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_token_auth_file_not_configured" {
  title       = "CronJob containers token auth file should not be configured"
  description = "This check ensures that the container in the CronJob does not have token auth file configured."
  query       = query.cronjob_container_token_auth_file_not_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_kubelet_certificate_authority_configured" {
  title       = "CronJob containers should have kubelet certificate authority configured appropriately"
  description = "This check ensures that the container in the CronJob has kubelet certificate authority configured appropriately."
  query       = query.cronjob_container_kubelet_certificate_authority_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_node_restriction_enabled" {
  title       = "CronJob containers argument admission control plugin NodeRestriction is enabled"
  description = "This check ensures that the container in the CronJob has argument admission control plugin where NodeRestriction is enabled."
  query       = query.cronjob_container_argument_node_restriction_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_pod_security_policy_enabled" {
  title       = "CronJob containers argument admission control plugin PodSecurityPolicy is enabled"
  description = "This check ensures that the container in the CronJob has argument admission control plugin where PodSecurityPolicy is enabled."
  query       = query.cronjob_container_argument_pod_security_policy_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_security_context_deny_enabled" {
  title       = "CronJob containers argument admission control plugin where either PodSecurityPolicy or SecurityContextDeny is enabled"
  description = "This check ensures that the container in the CronJob has argument admission control plugin where either PodSecurityPolicy or SecurityContextDeny is enabled."
  query       = query.cronjob_container_argument_security_context_deny_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kube_apiserver_profiling_disabled" {
  title       = "CronJob containers kube apiserver profiling should be disabled"
  description = "This check ensures that the container in the CronJob has kube apiserver profiling disabled."
  query       = query.cronjob_container_argument_kube_apiserver_profiling_disabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_secure_port_not_0" {
  title       = "CronJob containers argument secure port should not be set to 0"
  description = "This check ensures that the container in the CronJob has secure port not set to 0."
  query       = query.cronjob_container_argument_secure_port_not_0

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_service_account_key_file_appropriate" {
  title       = "CronJob containers --service-account-key-file argument should be set as appropriate"
  description = "This check ensures that the container in the CronJob has the --service-account-key-file argument set as appropriate."
  query       = query.cronjob_container_argument_service_account_key_file_appropriate

  tags = local.cronjob_common_tags
}

control "cronjob_container_kubernetes_dashboard_not_deployed" {
  title       = "CronJob containers Kubernetes dashboard should not be deployed"
  description = "This check ensures that the container in the CronJob does not have Kubernetes dashboard deployed."
  query       = query.cronjob_container_kubernetes_dashboard_not_deployed

  tags = local.cronjob_common_tags
}

control "cronjob_container_streaming_connection_idle_timeout_not_zero" {
  title       = "CronJob containers argument --streaming-connection-idle-timeout should not be set to 0"
  description = "This check ensures that the container in the CronJob has --streaming-connection-idle-timeout not set to 0."
  query       = query.cronjob_container_streaming_connection_idle_timeout_not_zero

  tags = local.cronjob_common_tags
}

control "cronjob_container_strong_kubelet_cryptographic_ciphers" {
  title       = "CronJob containers kubelet should only make use of strong cryptographic ciphers"
  description = "This check ensures that the container in the CronJob has kublet using strong cryptographic ciphers."
  query       = query.cronjob_container_strong_kubelet_cryptographic_ciphers

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_rotate_kubelet_server_certificate_enabled" {
  title       = "CronJob containers argument rotate kubelet server certificate should be enabled"
  description = "This check ensures that the container in the CronJob has argument rotate kubelet server certificate enabled."
  query       = query.cronjob_container_argument_rotate_kubelet_server_certificate_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_etcd_certfile_and_keyfile_configured" {
  title       = "CronJob containers should have etcd certfile and keyfile configured appropriately"
  description = "This check ensures that the container in the CronJob has etcd certfile and keyfile configured appropriately."
  query       = query.cronjob_container_argument_etcd_certfile_and_keyfile_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_etcd_peer_certfile_and_peer_keyfile_configured" {
  title       = "CronJob containers should have etcd peer certfile and peer keyfile configured appropriately"
  description = "This check ensures that the container in the CronJob has etcd peer certfile and peer keyfile configured appropriately."
  query       = query.cronjob_container_argument_etcd_peer_certfile_and_peer_keyfile_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kube_controller_manager_bind_address_127_0_0_1" {
  title       = "CronJob containers argument kube-controller-manager bind address should be set to 127.0.0.1"
  description = "This check ensures that the container in the CronJob has argument kube-controller-manager bind address set to 127.0.0.1."
  query       = query.cronjob_container_argument_kube_controller_manager_bind_address_127_0_0_1

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_service_account_enabled" {
  title       = "CronJob containers argument admission control plugin where ServiceAccount is enabled"
  description = "This check ensures that the container in the CronJob has argument admission control plugin where ServiceAccount is enabled."
  query       = query.cronjob_container_argument_service_account_enabled

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kubelet_terminated_pod_gc_threshold_configured" {
  title       = "CronJob containers should have kubelet terminated pod gc threshold configured appropriately"
  description = "This check ensures that the container in the CronJob has kubelet terminated pod gc threshold configured appropriately."
  query       = query.cronjob_container_argument_kubelet_terminated_pod_gc_threshold_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kubelet_client_ca_file_configured" {
  title       = "CronJob containers should have kubelet client ca file configured appropriately"
  description = "This check ensures that the container in the CronJob has kubelet client ca file configured appropriately."
  query       = query.cronjob_container_argument_kubelet_client_ca_file_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured" {
  title       = "CronJob containers should have kube-apiserver TLS cert file and TLS private key file configured appropriately"
  description = "This check ensures that the container in the CronJob has kube-apiserver TLS cert file and TLS private key file configured appropriately."
  query       = query.cronjob_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured

  tags = local.cronjob_common_tags
}

control "cronjob_container_strong_kube_apiserver_cryptographic_ciphers" {
  title       = "CronJob containers kube-apiserver should only make use of strong cryptographic ciphers"
  description = "This check ensures that the container in the CronJob has kube-apiserver using strong cryptographic ciphers."
  query       = query.cronjob_container_strong_kube_apiserver_cryptographic_ciphers

  tags = local.cronjob_common_tags
}