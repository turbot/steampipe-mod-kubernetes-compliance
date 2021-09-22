control "pod_volume_host_path" {
  title       = replace(local.title_container_disallow_host_path, "__KIND__", "Pod")
  description = replace(local.desc_container_disallow_host_path, "__KIND__", "Pod")
  sql         = query.pod_volume_host_path.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_container_privilege_disabled" {
  title       = replace(local.desc_container_privilege_disabled, "__KIND__", "Pod")
  description = replace(local.desc_container_privilege_disabled, "__KIND__", "Pod")
  sql         = query.pod_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_container_privilege_escalation_disabled" {
  title       = replace(local.title_container_privilege_escalation_disabled, "__KIND__", "Pod")
  description = replace(local.desc_container_privilege_escalation_disabled, "__KIND__", "Pod")
  sql         = query.pod_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_host_network_access_disabled" {
  title       = replace(local.title_host_network_access_disabled, "__KIND__", "Pod")
  description = replace(local.desc_host_network_access_disabled, "__KIND__", "Pod")
  sql         = query.pod_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.title_hostpid_hostipc_sharing_disabled, "__KIND__", "Pod")
  description = replace(local.desc_hostpid_hostipc_sharing_disabled, "__KIND__", "Pod")
  sql         = query.pod_hostpid_hostipc_sharing_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_immutable_container_filesystem" {
  title       = replace(local.desc_immutable_container_filesystem, "__KIND__", "Pod")
  description = replace(local.desc_immutable_container_filesystem, "__KIND__", "Pod")
  sql         = query.pod_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_non_root_container" {
  title       = replace(local.title_non_root_container, "__KIND__", "Pod")
  description = replace(local.desc_non_root_container, "__KIND__", "Pod")
  sql         = query.pod_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "pod_service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled in Pod"
  description = local.desc_service_account_token_disabled
  sql         = query.pod_service_account_token_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}
