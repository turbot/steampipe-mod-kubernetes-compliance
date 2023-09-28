locals {
  pod_template_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/PodTemplate"
  })
}

control "pod_template_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "PodTemplate")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "PodTemplate")
  query       = query.pod_template_container_privilege_escalation_disabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_with_added_capabilities" {
  title       = "PodTemplate containers should not have added capabilities"
  description = "Container in PodTemplate definition should not have added capabilities. Added capabilities can provide container processes with escalated privileges which can be used to access sensitive host resources or perform operations outside of the container."
  query       = query.pod_template_container_with_added_capabilities

  tags = local.pod_template_common_tags
}

control "pod_template_container_sys_admin_capability_disabled" {
  title       = "PodTemplate containers should not use CAP_SYS_ADMIN linux capability"
  description = "This check ensures that the container in the PodTemplate does not use CAP_SYS_ADMIN Linux capability."
  query       = query.pod_template_container_sys_admin_capability_disabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_admission_control_plugin_no_always_admit" {
  title       = "PodTemplate containers admission control plugin should not be set to 'always admit'"
  description = "This check ensures that the container in the PodTemplate has an admission control plugin not set to 'always admit'."
  query       = query.pod_template_container_admission_control_plugin_no_always_admit

  tags = local.pod_template_common_tags
}

control "pod_template_container_admission_control_plugin_always_pull_images" {
  title       = "PodTemplate containers admission control plugin should be set to 'always pull images'"
  description = "This check ensures that the container in the PodTemplate has 'always pull images' configured for the admission control plugin."
  query       = query.pod_template_container_admission_control_plugin_always_pull_images

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_api_server_anonymous_auth_disabled" {
  title       = "PodTemplate containers argument anonymous auth should be disabled"
  description = "This check ensures that the container in the PodTemplate has anonymous auth disabled."
  query       = query.pod_template_container_argument_api_server_anonymous_auth_disabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_audit_log_path_configured" {
  title       = "PodTemplate containers should have audit log path configured appropriately"
  description = "This check ensures that the container in the PodTemplate has audit log path configured appropriately."
  query       = query.pod_template_container_argument_audit_log_path_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_audit_log_maxage_greater_than_30" {
  title       = "PodTemplate containers should have audit log max-age set to 30 or greater"
  description = "This check ensures that the container in the PodTemplate has audit log max-age set to 30 or greater."
  query       = query.pod_template_container_argument_audit_log_maxage_greater_than_30

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_audit_log_maxbackup_greater_than_10" {
  title       = "PodTemplate containers should have audit log max backup set to 10 or greater"
  description = "This check ensures that the container in the PodTemplate has audit log max backup set to 10 or greater."
  query       = query.pod_template_container_argument_audit_log_maxbackup_greater_than_10

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_audit_log_maxsize_greater_than_100" {
  title       = "PodTemplate containers should have audit log max size set to 100 or greater"
  description = "This check ensures that the container in the PodTemplate has audit log max size set to 100 or greater."
  query       = query.pod_template_container_argument_audit_log_maxsize_greater_than_100

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_authorization_mode_node" {
  title       = "PodTemplate containers argument authorization mode should have node"
  description = "This check ensures that the container in the PodTemplate has node included in the argument authorization mode."
  query       = query.pod_template_container_argument_authorization_mode_node

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_authorization_mode_no_always_allow" {
  title       = "PodTemplate containers argument authorization mode should not be set to 'always allow'"
  description = "This check ensures that the container in the PodTemplate has argument authorization mode not set to 'always allow'."
  query       = query.pod_template_container_argument_authorization_mode_no_always_allow

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_authorization_mode_rbac" {
  title       = "PodTemplate containers argument authorization mode should have RBAC"
  description = "This check ensures that the container in the PodTemplate has RBAC included in the argument authorization mode."
  query       = query.pod_template_container_argument_authorization_mode_rbac

  tags = local.pod_template_common_tags
}

control "pod_template_container_no_argument_basic_auth_file" {
  title       = "PodTemplate containers argument basic auth file should not be set"
  description = "This check ensures that the PodTemplate container does not have an argument basic auth file set."
  query       = query.pod_template_container_no_argument_basic_auth_file

  tags = local.pod_template_common_tags
}

