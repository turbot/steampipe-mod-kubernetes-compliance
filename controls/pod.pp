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
  description = "This check ensures that the Pod container peer client cert auth should be enabled."
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

control "pod_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured" {
  title       = "Pod containers argument apiserver etcd certfile and keyfile should be configured"
  description = "This check ensures that the container in the Pod has apiserver etcd certfile and keyfile argument configured."
  query       = query.pod_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured

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

control "pod_container_argument_kube_scheduler_bind_address_127_0_0_1" {
  title       = "Pod containers argument kube-scheduler bind address should be set to 127.0.0.1"
  description = "This check ensures that the container in the Pod has argument kube-scheduler bind address set to 127.0.0.1."
  query       = query.pod_container_argument_kube_scheduler_bind_address_127_0_0_1

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

control "pod_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured" {
  title       = "Pod containers should have kubelet TLS cert file and TLS private key file configured appropriately"
  description = "This check ensures that the container in the Pod has kubelet TLS cert file and TLS private key file configured appropriately."
  query       = query.pod_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured

  tags = local.pod_common_tags
}

control "pod_container_no_argument_hostname_override_configured" {
  title       = "Pod containers argument hostname override should not be configured"
  description = "This check ensures that the container in the Pod does not have argument hostname override configured."
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

control "pod_container_argument_kube_controller_manager_service_account_credentials_enabled" {
  title       = "Pod containers argument kube controller manager service account credentials should be enabled"
  description = "This check ensures that the container in the Pod has argument kube controller manager service account credentials enabled."
  query       = query.pod_container_argument_kube_controller_manager_service_account_credentials_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_kubelet_authorization_mode_no_always_allow" {
  title       = "Pod containers argument kubelet authorization mode should not be set to 'always allow'"
  description = "This check ensures that the container in the Pod has argument kubelet authorization mode not set to 'always allow'."
  query       = query.pod_container_argument_kubelet_authorization_mode_no_always_allow

  tags = local.pod_common_tags
}

control "pod_container_argument_kube_controller_manager_service_account_private_key_file_configured" {
  title       = "Pod containers should have kube controller manager service account private key file configured appropriately"
  description = "This check ensures that the container in the Pod has kube controller manager service account private key file configured appropriately."
  query       = query.pod_container_argument_kube_controller_manager_service_account_private_key_file_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_kubelet_read_only_port_0" {
  title       = "Pod containers argument kubelet read-only port should be set to 0"
  description = "This check ensures that the container in the Pod has argument kubelet read-only port set to 0."
  query       = query.pod_container_argument_kubelet_read_only_port_0

  tags = local.pod_common_tags
}

control "pod_container_argument_kube_controller_manager_root_ca_file_configured" {
  title       = "Pod containers should have kube controller manager root CA file configured appropriately"
  description = "This check ensures that the container in the Pod has kube controller manager root CA file configured appropriately."
  query       = query.pod_container_argument_kube_controller_manager_root_ca_file_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_etcd_client_cert_auth_enabled" {
  title       = "Pod containers argument etcd client cert auth should be enabled"
  description = "This check ensures that the container in the Pod has argument etcd client cert auth enabled."
  query       = query.pod_container_argument_etcd_client_cert_auth_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_namespace_lifecycle_enabled" {
  title       = "Pod containers argument admission control plugin NamespaceLifecycle should be enabled"
  description = "This check ensures that the container in the Pod has argument admission control plugin NamespaceLifecycle enabled."
  query       = query.pod_container_argument_namespace_lifecycle_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_service_account_lookup_enabled" {
  title       = "Pod containers argument service account lookup should be enabled"
  description = "This check ensures that the container in the Pod has argument service account lookup enabled."
  query       = query.pod_container_argument_service_account_lookup_enabled

  tags = local.pod_common_tags
}

control "pod_container_token_auth_file_not_configured" {
  title       = "Pod containers token auth file should not be configured"
  description = "This check ensures that the container in the Pod does not have token auth file configured."
  query       = query.pod_container_token_auth_file_not_configured

  tags = local.pod_common_tags
}

control "pod_container_kubelet_certificate_authority_configured" {
  title       = "Pod containers should have kubelet certificate authority configured appropriately"
  description = "This check ensures that the container in the Pod has kubelet certificate authority configured appropriately."
  query       = query.pod_container_kubelet_certificate_authority_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_node_restriction_enabled" {
  title       = "Pod containers argument admission control plugin NodeRestriction should be enabled"
  description = "This check ensures that the container in the Pod has argument admission control plugin NodeRestriction enabled."
  query       = query.pod_container_argument_node_restriction_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_pod_security_policy_enabled" {
  title       = "Pod containers argument admission control plugin PodSecurityPolicy should be enabled"
  description = "This check ensures that the container in the Pod has argument admission control plugin PodSecurityPolicy enabled."
  query       = query.pod_container_argument_pod_security_policy_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_security_context_deny_enabled" {
  title       = "Pod containers argument admission control plugin where either PodSecurityPolicy or SecurityContextDeny should be enabled"
  description = "This check ensures that the container in the Pod has argument admission control plugin where either PodSecurityPolicy or SecurityContextDeny is enabled."
  query       = query.pod_container_argument_security_context_deny_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_kube_apiserver_profiling_disabled" {
  title       = "Pod containers kube-apiserver profiling should be disabled"
  description = "This check ensures that the container in the Pod has kube-apiserver profiling disabled."
  query       = query.pod_container_argument_kube_apiserver_profiling_disabled

  tags = local.pod_common_tags
}

control "pod_container_argument_secure_port_not_0" {
  title       = "Pod containers argument secure port should not be set to 0"
  description = "This check ensures that the container in the Pod has secure port not set to 0."
  query       = query.pod_container_argument_secure_port_not_0

  tags = local.pod_common_tags
}

control "pod_container_argument_service_account_key_file_appropriate" {
  title       = "Pod containers --service-account-key-file argument should be set as appropriate"
  description = "This check ensures that the container in the Pod has the --service-account-key-file argument set as appropriate."
  query       = query.pod_container_argument_service_account_key_file_appropriate

  tags = local.pod_common_tags
}

control "pod_container_kubernetes_dashboard_not_deployed" {
  title       = "Pod containers Kubernetes dashboard should not be deployed"
  description = "This check ensures that the container in the Pod does not have Kubernetes dashboard deployed."
  query       = query.pod_container_kubernetes_dashboard_not_deployed

  tags = local.pod_common_tags
}

control "pod_container_streaming_connection_idle_timeout_not_zero" {
  title       = "Pod containers argument --streaming-connection-idle-timeout should not be set to 0"
  description = "This check ensures that the container in the Pod has --streaming-connection-idle-timeout not set to 0."
  query       = query.pod_container_streaming_connection_idle_timeout_not_zero

  tags = local.pod_common_tags
}

control "pod_container_strong_kubelet_cryptographic_ciphers" {
  title       = "Pod containers kubelet should only make use of strong cryptographic ciphers"
  description = "This check ensures that the container in the Pod has kubelet using strong cryptographic ciphers."
  query       = query.pod_container_strong_kubelet_cryptographic_ciphers

  tags = local.pod_common_tags
}

control "pod_container_argument_rotate_kubelet_server_certificate_enabled" {
  title       = "Pod containers argument rotate kubelet server certificate should be enabled"
  description = "This check ensures that the container in the Pod has argument rotate kubelet server certificate enabled."
  query       = query.pod_container_argument_rotate_kubelet_server_certificate_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_etcd_certfile_and_keyfile_configured" {
  title       = "Pod containers should have etcd certfile and keyfile configured appropriately"
  description = "This check ensures that the container in the Pod has etcd certfile and keyfile configured appropriately."
  query       = query.pod_container_argument_etcd_certfile_and_keyfile_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_etcd_peer_certfile_and_peer_keyfile_configured" {
  title       = "Pod containers should have etcd peer certfile and peer keyfile configured appropriately"
  description = "This check ensures that the container in the Pod has etcd peer certfile and peer keyfile configured appropriately."
  query       = query.pod_container_argument_etcd_peer_certfile_and_peer_keyfile_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_kube_controller_manager_bind_address_127_0_0_1" {
  title       = "Pod containers argument kube-controller-manager bind address should be set to 127.0.0.1"
  description = "This check ensures that the container in the Pod has argument kube-controller-manager bind address set to 127.0.0.1."
  query       = query.pod_container_argument_kube_controller_manager_bind_address_127_0_0_1

  tags = local.pod_common_tags
}

control "pod_container_argument_service_account_enabled" {
  title       = "Pod containers argument admission control plugin ServiceAccount should be enabled"
  description = "This check ensures that the container in the Pod has argument admission control plugin where ServiceAccount is enabled."
  query       = query.pod_container_argument_service_account_enabled

  tags = local.pod_common_tags
}

control "pod_container_argument_kubelet_terminated_pod_gc_threshold_configured" {
  title       = "Pod containers should have kubelet terminated pod gc threshold configured appropriately"
  description = "This check ensures that the container in the Pod has kubelet terminated pod gc threshold configured appropriately."
  query       = query.pod_container_argument_kubelet_terminated_pod_gc_threshold_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_kubelet_client_ca_file_configured" {
  title       = "Pod containers should have kubelet client CA file configured appropriately"
  description = "This check ensures that the container in the Pod has kubelet client CA file configured appropriately."
  query       = query.pod_container_argument_kubelet_client_ca_file_configured

  tags = local.pod_common_tags
}

control "pod_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured" {
  title       = "Pod containers should have kube-apiserver TLS cert file and TLS private key file configured appropriately"
  description = "This check ensures that the container in the Pod has kube-apiserver TLS cert file and TLS private key file configured appropriately."
  query       = query.pod_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured

  tags = local.pod_common_tags
}

control "pod_container_strong_kube_apiserver_cryptographic_ciphers" {
  title       = "Pod containers kube-apiserver should only make use of strong cryptographic ciphers"
  description = "This check ensures that the container in the Pod has kube-apiserver using strong cryptographic ciphers."
  query       = query.pod_container_strong_kube_apiserver_cryptographic_ciphers

  tags = local.pod_common_tags
}

control "pod_container_host_port_not_specified" {
  title       = "Pod containers ports should not have host port specified"
  description = "This check ensures that the container ports in the Pod do not have host port specified."
  query       = query.pod_container_host_port_not_specified

  tags = local.pod_common_tags
}

control "pod_service_account_token_enabled" {
  title       = "Pods service account token shoulde be enabled"
  description = "This check ensures that Pod service account token is enabled."
  query       = query.pod_service_account_token_enabled

  tags = local.pod_common_tags
}

control "pod_container_run_as_user_10000" {
  title       = "Pods containers run as user should be set to 10000 or greater"
  description = "This check ensures that Pod container has run as user set to 10000 or greater than 10000."
  query       = query.pod_container_run_as_user_10000

  tags = local.pod_common_tags
}

control "pod_container_argument_request_timeout_appropriate" {
  title       = "Pod containers argument request timeout should be set as appropriate"
  description = "This check ensures that the container in the Pod has argument request timeout set as appropriate."
  query       = query.pod_container_argument_request_timeout_appropriate

  tags = local.pod_common_tags
}

control "pod_container_secrets_defined_as_files" {
  title       = "Pod containers secrets should be defined as files"
  description = "This check ensures that the container in the Pod has secrets defined as files."
  query       = query.pod_container_secrets_defined_as_files

  tags = local.pod_common_tags
}