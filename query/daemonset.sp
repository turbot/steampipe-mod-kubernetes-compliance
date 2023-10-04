query "daemonset_cpu_request" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'resources' -> 'requests' ->> 'cpu' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'resources' -> 'requests' ->> 'cpu' is null then c ->> 'name' || ' does not have a CPU request.'
        else c ->> 'name' || ' has a CPU request of ' || (c -> 'resources' -> 'requests' ->> 'cpu') || '.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_readiness_probe" {
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
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_memory_limit" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'resources' -> 'limits' ->> 'memory' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'resources' -> 'limits' ->> 'memory' is null then c ->> 'name' || ' does not have a memory limit.'
        else c ->> 'name' || ' has a memory limit of ' || (c -> 'resources' -> 'limits' ->> 'memory') || '.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_immutable_container_filesystem" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'securityContext' ->> 'readOnlyRootFilesystem' = 'true' then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' ->> 'readOnlyRootFilesystem' = 'true' then c ->> 'name' || ' running with read-only root file system.'
        else c ->> 'name' || ' not running with read-only root file system.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_liveness_probe" {
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
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_privilege_port_mapped" {
  sql = <<-EOQ
    select
      case
        when source_type = 'deployed' then c ->> 'name'
        else concat(path, ':', start_line)
      end as resource,
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
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c,
      jsonb_array_elements(c -> 'ports') as p;
  EOQ
}

query "daemonset_host_network_access_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when template -> 'spec' ->> 'hostNetwork' = 'true' then 'alarm'
        else 'ok'
      end as status,
      case
        when template -> 'spec' ->> 'hostNetwork' = 'true' then 'DaemonSet pods using host network.'
        else 'DaemonSet pods not using host network.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset;
  EOQ
}

query "daemonset_hostpid_hostipc_sharing_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when template -> 'spec' ->> 'hostPID' = 'true' or template -> 'spec' ->> 'hostIPC' = 'true' then 'alarm'
        else 'ok'
      end as status,
      case
        when template -> 'spec' ->> 'hostPID' = 'true' then 'DaemonSet pods share host PID namespaces.'
        when template -> 'spec' ->> 'hostIPC' = 'true' then 'DaemonSet pods share host IPC namespaces.'
        else 'DaemonSet pods cannot share host process namespaces.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset;
  EOQ
}

query "daemonset_memory_request" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'resources' -> 'requests' ->> 'memory' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'resources' -> 'requests' ->> 'memory' is null then c ->> 'name' || ' does not have a memory request.'
        else c ->> 'name' || ' has a memory request of ' || (c -> 'resources' -> 'requests' ->> 'memory') || '.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_default_seccomp_profile_enabled" {
  sql = <<-EOQ
    select
      distinct(coalesce(uid, concat(path, ':', start_line))) as resource,
      case
        when c -> 'securityContext' -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then name || ' seccompProfile enabled.'
        else name || ' seccompProfile disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_cpu_limit" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'resources' -> 'limits' ->> 'cpu' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'resources' -> 'limits' ->> 'cpu' is null then c ->> 'name' || ' does not have a CPU limit.'
        else c ->> 'name' || ' has a CPU limit of ' || (c -> 'resources' -> 'limits' ->> 'cpu') || '.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_privilege_escalation_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then c ->> 'name' || ' not allowed root elevation.'
        else c ->> 'name' || ' allowed root elevation.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_non_root_container" {
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
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_privilege_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'securityContext' ->> 'privileged' = 'true' then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'securityContext' ->> 'privileged' = 'true' then c ->> 'name' || ' privileged container.'
        else c ->> 'name' || ' not privileged container.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_default_namespace_used" {
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
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset;
  EOQ
}

