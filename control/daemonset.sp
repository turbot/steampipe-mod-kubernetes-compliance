control "daemonset_cpu_limit" {
  title       = replace(local.container_cpu_limit_title, "__KIND__", "DaemonSet")
  description = replace(local.container_cpu_limit_desc, "__KIND__", "DaemonSet")
  sql         = query.daemonset_cpu_limit.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "daemonset_cpu_request" {
  title       = replace(local.container_cpu_request_title, "__KIND__", "DaemonSet")
  description = replace(local.container_cpu_request_desc, "__KIND__", "DaemonSet")
  sql         = query.daemonset_cpu_request.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "daemonset_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "DaemonSet")
  description = replace(local.container_memory_limit_desc, "__KIND__", "DaemonSet")
  sql         = query.daemonset_memory_limit.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "daemonset_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "DaemonSet")
  description = replace(local.container_memory_request_desc, "__KIND__", "DaemonSet")
  sql         = query.daemonset_memory_request.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "daemonset_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "DaemonSet")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "DaemonSet")
  sql         = query.daemonset_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "daemonset_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "DaemonSet")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "DaemonSet")
  sql         = query.daemonset_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "daemonset_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "DaemonSet")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "DaemonSet")
  sql         = query.daemonset_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "daemonset_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "DaemonSet")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "DaemonSet")
  sql         = query.daemonset_hostpid_hostipc_sharing_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "daemonset_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "DaemonSet")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "DaemonSet")
  sql         = query.daemonset_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "daemonset_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "DaemonSet")
  description = replace(local.non_root_container_desc, "__KIND__", "DaemonSet")
  sql         = query.daemonset_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "daemonset_container_readiness_probe" {
  title       = "Daemonset containers should have readiness probe."
  description = "Daemonset containers should have readiness probe."
  sql         = query.daemonset_container_readiness_probe.sql
  tags        = local.extra_checks_tags
}

control "daemonset_container_liveness_probe" {
  title       = "Daemonset containers should have liveness probe."
  description = "Daemonset containers should have liveness probe."
  sql         = query.daemonset_container_liveness_probe.sql
  tags        = local.extra_checks_tags
}