control "pod_template_container_encryption_providers_configured" {
  title       = "PodTemplate containers should has encryption providers configured appropriately"
  description = "This check ensures that the container in the PodTemplate has encryption providers configured appropriately."
  query       = query.pod_template_container_encryption_providers_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_etcd_cafile_configured" {
  title       = "PodTemplate containers argument etcd cafile should be set"
  description = "This check ensures that the container in the PodTemplate has argument etcd cafile set."
  query       = query.pod_template_container_argument_etcd_cafile_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_api_server_etcd_certfile_and_keyfile_configured" {
  title       = "PodTemplate containers argument etcd certfile and keyfile should be configured"
  description = "This check ensures that the container in the PodTemplate has etcd certfile and keyfile argument configured."
  query       = query.pod_template_container_argument_api_server_etcd_certfile_and_keyfile_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_no_argument_insecure_bind_address" {
  title       = "PodTemplate containers argument insecure bind address should not be set"
  description = "This check ensures that the PodTemplate container does not have an argument insecure bind address set."
  query       = query.pod_template_container_no_argument_insecure_bind_address

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_insecure_port_0" {
  title       = "PodTemplate containers argument insecure port should be set to 0"
  description = "This check ensures that the container in the PodTemplate has insecure port set to 0."
  query       = query.pod_template_container_argument_insecure_port_0

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kubelet_client_certificate_and_key_configured" {
  title       = "PodTemplate containers argument kubelet client certificate and key should be configured"
  description = "This check ensures that the container in the PodTemplate has kubelet client certificate and key argument configured."
  query       = query.pod_template_container_argument_kubelet_client_certificate_and_key_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kubelet_https_enabled" {
  title       = "PodTemplate containers argument kubelet HTTPS should be enabled"
  description = "This check ensures that the container in the PodTemplate has kubelet HTTPS argument enabled."
  query       = query.pod_template_container_argument_kubelet_https_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_cpu_limit" {
  title       = replace(local.container_cpu_limit_title, "__KIND__", "PodTemplate")
  description = replace(local.container_cpu_limit_desc, "__KIND__", "PodTemplate")
  query       = query.pod_template_cpu_limit

  tags = local.pod_template_common_tags
}

control "pod_template_cpu_request" {
  title       = replace(local.container_cpu_request_title, "__KIND__", "PodTemplate")
  description = replace(local.container_cpu_request_desc, "__KIND__", "PodTemplate")
  query       = query.pod_template_cpu_request

  tags = local.pod_template_common_tags
}

control "pod_template_container_security_context_exists" {
  title       = "PodTemplate containers should has security context defined"
  description = "This check ensures that the container in a PodTemplate definition has security context defined."
  query       = query.pod_template_container_security_context_exists

  tags = local.pod_template_common_tags
}

control "pod_template_container_admission_capability_restricted" {
  title       = "PodTemplate containers should has admission capability restricted"
  description = "This check ensures that the container in the PodTemplate has admission capability restricted."
  query       = query.pod_template_container_admission_capability_restricted

  tags = local.pod_template_common_tags
}

control "pod_template_container_image_pull_policy_always" {
  title       = "PodTemplate containers should has image pull policy set to Always"
  description = "This check ensures that the container in the PodTemplate has image pull policy set to Always."
  query       = query.pod_template_container_image_pull_policy_always

  tags = local.pod_template_common_tags
}

control "pod_template_container_image_tag_specified" {
  title       = "PodTemplate containers have image tag specified which should be fixed not latest or blank"
  description = "This check ensures that the container in the PodTemplate has image tag fixed not latest or blank."
  query       = query.pod_template_container_image_tag_specified

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kubelet_anonymous_auth_disabled" {
  title       = "PodTemplate containers argument anonymous auth should be disabled"
  description = "This check ensures that the container in the PodTemplate has anonymous auth disabled."
  query       = query.pod_template_container_argument_kubelet_anonymous_auth_disabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_event_qps_less_than_5" {
  title       = "PodTemplate containers argument event qps should be less than 5"
  description = "This check ensures that the container in the PodTemplate has argument event qps set to less than 5."
  query       = query.pod_template_container_argument_event_qps_less_than_5

  tags = local.pod_template_common_tags
}

