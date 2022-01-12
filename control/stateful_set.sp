locals {
  stateful_set_common_tags = {
    plugin = "kubernetes"
  }
}

control "stateful_set_cpu_limit" {
  title       = replace(local.container_cpu_limit_title, "__KIND__", "StatefulSet")
  description = replace(local.container_cpu_limit_desc, "__KIND__", "StatefulSet")
  sql         = query.stateful_set_cpu_limit.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "stateful_set_cpu_request" {
  title       = replace(local.container_cpu_request_title, "__KIND__", "StatefulSet")
  description = replace(local.container_cpu_request_desc, "__KIND__", "StatefulSet")
  sql         = query.stateful_set_cpu_request.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "stateful_set_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "StatefulSet")
  description = replace(local.container_memory_limit_desc, "__KIND__", "StatefulSet")
  sql         = query.stateful_set_memory_limit.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "stateful_set_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "StatefulSet")
  description = replace(local.container_memory_request_desc, "__KIND__", "StatefulSet")
  sql         = query.stateful_set_memory_request.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "stateful_set_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "StatefulSet")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "StatefulSet")
  sql         = query.stateful_set_container_privilege_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "stateful_set_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "StatefulSet")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "StatefulSet")
  sql         = query.stateful_set_container_privilege_escalation_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "stateful_set_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "StatefulSet")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "StatefulSet")
  sql         = query.stateful_set_host_network_access_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "stateful_set_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "StatefulSet")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "StatefulSet")
  sql         = query.stateful_set_hostpid_hostipc_sharing_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "stateful_set_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "StatefulSet")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "StatefulSet")
  sql         = query.stateful_set_immutable_container_filesystem.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "stateful_set_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "StatefulSet")
  description = replace(local.non_root_container_desc, "__KIND__", "StatefulSet")
  sql         = query.stateful_set_non_root_container.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "stateful_set_container_readiness_probe" {
  title       = "StatefulSet containers should have readiness probe"
  description = "Containers in StatefulSet definition should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill it’s work."
  sql         = query.stateful_set_container_readiness_probe.sql
  tags        = local.extra_checks_tags
}

control "stateful_set_container_liveness_probe" {
  title       = "StatefulSet containers should have liveness probe"
  description = "Containers in StatefulSet definition should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  sql         = query.stateful_set_container_liveness_probe.sql
  tags        = local.extra_checks_tags
}

control "stateful_set_container_privilege_port_mapped" {
  title       = "StatefulSet containers should not be mapped with privilege ports"
  description = "Privileged ports `0 to 1024` should not be mapped with StatefulSet containers. Normal users and processes are not allowed to use them for various security reasons."
  sql         = query.stateful_set_container_privilege_port_mapped.sql
  tags        = local.extra_checks_tags
}

control "stateful_set_default_namesapce_used" {
  title       = "StatefulSet definition should not use default namespace"
  description = "Default namespace should not be used by StatefulSet definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.stateful_set_default_namesapce_used.sql
  tags = merge(local.stateful_set_common_tags, {
   cis = "true"
  })
}