query "daemonset_container_with_added_capabilities" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'securityContext' -> 'capabilities' -> 'add' is null then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' -> 'capabilities' -> 'add' is null then c ->> 'name' || ' without added capability.'
        else c ->> 'name' || ' with added capability.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_security_context_exists" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'securityContext' is not null then 'ok'
        else 'alarm'
      end as status,
      case
        when c -> 'securityContext' is not null then c ->> 'name' || ' security context exists.'
        else c ->> 'name' || ' security context does not exist.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_image_tag_specified" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c ->> 'image' is null or c ->> 'image' = '' then 'alarm'
        when c ->> 'image' like '%@%' then 'ok'
        when ( select (regexp_matches(c ->> 'image', '(?:[^\s\/]+\/)?([^\s:]+):?([^\s]*)'))[2]) in ('latest', '') then 'alarm'
        else 'ok'
      end as status,
      case
        when c ->> 'image' is null or c ->> 'image' = '' then c ->> 'name' || ' no image specified.'
        when c ->> 'image' like '%@%' then c ->> 'name' || ' image with digest specified.'
        when (
          select (regexp_matches(c ->> 'image', '(?:[^\s\/]+\/)?([^\s:]+):?([^\s]*)'))[2]
        ) in ('latest', '') then c ->> 'name' || ' image with the latest tag or no tag specified.'
        else c ->> 'name' || ' image with tag specified.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_image_pull_policy_always" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
        case
          when c ->> 'image' is null or c ->> 'image' = '' then 'alarm'
          when c ->> 'imagePullPolicy' is null
            and (select (regexp_matches(c ->> 'image', '(?:[^\s\/]+\/)?([^\s:]+):?([^\s]*)'))[2]
            ) not in ('latest', '') then 'alarm'
          when c ->> 'imagePullPolicy' <> 'Always' then 'alarm'
          else 'ok'
        end
      as status,
        case
          when c ->> 'image' is null or c ->> 'image' = '' then c ->> 'name' || ' no image specified.'
          when c ->> 'imagePullPolicy' is null
            and (select (regexp_matches(c ->> 'image', '(?:[^\s\/]+\/)?([^\s:]+):?([^\s]*)'))[2]
            ) not in ('latest', '') then c ->> 'name' || ' image pull policy is not specified.'
          when c ->> 'imagePullPolicy' <> 'Always' then c ->> 'name' || ' image pull policy is not set to ''Always''.'
          else c ->> 'name' || ' image pull policy is set to ''Always''.'
        end
      as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_admission_capability_restricted" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'securityContext' -> 'capabilities' -> 'drop' is not null)
          and (c -> 'securityContext' -> 'capabilities' -> 'drop' @> '["all"]'
          or c -> 'securityContext' -> 'capabilities' -> 'drop' @> '["ALL"]'
          or c -> 'securityContext' -> 'capabilities' -> 'drop' @> '["NET_RAW"]') then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'securityContext' -> 'capabilities' -> 'drop' is not null)
          and (c -> 'securityContext' -> 'capabilities' -> 'drop' @> '["all"]'
          or c -> 'securityContext' -> 'capabilities' -> 'drop' @> '["ALL"]'
          or c -> 'securityContext' -> 'capabilities' -> 'drop' @> '["NET_RAW"]') then c ->> 'name' || ' admission capability is restricted.'
        else c ->> 'name' || ' admission capability is not restricted.'
      end as reason,
      name as daemonset_name
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_encryption_providers_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%"--encryption-provider-config=%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%"--encryption-provider-config=%') then c ->> 'name' || ' encryption providers not configured appropriately.'
        else c ->> 'name' || ' encryption providers configured appropriately.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_sys_admin_capability_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c -> 'securityContext' -> 'capabilities' -> 'add' @> '["CAP_SYS_ADMIN"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'securityContext' -> 'capabilities' -> 'add' @> '["CAP_SYS_ADMIN"]' then c ->> 'name' || ' CAP_SYS_ADMIN enabled.'
        else c ->> 'name' || ' CAP_SYS_ADMIN disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_capabilities_drop_all" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'securityContext' -> 'capabilities' -> 'drop' @> '["all"]')
          or (c -> 'securityContext' -> 'capabilities' -> 'drop' @> '["ALL"]') then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'securityContext' -> 'capabilities' -> 'drop' @> '["all"]')
        or (c -> 'securityContext' -> 'capabilities' -> 'drop' @> '["ALL"]') then c ->> 'name' || ' admission of containers with capabilities assigned minimized.'
        else c ->> 'name' || ' admission of containers with capabilities assigned not minimized.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_arg_peer_client_cert_auth_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'args') @> '["--peer-client-cert-auth=true"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'args') @> '["--peer-client-cert-auth=true"]' then c ->> 'name' || ' peer cldient cert auth enabled.'
        else c ->> 'name' || ' peer client cert auth disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_rotate_certificate_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kubelet"]') then 'ok'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--rotate-certificates=false"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kubelet"]') then c ->> 'name' || ' kubelet not defined.'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--rotate-certificates=false"]' then c ->> 'name' || ' rotate certificates disabled.'
        else c ->> 'name' || ' rotate certificates enabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_event_qps_less_than_5" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value
      from
        kubernetes_daemonset as p,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%event-qps=%'
    )
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kubelet"]') then 'ok'
        when l.container_name is null then 'ok'
        when l.container_name is not null and (c -> 'command') @> '["kubelet"]' and coalesce((l.value)::int, 0) > 5 then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kubelet"]') then c ->> 'name' || ' kubelet not defined.'
        when l.container_name is null then c ->> 'name' || ' event-qps is not set.'
        else c ->> 'name' || ' event-qps is set to ' || l.value || '.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c
      left join container_list as l on c ->> 'name' = l.container_name;
  EOQ
}