control "pod_template_container_rotate_certificate_enabled" {
  title       = "PodTemplate containers certificate rotation should be enabled"
  description = "This check ensures that the container in the PodTemplate has certificate rotation enabled."
  query       = query.pod_template_container_rotate_certificate_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_liveness_probe" {
  title       = "PodTemplate containers should have liveness probe"
  description = "Containers in PodTemplate definition should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn't the case, kubernetes will eventually restart the container."
  query       = query.pod_template_container_liveness_probe

  tags = local.pod_template_common_tags
}

control "pod_template_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "PodTemplate")
  description = replace(local.container_memory_limit_desc, "__KIND__", "PodTemplate")
  query       = query.pod_template_memory_limit

  tags = local.pod_template_common_tags
}

control "pod_template_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "PodTemplate")
  description = replace(local.container_memory_request_desc, "__KIND__", "PodTemplate")
  query       = query.pod_template_memory_request

  tags = local.pod_template_common_tags
}

control "pod_template_container_capabilities_drop_all" {
  title       = "PodTemplate containers should minimize its admission with capabilities assigned"
  description = "This check ensures that the container in the PodTemplate minimizes its admission with capabilities assigned."
  query       = query.pod_template_container_capabilities_drop_all

  tags = local.pod_template_common_tags
}

control "pod_template_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "PodTemplate")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "PodTemplate")
  query       = query.pod_template_container_privilege_disabled

  tags = local.pod_template_common_tags
}

control "pod_template_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "PodTemplate")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "PodTemplate")
  query       = query.pod_template_immutable_container_filesystem

  tags = local.pod_template_common_tags
}

control "pod_template_container_readiness_probe" {
  title       = "PodTemplate containers should have readiness probe"
  description = "Containers in PodTemplate definition should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill its work."
  query       = query.pod_template_container_readiness_probe

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_namespace_lifecycle_enabled" {
  title       = "PodTemplate containers argument admission control plugin NamespaceLifecycle is enabled"
  description = "This check ensures that the container in the PodTemplate has argument admission control plugin NamespaceLifecycle disabled."
  query       = query.pod_template_container_argument_namespace_lifecycle_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_node_restriction_enabled" {
  title       = "PodTemplate containers argument admission control plugin NodeRestriction is enabled"
  description = "This check ensures that the container in the PodTemplate has argument admission control plugin NodeRestriction disabled."
  query       = query.pod_template_container_argument_node_restriction_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_service_account_lookup_enabled" {
  title       = "PodTemplate containers argument service account lookup should be enabled"
  description = "This check ensures that the container in the PodTemplate has argument service account lookup enabled."
  query       = query.pod_template_container_argument_service_account_lookup_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_token_auth_file_not_configured" {
  title       = "PodTemplate containers token auth file should not be configured"
  description = "This check ensures that the container in the PodTemplate does not have token auth file configured."
  query       = query.pod_template_container_token_auth_file_not_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_kubelet_certificate_authority_configured" {
  title       = "PodTemplate containers should have kubelet certificate authority configured appropriately"
  description = "This check ensures that the container in the PodTemplate has kubelet certificate authority configured appropriately."
  query       = query.pod_template_container_kubelet_certificate_authority_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_etcd_auto_tls_disabled" {
  title       = "PodTemplate containers argument etcd auto TLS should be disabled"
  description = "This check ensures that the container in the PodTemplate has argument etcd auto TLS disabled."
  query       = query.pod_template_container_argument_etcd_auto_tls_disabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_etcd_client_cert_auth_enabled" {
  title       = "Podtemplate containers argument etcd client cert auth should be enabled"
  description = "This check ensures that the container in the Podtemplate has argument etcd client cert auth enabled."
  query       = query.pod_template_container_argument_etcd_client_cert_auth_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kube_controller_manager_profiling_disabled" {
  title       = "PodTemplate containers kube controller manager profiling should be disabled"
  description = "This check ensures that the container in the PodTemplate has kube controller manager profiling disabled."
  query       = query.pod_template_container_argument_kube_controller_manager_profiling_disabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kube_controller_manager_root_ca_file_configured" {
  title       = "PodTemplate containers should have kube controller manager root ca file configured appropriately"
  description = "This check ensures that the container in the PodTemplate has kube controller manager root ca file configured appropriately."
  query       = query.pod_template_container_argument_kube_controller_manager_root_ca_file_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kube_controller_manager_service_account_credentials_enabled" {
  title       = "PodTemplate containers argument kube controller manager service account credentials should be enabled"
  description = "This check ensures that the container in the PodTemplate has argument kube controller manager service account credentials enabled."
  query       = query.pod_template_container_argument_kube_controller_manager_service_account_credentials_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kube_controller_manager_service_account_private_key_file_configured" {
  title       = "PodTemplate containers should have kube controller manager service account private key file configured appropriately"
  description = "This check ensures that the container in the PodTemplate has kube controller manager service account private key file configured appropriately."
  query       = query.pod_template_container_argument_kube_controller_manager_service_account_private_key_file_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kubelet_authorization_mode_no_always_allow" {
  title       = "PodTemplate containers argument kubelet authorization mode should not be set to 'always allow'"
  description = "This check ensures that the container in the PodTemplate has argument kubelet authorization mode not set to 'always allow'."
  query       = query.pod_template_container_argument_kubelet_authorization_mode_no_always_allow

  tags = local.pod_template_common_tags
}

