query "pod_container_privilege_escalation_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then c ->> 'name' || ' can not request to allow privilege escalation.'
        else c ->> 'name' || ' can request to allow privilege escalation.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod,
      jsonb_array_elements(containers) as c;
  EOQ
}

query "pod_container_privilege_port_mapped" {
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
        when cast(p ->> 'containerPort' as integer) <= 1024 then p ->> 'name'|| ' mapped with a privileged port.'
        else p ->> 'name' || ' not mapped with a privileged port.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod,
      jsonb_array_elements(containers) as c,
      jsonb_array_elements(c -> 'ports') as p;
  EOQ
}

query "pod_container_readiness_probe" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'readinessProbe' is not null then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'readinessProbe' is not null then c ->> 'name' || ' has readiness probe.'
        else c ->> 'name' || ' does not have readiness probe.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod,
      jsonb_array_elements(containers) as c;
  EOQ
}

query "pod_immutable_container_filesystem" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'securityContext' ->> 'readOnlyRootFilesystem' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' ->> 'readOnlyRootFilesystem' = 'true' then c ->> 'name' || ' running with read only root file system.'
        else c ->> 'name' || ' not running with read only root file system.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod,
      jsonb_array_elements(containers) as c;
  EOQ
}

query "pod_non_root_container" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'securityContext' ->> 'runAsNonRoot' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' ->> 'runAsNonRoot' = 'true' then c ->> 'name' || ' not running with root privilege.'
        else c ->> 'name' || ' running with root privilege.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod,
      jsonb_array_elements(containers) as c;
  EOQ
}

query "pod_container_privilege_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'securityContext' ->> 'privileged' = 'true' then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'securityContext' ->> 'privileged' = 'true' then c ->> 'name' || ' running with privilege access.'
        else c ->> 'name' || ' not running with privilege access.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod,
      jsonb_array_elements(containers) as c;
  EOQ
}

query "pod_container_liveness_probe" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'livenessProbe' is not null then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'livenessProbe' is not null then c ->> 'name' || ' has liveness probe.'
        else c ->> 'name' || ' does not have liveness probe.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod,
      jsonb_array_elements(containers) as c;
  EOQ
}

query "pod_hostpid_hostipc_sharing_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when host_pid or host_ipc then 'alarm'
        else 'ok'
      end as status,
      case
        when host_pid then name || ' can share host PID namespaces.'
        when host_ipc then name || ' can share host IPC namespaces.'
        else name || ' cannot share host process namespaces.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod;
  EOQ
}

query "pod_default_namespace_used" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when namespace = 'default' then 'alarm'
        else 'ok'
      end as status,
      case
        when namespace = 'default' then name || ' uses default namespace.'
        else name || ' not using the default namespace.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod;
  EOQ
}

query "pod_service_account_token_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when automount_service_account_token then 'alarm'
        else 'ok'
      end as status,
      case
        when automount_service_account_token then name || ' service account token will be automatically mounted.'
        else name || ' service account token will not be automatically mounted.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod;
  EOQ
}

query "pod_hostpid_sharing_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when host_pid then 'alarm'
        else 'ok'
      end as status,
      case
        when host_pid then name || ' can share host PID namespaces.'
        else name || ' cannot share host PID namespaces.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod;
  EOQ
}

query "pod_volume_host_path" {
  sql = <<-EOQ
    select
      distinct(name) as resource,
      case
        when v -> 'hostPath' -> 'path' is null then 'ok'
        else 'alarm'
      end as status,
      case
        when v -> 'hostPath' -> 'path' is null then 'No host path volume mounted.'
        else 'Host path volume mounted for ' || (v ->> 'name') || '.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod,
      jsonb_array_elements(volumes) as v;
  EOQ
}

query "pod_hostipc_sharing_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when host_ipc then 'alarm'
        else 'ok'
      end as status,
      case
        when host_ipc then name || ' can share host IPC namespaces.'
        else name || ' cannot share host IPC namespaces.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod;
  EOQ
}

query "pod_default_seccomp_profile_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when security_context -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then 'ok'
        else 'alarm'
      end as status,
      case
        when security_context -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then name || ' seccompProfile enabled.'
        else name || ' seccompProfile disabled.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod;
  EOQ
}

query "pod_service_account_not_exist" {
  sql = <<-EOQ
    select
      coalesce(p.uid, concat(p.path, ':', p.start_line)) as resource,
      case
        when service_account_name is not null and service_account_name <> '' then 'ok'
        else 'alarm'
      end as status,
      case
        when service_account_name is not null and service_account_name <> '' then p.name || ' refer to an existing service account.'
        else p.name || ' does not refer to an existing service account.'
      end as reason,
      p.name as pod_name
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "p.")}
      ${replace(local.common_dimensions_qualifier_source_type_sql, "__QUALIFIER__", "p.")}
    from
      kubernetes_pod p
      left join kubernetes_service_account a on p.service_account_name = a.name;
  EOQ
}

query "pod_host_network_access_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when host_network then 'alarm'
        else 'ok'
      end as status,
      case
        when host_network then name || ' can use the host network.'
        else name || ' cannot use the host network.'
      end as reason,
      name as pod_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_pod;
  EOQ
}

