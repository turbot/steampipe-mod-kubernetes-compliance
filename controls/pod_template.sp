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

control "pod_template_container_argument_etcd_certfile_and_keyfile_configured" {
  title       = "PodTemplate containers argument etcd certfile and keyfile should be configured"
  description = "This check ensures that the container in the PodTemplate has etcd certfile and keyfile argument configured."
  query       = query.pod_template_container_argument_etcd_certfile_and_keyfile_configured

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