control "pod_template_container_no_argument_hostname_override_configured" {
  title       = "PodTemplate containers argument hostname override should not be configured"
  description = "This check ensures that the container in the PodTemplate has argument hostname override not configured."
  query       = query.pod_template_container_no_argument_hostname_override_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_tls_cert_file_and_tls_private_key_file_configured" {
  title       = "PodTemplate containers should have TLS cert file and TLS private key file configured appropriately"
  description = "This check ensures that the container in the PodTemplate has TLS cert file and TLS private key file configured appropriately."
  query       = query.pod_template_container_argument_tls_cert_file_and_tls_private_key_file_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_make_iptables_util_chains_enabled" {
  title       = "PodTemplate containers argument make iptables util chains should be enabled"
  description = "This check ensures that the container in the PodTemplate has argument make iptables util chains enabled."
  query       = query.pod_template_container_argument_make_iptables_util_chains_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_protect_kernel_defaults_enabled" {
  title       = "PodTemplate containers argument protect kernel defaults should be enabled"
  description = "This check ensures that the container in the PodTemplate has argument protect kernel defaults enabled."
  query       = query.pod_template_container_argument_protect_kernel_defaults_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kubelet_read_only_port_0" {
  title       = "PodTemplate containers argument kubelet read only port shoule be set 0"
  description = "This check ensures that the container in the PodTemplate has argument kubelet read only port set to 0."
  query       = query.pod_template_container_argument_kubelet_read_only_port_0

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_bind_address_127_0_0_1" {
  title       = "PodTemplate containers argument bind address should be set to 127.0.0.1"
  description = "This check ensures that the container in the PodTemplate has argument bind address set to 127.0.0.1."
  query       = query.pod_template_container_argument_bind_address_127_0_0_1

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kube_scheduler_profiling_disabled" {
  title       = "PodTemplate containers kube scheduler profiling should be disabled"
  description = "This check ensures that the container in the PodTemplate has kube scheduler profiling disabled."
  query       = query.pod_template_container_argument_kube_scheduler_profiling_disabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_pod_security_policy_enabled" {
  title       = "PodTemplate containers argument admission control plugin PodSecurityPolicy is enabled"
  description = "This check ensures that the container in the PodTemplate has argument admission control plugin where PodSecurityPolicy is enabled."
  query       = query.pod_template_container_argument_pod_security_policy_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kube_apiserver_profiling_disabled" {
  title       = "PodTemplate containers kube apiserver profiling should be disabled"
  description = "This check ensures that the container in the PodTemplate has kube apiserver profiling disabled."
  query       = query.pod_template_container_argument_kube_apiserver_profiling_disabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_secure_port_not_0" {
  title       = "PodTemplate containers argument secure port should not be set to 0"
  description = "This check ensures that the container in the PodTemplate has secure port not set to 0."
  query       = query.pod_template_container_argument_secure_port_not_0

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_security_context_deny_enabled" {
  title       = "PodTemplate containers argument admission control plugin where either PodSecurityPolicy or SecurityContextDeny is enabled"
  description = "This check ensures that the container in the PodTemplate has argument admission control plugin where either PodSecurityPolicy or SecurityContextDeny is enabled."
  query       = query.pod_template_container_argument_security_context_deny_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_service_account_key_file_appropriate" {
  title       = "PodTemplate containers --service-account-key-file argument should be set as appropriate"
  description = "This check ensures that the container in the PodTemplate has the --service-account-key-file argument set as appropriate."
  query       = query.pod_template_container_argument_service_account_key_file_appropriate

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_service_account_enabled" {
  title       = "PodTemplate containers argument admission control plugin where ServiceAccount is enabled"
  description = "This check ensures that the container in the PodTemplate has argument admission control plugin where ServiceAccount is enabled."
  query       = query.pod_template_container_argument_service_account_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_kube_controller_manager_bind_address_127_0_0_1" {
  title       = "PodTemplate containers argument kube-controller-manager bind address should be set to 127.0.0.1"
  description = "This check ensures that the container in the PodTemplate has argument kube-controller-manager bind address set to 127.0.0.1."
  query       = query.pod_template_container_argument_kube_controller_manager_bind_address_127_0_0_1

  tags = local.pod_template_common_tags
}

