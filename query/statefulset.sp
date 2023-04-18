query "statefulset_default_seccomp_profile_enabled" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'securityContext' -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then name || ' seccompProfile enabled.'
        else name || ' seccompProfile disabled.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "statefulset_non_root_container" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'securityContext' ->> 'runAsNonRoot' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' ->> 'runAsNonRoot' = 'true' then c ->> 'name' || ' not running with root privilege.'
        else c ->> 'name' || ' running with root privilege.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "statefulset_memory_limit" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'resources' -> 'limits' ->> 'memory' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'resources' -> 'limits' ->> 'memory' is null then c ->> 'name' || ' does not have a memory limit.'
        else c ->> 'name' || ' has a memory limit of ' || (c -> 'resources' -> 'limits' ->> 'memory') || '.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "statefulset_immutable_container_filesystem" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'securityContext' ->> 'readOnlyRootFilesystem' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' ->> 'readOnlyRootFilesystem' = 'true' then c ->> 'name' || ' running with read only root file system.'
        else c ->> 'name' || ' not running with read only root file system.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "statefulset_host_network_access_disabled" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when template -> 'spec' ->> 'hostNetwork' = 'true' then 'alarm'
        else 'ok'
      end as status,
      case
        when template -> 'spec' ->> 'hostNetwork' = 'true' then 'StatefulSet pods using host network.'
        else 'StatefulSet pods not using host network.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set;
  EOQ
}

query "statefulset_container_privilege_escalation_disabled" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then c ->> 'name' || ' not allowed root elevation.'
        else c ->> 'name' || ' allowed root elevation.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "statefulset_default_namespace_used" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when namespace = 'default' then 'alarm'
        else 'ok'
      end as status,
      case
        when namespace = 'default' then name || ' uses default namespace.'
        else name || ' not using the default namespace.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set;
  EOQ
}

query "statefulset_cpu_request" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'resources' -> 'requests' ->> 'cpu' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'resources' -> 'requests' ->> 'cpu' is null then c ->> 'name' || ' does not have a CPU request.'
        else c ->> 'name' || ' has a CPU request of ' || (c -> 'resources' -> 'requests' ->> 'cpu') || '.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}

    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "statefulset_memory_request" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'resources' -> 'requests' ->> 'memory' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'resources' -> 'requests' ->> 'memory' is null then c ->> 'name' || ' does not have a memory request.'
        else c ->> 'name' || ' has a memory request of ' || (c -> 'resources' -> 'requests' ->> 'memory') || '.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "statefulset_container_liveness_probe" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'livenessProbe' is not null then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'livenessProbe' is not null then c ->> 'name' || ' has liveness probe.'
        else c ->> 'name' || ' does not have liveness probe.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "statefulset_container_readiness_probe" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'readinessProbe' is not null then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'readinessProbe' is not null then c ->> 'name' || ' has readiness probe.'
        else c ->> 'name' || ' does not have readiness probe.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "statefulset_cpu_limit" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'resources' -> 'limits' ->> 'cpu' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'resources' -> 'limits' ->> 'cpu' is null then c ->> 'name' || ' does not have a CPU limit.'
        else c ->> 'name' || ' has a CPU limit of ' || (c -> 'resources' -> 'limits' ->> 'cpu') || '.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "statefulset_container_privilege_port_mapped" {
  sql = <<-EOQ
    select
      c ->> 'name' as resource,
      case
        when p ->> 'name' is null then 'skip'
        when cast(p ->> 'containerPort' as integer) <= 1024 then 'alarm'
        else 'ok'
      end as status,
      case
        when p ->> 'name' is null then 'No port mapped.'
        when cast(p ->> 'containerPort' as integer) <= 1024 then p ->> 'name' || ' mapped with a privileged port.'
        else p ->> 'name' || ' not mapped with a privileged port.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c,
      jsonb_array_elements(c -> 'ports') as p;
  EOQ
}

query "statefulset_hostpid_hostipc_sharing_disabled" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when template -> 'spec' ->> 'hostPID' = 'true' or template -> 'spec' ->> 'hostIPC' = 'true' then 'alarm'
        else 'ok'
      end as status,
      case
        when template -> 'spec' ->> 'hostPID' = 'true' then 'StatefulSet pods share host PID namespaces.'
        when template -> 'spec' ->> 'hostIPC' = 'true' then 'StatefulSet pods share host IPC namespaces.'
        else 'StatefulSet pods cannot share host process namespaces.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set;
  EOQ
}

query "statefulset_container_privilege_disabled" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when c -> 'securityContext' ->> 'privileged' = 'true' then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'securityContext' ->> 'privileged' = 'true' then c ->> 'name' || ' privileged container.'
        else c ->> 'name' || ' not privileged container.'
      end as reason,
      name as stateful_set_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_stateful_set,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}
