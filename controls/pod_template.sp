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

control "pod_template_container_argument_anonymous_auth_disabled" {
  title       = "PodTemplate containers argument anonymous auth should be disabled"
  description = "This check ensures that the container in the PodTemplate has anonymous auth disabled."
  query       = query.pod_template_container_argument_anonymous_auth_disabled

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