control "pod_template_container_kubelet_streaming_connection_idle_timeout_not_zero" {
  title       = "PodTemplate containers argument --streaming-connection-idle-timeout should not be set to 0"
  description = "This check ensures that the container in the PodTemplate has --streaming-connection-idle-timeout not set to 0."
  query       = query.pod_template_container_kubelet_streaming_connection_idle_timeout_not_zero

  tags = local.pod_template_common_tags
}

control "pod_template_container_kubernetes_dashboard_not_deployed" {
  title       = "PodTemplate containers Kubernetes dashboard should not be deployed"
  description = "This check ensures that the container in the PodTemplate does not have Kubernetes dashboard deployed."
  query       = query.pod_template_container_kubernetes_dashboard_not_deployed

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_etcd_peer_certfile_and_peer_keyfile_configured" {
  title       = "PodTemplate containers should have etcd peer certfile and peer keyfile configured appropriately"
  description = "This check ensures that the container in the PodTemplate has etcd peer certfile and peer keyfile configured appropriately."
  query       = query.pod_template_container_argument_etcd_peer_certfile_and_peer_keyfile_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_etcd_certfile_and_keyfile_configured" {
  title       = "PodTemplate containers should have etcd certfile and keyfile configured appropriately"
  description = "This check ensures that the container in the PodTemplate has etcd certfile and keyfile configured appropriately."
  query       = query.pod_template_container_argument_etcd_certfile_and_keyfile_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_api_server_tls_cert_file_and_tls_private_key_file_configured" {
  title       = "PodTemplate containers should have TLS cert file and TLS private key file configured appropriately"
  description = "This check ensures that the container in the PodTemplate has TLS cert file and TLS private key file configured appropriately."
  query       = query.pod_template_container_argument_api_server_tls_cert_file_and_tls_private_key_file_configured

  tags = local.pod_template_common_tags
}

control "pod_template_container_argument_rotate_kubelet_server_certificate_enabled" {
  title       = "PodTemplate containers argument rotate kubelet server certificate should be enabled"
  description = "This check ensures that the container in the PodTemplate has argument rotate kubelet server certificate enabled."
  query       = query.pod_template_container_argument_rotate_kubelet_server_certificate_enabled

  tags = local.pod_template_common_tags
}

control "pod_template_container_strong_kubelet_cryptographic_ciphers" {
  title       = "PodTemplate containers kubelet should only make use of strong cryptographic ciphers"
  description = "This check ensures that the container in the PodTemplate has kublet using strong cryptographic ciphers."
  query       = query.pod_template_container_strong_kubelet_cryptographic_ciphers

  tags = local.pod_template_common_tags
}

control "pod_template_container_strong_kube_apiserver_cryptographic_ciphers" {
  title       = "PodTemplate containers kube-apiserver should only make use of strong cryptographic ciphers"
  description = "This check ensures that the container in the PodTemplate has kube-apiserver using strong cryptographic ciphers."
  query       = query.pod_template_container_strong_kube_apiserver_cryptographic_ciphers

  tags = local.pod_template_common_tags
}