query "daemonset_container_argument_anonymous_auth_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kubelet"]') then 'ok'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--anonymous-auth=true"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kubelet"]') then c ->> 'name' || ' kubelet not defined.'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--anonymous-auth=true"]' then c ->> 'name' || ' rotate certificates disabled.'
        else c ->> 'name' || ' rotate certificates enabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_audit_log_path_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%"--audit-log-path=%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%"--audit-log-path=%') then c ->> 'name' || ' audit log path not configured.'
        else c ->> 'name' || ' audit log path configured.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_audit_log_maxage_greater_than_30" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%audit-log-maxage=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null then 'ok'
        when (d.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'alarm'
        when not ((d.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and coalesce((l.value)::int, 0) >= 30 then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when (d.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then  d.value ->> 'name' || ' audit-log-maxage not set.'
        when not ((d.value -> 'command') @> '["kube-apiserver"]')  then d.value ->> 'name' || ' kube-apiservernot not defined.'
        else d.value ->> 'name' || ' audit-log-maxage is set to ' || l.value || '.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_audit_log_maxbackup_greater_than_10" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%audit-log-maxbackup=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
       when (d.value -> 'command') is null then 'ok'
        when (d.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'alarm'
        when not ((d.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and coalesce((l.value)::int, 0) >= 10 then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when (d.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then  d.value ->> 'name' || ' audit-log-maxbackup not set.'
        when not ((d.value -> 'command') @> '["kube-apiserver"]')  then d.value ->> 'name' || ' kube-apiserver not defined.'
        else d.value ->> 'name' || ' audit-log-maxbackup is set to ' || l.value || '.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_audit_log_maxsize_greater_than_100" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%audit-log-maxsiz=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
         when (d.value -> 'command') is null then 'ok'
        when (d.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'alarm'
        when not ((d.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and coalesce((l.value)::int, 0) >= 100 then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when (d.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then  d.value ->> 'name' || ' audit-log-maxsize not set.'
        when not ((d.value -> 'command') @> '["kube-apiserver"]')  then d.value ->> 'name' || ' kube-apiserver not defined.'
        else d.value ->> 'name' || ' audit-log-maxsize is set to ' || l.value || '.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_no_argument_basic_auth_file" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' like '%--basic-auth-file%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' like '%--basic-auth-file%') then c ->> 'name' || ' basic auth file set.'
        else c ->> 'name' || ' basic auth file not set.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_etcd_cafile_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%--etcd-cafile%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%--etcd-cafile%') then c ->> 'name' || ' etcd cafile not set.'
        else c ->> 'name' || ' etcd cafile set.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_authorization_mode_node" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--authorization-mode=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null then 'ok'
        when (d.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'alarm'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and not ((l.value) like '%Node%') then 'alarm'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%Node%') then 'ok'
        else 'ok'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when (d.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then  d.value ->> 'name' || ' authorization mode not set.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and not ((l.value) like '%Node%') then d.value ->> 'name' || ' authorization mode not set to node.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%Node%') then d.value ->> 'name' || ' authorization mode set to node.'
        else d.value ->> 'name' || ' kube-apiserver not defined.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_authorization_mode_no_always_allow" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--authorization-mode=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysAllow%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kube-apiserver"]') then d.value ->> 'name' || ' kube-apiserver not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysAllow%') then d.value ->> 'name' || ' authorization mode set to always allow.'
        else d.value ->> 'name' || ' authorization mode not set to always allow.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_authorization_mode_rbac" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--authorization-mode=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null then 'ok'
        when (d.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'alarm'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and not ((l.value) like '%RBAC%') then 'alarm'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%RBAC%') then 'ok'
        else 'ok'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when (d.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then  d.value ->> 'name' || ' authorization mode not set.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and not ((l.value) like '%RBAC%') then d.value ->> 'name' || ' authorization mode not set to RBAC.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%RBAC%') then d.value ->> 'name' || ' authorization mode set to RBAC.'
        else d.value ->> 'name' || ' kube-apiserver not defined.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_no_argument_insecure_bind_address" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' like '%--insecure-bind-address%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' like '%--insecure-bind-address%') then c ->> 'name' || ' has insecure bind address.'
        else c ->> 'name' || ' has no insecure bind address.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kubelet_https_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--kubelet-https=false"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--kubelet-https=false"]' then c ->> 'name' || ' kubelet HTTPS disabled.'
        else c ->> 'name' || ' kubelet HTTPS enabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_insecure_port_0" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and not (c -> 'command') @> '["--insecure-port=0"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and not (c -> 'command') @> '["--insecure-port=0"]' then c ->> 'name' || ' insecure port not set to 0.'
        else c ->> 'name' || ' insecure port set to 0.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kubelet_client_certificate_and_key_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (
            not (c ->> 'command' like '%--kubelet-client-certificate%')
            or not (c ->> 'command' like '%--kubelet-client-key%')
          ) then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (
            not (c ->> 'command' like '%--kubelet-client-certificate%')
            or not (c ->> 'command' like '%--kubelet-client-key%')
          ) then c ->> 'name' || ' kubelet client certificate and key not set.'
        else c ->> 'name' || ' kubelet client certificate and key set.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (
            not (c ->> 'command' like '%--etcd-certfile%')
            or not (c ->> 'command' like '%--etcd-keyfile%')
          ) then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (
            not (c ->> 'command' like '%--etcd-certfile%')
            or not (c ->> 'command' like '%--etcd-keyfile%')
          ) then c ->> 'name' || ' kube-apiserver etcd certfile and etcd keyfile not set.'
        else c ->> 'name' || ' kube-apiserver etcd certfile and etcd keyfile set.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_admission_control_plugin_always_pull_images" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--enable-admission-plugins=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysPullImages%') then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kube-apiserver"]') then d.value ->> 'name' || ' kube-apiserver not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysPullImages%') then d.value ->> 'name' || ' admission control plugin set to always pull images.'
        else d.value ->> 'name' || ' admission control plugin not set to always pull images.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_admission_control_plugin_no_always_admit" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--enable-admission-plugins=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysAdmit%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kube-apiserver"]') then d.value ->> 'name' || ' kube-apiserver not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysAdmit%') then d.value ->> 'name' || ' admission control plugin set to always admit.'
        else d.value ->> 'name' || ' admission control plugin not set to always pull images.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_kube_scheduler_profiling_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-scheduler"]') then 'ok'
        when (c -> 'command') @> '["kube-scheduler"]'
          and (c -> 'command') @> '["--profiling=false"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-scheduler"]') then c ->> 'name' || ' kube-scheduler not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--profiling=false"]' then c ->> 'name' || ' profiling disabled.'
        else c ->> 'name' || ' profiling enabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kube_scheduler_bind_address_127_0_0_1" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--bind-address=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kube-scheduler"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-scheduler"]' and ((l.value) like '%127.0.0.1%') then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kube-scheduler"]') then d.value ->> 'name' || ' kube-scheduler not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-scheduler"]' and ((l.value) like '%127.0.0.1%') then d.value ->> 'name' || ' kube-scheduler bind address set to 127.0.0.1.'
        else d.value ->> 'name' || ' kube-scheduler bind address not set to 127.0.0.1.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_protect_kernel_defaults_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kubelet"]') then 'ok'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--protect-kernel-defaults=true"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kubelet"]') then c ->> 'name' || ' kubelet not defined.'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--protect-kernel-defaults=true"]' then c ->> 'name' || ' protect kernel defaults enabled.'
        else c ->> 'name' || ' protect kernel defaults disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_make_iptables_util_chains_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kubelet"]') then 'ok'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--make-iptables-util-chains=true"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kubelet"]') then c ->> 'name' || ' kubelet not defined.'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--make-iptables-util-chains=true"]' then c ->> 'name' || ' make iptables util chain enabled.'
        else c ->> 'name' || ' make iptables util chain disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kubelet"]') then 'ok'
        when (c -> 'command') @> '["kubelet"]'
          and (
            not (c ->> 'command' like '%--tls-cert-file%')
            or not (c ->> 'command' like '%--tls-private-key-file%')
          ) then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kubelet"]') then c ->> 'name' || ' kubelet not defined.'
         when (c -> 'command') @> '["kube-apiserver"]'
          and (
            not (c ->> 'command' like '%--tls-cert-file%')
            or not (c ->> 'command' like '%--tls-private-key-filey%')
          ) then c ->> 'name' || ' kubelet TLS cert file or private key not set.'
        else c ->> 'name' || ' kubelet TLS cert file and private key set.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_no_argument_hostname_override_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kubelet"]') then 'ok'
        when (c -> 'command') @> '["kubelet"]'
          and (c ->> 'command' like '%--hostname-override%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kubelet"]') then c ->> 'name' || ' kubelet not defined.'
        when (c -> 'command') @> '["kubelet"]'
          and (c ->> 'command' like '%--hostname-override%') then c ->> 'name' || ' hostname override set.'
        else c ->> 'name' || ' hostname override not set.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kube_controller_manager_profiling_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-controller-manager"]') then 'ok'
        when (c -> 'command') @> '["kube-controller-manager"]'
          and (c -> 'command') @> '["--profiling=false"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-controller-manager"]') then c ->> 'name' || ' kube-controller-manager not defined.'
        when (c -> 'command') @> '["kube-controller-manager"]'
          and (c -> 'command') @> '["--profiling=false"]' then c ->> 'name' || ' profiling disabled.'
        else c ->> 'name' || ' profiling enabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_etcd_auto_tls_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["etcd"]') then 'ok'
        when (c -> 'command') @> '["etcd"]'
          and (c -> 'command') @> '["--auto-tls=true"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["etcd"]') then c ->> 'name' || ' etcd not defined.'
        when (c -> 'command') @> '["etcd"]'
          and (c -> 'command') @> '["-auto-tls=true"]' then c ->> 'name' || ' auto TLS enabled.'
        else c ->> 'name' || ' auto TLS disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kube_controller_manager_service_account_credentials_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-controller-manager"]') then 'ok'
        when (c -> 'command') @> '["kube-controller-manager"]'
          and (c -> 'command') @> '["--use-service-account-credentials=true"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-controller-manager"]') then c ->> 'name' || ' kube-controller-manager not defined.'
        when (c -> 'command') @> '["kube-controller-manager"]'
          and (c -> 'command') @> '["--use-service-account-credentials=true"]' then c ->> 'name' || ' use service account credential enabled.'
        else c ->> 'name' || ' use service account credential disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kubelet_authorization_mode_no_always_allow" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--authorization-mode=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kubelet"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kubelet"]' and ((l.value) like '%AlwaysAllow%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kubelet"]') then d.value ->> 'name' || ' kubelet not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kubelet"]' and ((l.value) like '%AlwaysAllow%') then d.value ->> 'name' || ' authorization mode set to always allow.'
        else d.value ->> 'name' || ' authorization mode not set to always allow.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_kube_controller_manager_service_account_private_key_file_configured" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '.', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--service-account-private-key-file%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kube-controller-manager"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-controller-manager"]' and ((l.value) like '%pem%') then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kube-controller-manager"]') then d.value ->> 'name' || ' kube-controller-manager not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-controller-manager"]' and ((l.value) like '%pem%') then d.value ->> 'name' || ' service account private key file is set.'
        else d.value ->> 'name' || ' service account private key file is not set.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_kubelet_read_only_port_0" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--read-only-port=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kubelet"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kubelet"]' and (l.value = 0) then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kubelet"]') then d.value ->> 'name' || ' kubelet not defined.'
        else d.value ->> 'name' || ' read-only port is set to ' || (l.value) || '.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_kube_controller_manager_root_ca_file_configured" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '.', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--root-ca-file%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kube-controller-manager"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-controller-manager"]' and ((l.value) like '%pem%') then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kube-controller-manager"]') then d.value ->> 'name' || ' kube-controller-manager not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-controller-manager"]' and ((l.value) like '%pem%') then d.value ->> 'name' || ' root-ca-file is set.'
        else d.value ->> 'name' || ' root-ca-file is not set.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_etcd_client_cert_auth_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["etcd"]') then 'ok'
        when (c -> 'command') @> '["etcd"]'
          and (c -> 'command') @> '["--client-cert-auth=true"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["etcd"]') then c ->> 'name' || ' etcd not defined.'
        when (c -> 'command') @> '["etcd"]'
          and (c -> 'command') @> '["--client-cert-auth=true"]' then c ->> 'name' || ' client cert auth enabled.'
        else c ->> 'name' || ' client cert auth disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_namespace_lifecycle_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--enable-admission-plugins=NamespaceLifecycle"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--enable-admission-plugins=NamespaceLifecycle"]' then c ->> 'name' || ' has admission control plugin NamespaceLifecycle enabled.'
        else c ->> 'name' || ' has admission control plugin NamespaceLifecycle disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}
