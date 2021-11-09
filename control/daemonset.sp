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
  title       = "DaemonSet containers should have readiness probe"
  description = "Containers in DaemonSet definition should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill it’s work."
  sql         = query.daemonset_container_readiness_probe.sql
  tags        = local.extra_checks_tags
}

control "daemonset_container_liveness_probe" {
  title       = "DaemonSet containers should have liveness probe"
  description = "Containers in DaemonSet definition should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  sql         = query.daemonset_container_liveness_probe.sql
  tags        = local.extra_checks_tags
}

control "daemonset_container_privilege_port_mapped" {
  title       = "DaemonSet containers should not mapped with privilege port"
  description = "Privileged ports `0 to 1024` should not mapped with DaemonSet containers. Normal users and processes are not allowed to use them for various security reasons."
  sql         = query.daemonset_container_privilege_port_mapped.sql
  tags        = local.extra_checks_tags
}

control "daemonset_default_namesapce_used" {
  title       = "DaemonSet definition should not use default namespace"
  description = "Default namespace should not be used by DaemonSet definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.daemonset_default_namesapce_used.sql
  tags        = local.extra_checks_tags
}
