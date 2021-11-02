control "pod_volume_host_path" {
  title       = replace(local.container_disallow_host_path_title, "__KIND__", "Pod")
  description = replace(local.container_disallow_host_path_desc, "__KIND__", "Pod")
  sql         = query.pod_volume_host_path.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "Pod")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "Pod")
  sql         = query.pod_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "Pod")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "Pod")
  sql         = query.pod_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "Pod")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "Pod")
  sql         = query.pod_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "Pod")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "Pod")
  sql         = query.pod_hostpid_hostipc_sharing_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "Pod")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "Pod")
  sql         = query.pod_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "Pod")
  description = replace(local.non_root_container_desc, "__KIND__", "Pod")
  sql         = query.pod_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_service_account_not_exist" {
  title       = "Pods should not refer to a non existing service account"
  description = local.pod_service_account_not_exist_desc
  sql         = query.pod_service_account_not_exist.sql
  tags        = local.extra_checks_tags
}

control "pod_service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled in Pod"
  description = local.service_account_token_disabled_desc
  sql         = query.pod_service_account_token_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}