query "daemonset_container_argument_service_account_lookup_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null then 'ok'
        when not (c -> 'command') @> '["kube-apiserver"]' then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--service-account-lookup=true"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then ' command not defined.'
        when not (c -> 'command') @> '["kube-apiserver"]' then ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--service-account-lookup=true"]' then  c ->> 'name' || ' service account lookup enabled.'
        else c ->> 'name' || ' service account lookup disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_token_auth_file_not_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null then 'ok'
        when not (c -> 'command') @> '["kube-apiserver"]' then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%--token-auth-file%') then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then ' command not defined.'
        when not (c -> 'command') @> '["kube-apiserver"]' then ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%--token-auth-file%') then  c ->> 'name' || ' token auth file not configured.'
        else c ->> 'name' || ' token auth file configured.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_kubelet_certificate_authority_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null then 'ok'
        when not (c -> 'command') @> '["kube-apiserver"]' then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' like '%--kubelet-certificate-authority%') then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then ' command not defined.'
        when not (c -> 'command') @> '["kube-apiserver"]' then ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' like '%--kubelet-certificate-authority%') then  c ->> 'name' || ' kubelet certificate authority configured.'
        else c ->> 'name' || ' kubelet certificate authority not configured.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_node_restriction_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--enable-admission-plugins=NodeRestriction"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--enable-admission-plugins=NodeRestriction"]' then c ->> 'name' || ' has admission control plugin NodeRestriction enabled.'
        else c ->> 'name' || ' has admission control plugin NodeRestriction disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_pod_security_policy_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--enable-admission-plugins=PodSecurityPolicy"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--enable-admission-plugins=PodSecurityPolicy"]' then c ->> 'name' || ' has admission control plugin PodSecurityPolicy enabled.'
        else c ->> 'name' || ' has admission control plugin PodSecurityPolicy disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_security_context_deny_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and ((c -> 'command') @> '["--enable-admission-plugins=PodSecurityPolicy"]' or (c -> 'command') @> '["--enable-admission-plugins=SecurityContextDeny"]') then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--enable-admission-plugins=PodSecurityPolicy"]' then c ->> 'name' || ' has admission control plugin PodSecurityPolicy enabled.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--enable-admission-plugins=SecurityContextDeny"]' then c ->> 'name' || ' has admission control plugin SecurityContextDeny enabled.'
        else c ->> 'name' || ' has admission control plugin PodSecurityPolicy and SecurityContextDeny disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kube_apiserver_profiling_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--profiling=false"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--profiling=false"]' then c ->> 'name' || ' profiling disabled.'
        else c ->> 'name' || ' profiling enabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_secure_port_not_0" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--secure-port=0"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--secure-port=0"]' then c ->> 'name' || ' secure port set to 0.'
        else c ->> 'name' || ' secure port not set to 0.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_service_account_key_file_appropriate" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements_text(c -> 'command') as co
      where
        co like '%--service-account-key-file=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%.pem') then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kube-apiserver"]') then d.value ->> 'name' || ' kube-apiserver not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%.pem') then d.value ->> 'name' || ' service-account-key-file set appropriate.'
        else d.value ->> 'name' || ' service-account-key-file set inappropriate.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_kubernetes_dashboard_not_deployed" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c ->> 'image' is null or c ->> 'image' = '' then 'ok'
        when not pg_typeof(c->>'image') = 'text'::regtype then 'alarm'
        when c ->> 'image' = 'kubernetes-dashboard'
          or c ->> 'image' = 'kubernetesui'
          or labels ->> 'apps' = 'kubernetes-dashboard'
          or labels ->> 'k8s-app' = 'kubernetes-dashboard' then 'alarm'
        else 'ok'
      end as status,
      case
        when c ->> 'image' is null or c ->> 'image' = '' then c ->> 'name' || ' no image specified.'
        when not pg_typeof(c->>'image') = 'text'::regtype then c ->> 'name' || ' image invalid.'
        when c ->> 'image' = 'kubernetes-dashboard'
          or c ->> 'image' = 'kubernetesui'
          or labels ->> 'apps' = 'kubernetes-dashboard'
          or labels ->> 'k8s-app' = 'kubernetes-dashboard' then c ->> 'name' || ' kubernetes dashboard deployed.'
        else c ->> 'name' || ' kubernetes dashboard not deployed.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_streaming_connection_idle_timeout_not_zero" {
  sql = <<-EOQ
    select
      distinct(coalesce(uid, concat(path, ':', start_line))) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kubelet"]') then 'ok'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--streaming-connection-idle-timeout=0"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kubelet"]') then c ->> 'name' || ' kubelet not defined.'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--streaming-connection-idle-timeout=0"]' then c ->> 'name' || ' --streaming-connection-idle-timeout argument set to 0.'
        when not (c ->> 'command' like '%--streaming-connection-idle-timeout%') then c ->> 'name' || ' --streaming-connection-idle-timeout argument not set.'
        else c ->> 'name' || ' --streaming-connection-idle-timeout argument not set to 0.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_strong_kubelet_cryptographic_ciphers" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements_text(c -> 'command') as co
      where
        co like '%--tls-cipher-suites=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kubelet"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kubelet"]'
          and string_to_array(l.value, ',') <@ array['TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256','TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256','TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305','TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384','TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305','TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384','TLS_RSA_WITH_AES_256_GCM_SHA384','TLS_RSA_WITH_AES_128_GCM_SHA256']
        then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kubelet"]') then d.value ->> 'name' || ' kubelet not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kubelet"]'
          and string_to_array(l.value, ',') <@ array['TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256','TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256','TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305','TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384','TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305','TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384','TLS_RSA_WITH_AES_256_GCM_SHA384','TLS_RSA_WITH_AES_128_GCM_SHA256']
        then d.value ->> 'name' || ' kubelet uses strong cryptographic ciphers.'
        else d.value ->> 'name' || ' kubelet not using strong cryptographic ciphers.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_rotate_kubelet_server_certificate_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-controller-manager"]' or (c -> 'command') @> '["kubelet"]') then 'ok'
        when ((c -> 'command') @> '["kube-controller-manager"]' or (c -> 'command') @> '["kubelet"]')
          and (c -> 'command') @> '["--feature-gates=RotateKubeletServerCertificate=true"]' then  'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-controller-manager"]' or (c -> 'command') @> '["kubelet"]') then c ->> 'name' || 'kube-controller-manager or kubelet not defined'
        when ((c -> 'command') @> '["kube-controller-manager"]' or (c -> 'command') @> '["kubelet"]')
          and (c -> 'command') @> '["--feature-gates=RotateKubeletServerCertificate=true"]' then c ->> 'name' || ' RotateKubeletServerCertificate argument enabled.'
        else c ->> 'name' || ' RotateKubeletServerCertificate argument disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_etcd_certfile_and_keyfile_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["etcd"]') then 'ok'
        when (c -> 'command') @> '["etcd"]'
          and (
            not (c ->> 'command' like '%--cert-file%')
            or not (c ->> 'command' like '%--key-file%')
          ) then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["etcd"]') then c ->> 'name' || ' etcd not defined.'
        when (c -> 'command') @> '["etcd"]'
          and(
            not (c ->> 'command' like '%--cert-file%')
            or not (c ->> 'command' like '%--key-file%')
          ) then c ->> 'name' || ' etcd certfile and keyfile not set.'
        else c ->> 'name' || ' etcd certfile and keyfile set.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_etcd_peer_certfile_and_peer_keyfile_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["etcd"]') then 'ok'
        when (c -> 'command') @> '["etcd"]'
          and (
            not (c ->> 'command' like '%--peer-cert-file%')
            or not (c ->> 'command' like '%--peer-key-file%')
          ) then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["etcd"]') then c ->> 'name' || ' etcd not defined.'
        when (c -> 'command') @> '["etcd"]'
          and(
            not (c ->> 'command' like '%--peer-cert-file%')
            or not (c ->> 'command' like '%--peer-key-file%')
          ) then c ->> 'name' || ' etcd peer certfile and peer keyfile not set.'
        else c ->> 'name' || ' etcd peer certfile and peer keyfile set.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kube_controller_manager_bind_address_127_0_0_1" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--bind-address=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kube-controller-manager"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-controller-manager"]' and ((l.value) like '%127.0.0.1%') then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kube-controller-manager"]') then d.value ->> 'name' || ' kube-controller-manager not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-controller-manager"]' and ((l.value) like '%127.0.0.1%') then d.value ->> 'name' || ' kube-controller-manager bind address set to 127.0.0.1.'
        else d.value ->> 'name' || ' kube-controller-manager bind address not set to 127.0.0.1.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_service_account_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--enable-admission-plugins=ServiceAccount"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c -> 'command') @> '["--enable-admission-plugins=ServiceAccount"]' then c ->> 'name' || ' has admission control plugin ServiceAccount enabled.'
        else c ->> 'name' || ' has admission control plugin ServiceAccount disabled.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_kubelet_terminated_pod_gc_threshold_configured" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--read-only-port=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kubelet"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kubelet"]' and coalesce((l.value)::int, 0) > 0 then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kubelet"]') then d.value ->> 'name' || ' kubelet not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kubelet"]' and coalesce((l.value)::int, 0) > 0 then d.value ->> 'name' || ' kubelet terminated pod gc threshold is set to ' || (l.value) || '.'
        else d.value ->> 'name' || ' kubelet terminated pod gc threshold is not set apropriately.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_kubelet_client_ca_file_configured" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--client-ca-file=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kubelet"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kubelet"]' and l.value is not null and l.value <> '' then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kubelet"]') then d.value ->> 'name' || ' kubelet not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kubelet"]' and l.value is not null and l.value <> '' then d.value ->> 'name' || ' kubelet client CA file configured.'
        else d.value ->> 'name' || ' kubelet client CA file not configured.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null or not ((c -> 'command') @> '["kube-apiserver"]') then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (
            not (c ->> 'command' like '%--tls-cert-file%')
            or not (c ->> 'command' like '%--tls-private-key-file%')
          ) then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when not ((c -> 'command') @> '["kube-apiserver"]') then c ->> 'name' || ' kube-apiserver not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (
            not (c ->> 'command' like '%--tls-cert-file%')
            or not (c ->> 'command' like '%--tls-private-key-filey%')
          ) then c ->> 'name' || ' kube-apiserver tls cert file or private key not set.'
        else c ->> 'name' || ' kube-apiserver tls cert file and private key set.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_strong_kube_apiserver_cryptographic_ciphers" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        d.name as daemonset
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements_text(c -> 'command') as co
      where
        co like '%--tls-cipher-suites=%'
    ), container_name_with_daemonset_name as (
      select
        d.name as daemonset_name,
        d.uid as daemonset_uid,
        d.path as path,
        d.start_line as start_line,
        d.end_line as end_line,
        d.context_name as context_name,
        d.namespace as namespace,
        d.source_type as source_type,
        d.tags as tags,
        d._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.daemonset_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when (d.value -> 'command') is null or not ((d.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]'
          and string_to_array(l.value, ',') <@ array['TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256','TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256','TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305','TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384','TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305','TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384','TLS_RSA_WITH_AES_256_GCM_SHA384','TLS_RSA_WITH_AES_128_GCM_SHA256']
        then 'ok'
        else 'alarm'
      end as status,
      case
        when (d.value -> 'command') is null then d.value ->> 'name' || ' command not defined.'
        when not ((d.value -> 'command') @> '["kube-apiserver"]') then d.value ->> 'name' || ' kube-apiserver not defined.'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]'
          and string_to_array(l.value, ',') <@ array['TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256','TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256','TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305','TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384','TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305','TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384','TLS_RSA_WITH_AES_256_GCM_SHA384','TLS_RSA_WITH_AES_128_GCM_SHA256']
        then d.value ->> 'name' || ' kube-apiserver uses strong cryptographic ciphers.'
        else d.value ->> 'name' || ' kube-apiserver not using strong cryptographic ciphers.'
      end as reason,
      d.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_host_port_not_specified" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'ports') is null then 'ok'
        when (c->>'ports') like '%hostPort%' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'ports') is null then c ->> 'name' || ' ports not defined.'
        when (c->>'ports') like '%hostPort%' then c ->> 'name' || ' host port specified.'
        else c ->> 'name' || ' host port not specified.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "daemonset_container_argument_request_timeout_appropriate" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        p.name as daemonset
      from
        kubernetes_daemonset as p,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements_text(c -> 'command') as co
      where
        co like '%--request-timeout=%'
    ), container_name_with_daemonset_name as (
      select
        p.name as daemonset_name,
        p.uid as daemonset_uid,
        p.path as path,
        p.start_line as start_line,
        p.end_line as end_line,
        p.context_name as context_name,
        p.namespace as namespace,
        p.source_type as source_type,
        p.tags as tags,
        p._ctx as _ctx,
        c.*
      from
        kubernetes_daemonset as p,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(p.daemonset_uid, concat(p.path, ':', p.start_line)) as resource,
      case
        when (p.value -> 'command') is null then 'ok'
        when (p.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'ok'
        when not ((p.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (p.value -> 'command') @> '["kube-apiserver"]' and ((l.value) ~ '^(\d{1,2}[h])(\d{1,2}[m])?(\d{1,2}[s])?$|^(\d{1,2}[m])?(\d{1,2}[s])?$|^(\d{1,2}[s])$') then 'ok'
        else 'alarm'
      end as status,
      case
        when (p.value -> 'command') is null then p.value ->> 'name' || ' command not defined.'
        when (p.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then  p.value ->> 'name' || ' request-timeout not set.'
        when not ((p.value -> 'command') @> '["kube-apiserver"]') then p.value ->> 'name' || ' kube-apiserver not defined.'
        when l.container_name is not null and (p.value -> 'command') @> '["kube-apiserver"]' and ((l.value) ~ '^(\d{1,2}[h])(\d{1,2}[m])?(\d{1,2}[s])?$|^(\d{1,2}[m])?(\d{1,2}[s])?$|^(\d{1,2}[s])$') then p.value ->> 'name' || ' request-timeout set appropriate.'
        else p.value ->> 'name' || ' request-timeout set inappropriate.'
      end as reason,
      p.daemonset_name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_daemonset_name as p
      left join container_list as l on p.value ->> 'name' = l.container_name and p.daemonset_name = l.daemonset;
  EOQ
}

query "daemonset_container_secrets_defined_as_files" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when env like '%valueFrom%' and env like '%secretKeyRef%' then 'alarm'
        else 'ok'
      end as status,
      case
        when env like '%valueFrom%' and env like '%secretKeyRef%' then c ->> 'name' || ' container has secrets defined.'
        else c ->> 'name' || ' container has no secrets defined.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c,
      jsonb_array_elements_text(c -> 'env') as env

    union

    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when env like '%secretRef%' then 'alarm'
        else 'ok'
      end as status,
      case
        when env like '%secretRef%' then c ->> 'name' || ' container has secrets defined.'
        else c ->> 'name' || ' container has no secrets defined.'
      end as reason,
      name as daemonset_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_daemonset,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c,
      jsonb_array_elements_text(c -> 'envFrom') as env;
  EOQ
}