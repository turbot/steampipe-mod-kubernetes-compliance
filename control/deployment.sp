control "deployment_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "Deployment")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "Deployment")
  sql         = query.deployment_cpu_limit.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "deployment_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "Deployment")
  description = replace(local.desc_container_cpu_request, "__KIND__", "Deployment")
  sql         = query.deployment_cpu_request.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "deployment_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "Deployment")
  description = replace(local.desc_container_memory_limit, "__KIND__", "Deployment")
  sql         = query.deployment_memory_limit.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "deployment_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "Deployment")
  description = replace(local.desc_container_memory_request, "__KIND__", "Deployment")
  sql         = query.deployment_memory_request.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "deployment_container_privilege_disabled" {
  title       = replace(local.title_container_privilege_disabled, "__KIND__", "Deployment")
  description = replace(local.desc_container_privilege_disabled, "__KIND__", "Deployment")
  sql         = query.deployment_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "deployment_container_privilege_escalation_disabled" {
  title       = replace(local.title_container_privilege_escalation_disabled, "__KIND__", "Deployment")
  description = replace(local.desc_container_privilege_escalation_disabled, "__KIND__", "Deployment")
  sql         = query.deployment_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "deployment_host_network_access_disabled" {
  title       = replace(local.title_host_network_access_disabled, "__KIND__", "Deployment")
  description = replace(local.desc_host_network_access_disabled, "__KIND__", "Deployment")
  sql         = query.deployment_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "deployment_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.title_hostpid_hostipc_sharing_disabled, "__KIND__", "Deployment")
  description = replace(local.desc_hostpid_hostipc_sharing_disabled, "__KIND__", "Deployment")
  sql         = query.deployment_hostpid_hostipc_sharing_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "deployment_immutable_container_filesystem" {
  title       = replace(local.title_immutable_container_filesystem, "__KIND__", "Deployment")
  description = replace(local.desc_immutable_container_filesystem, "__KIND__", "Deployment")
  sql         = query.deployment_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "deployment_non_root_container" {
  title       = replace(local.title_non_root_container, "__KIND__", "Deployment")
  description = replace(local.desc_non_root_container, "__KIND__", "Deployment")
  sql         = query.deployment_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}
