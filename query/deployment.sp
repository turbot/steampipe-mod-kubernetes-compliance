query "deployment_default_seccomp_profile_enabled" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_default_namespace_used" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment;
  EOQ
}

query "deployment_replica_minimum_3" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when replicas < 3 then 'alarm'
        else 'ok'
      end as status,
      name || ' has ' || replicas || ' replica.' as reason,
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment;
  EOQ
}

query "deployment_immutable_container_filesystem" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_cpu_request" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_privilege_disabled" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_memory_request" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_cpu_limit" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_privilege_port_mapped" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c,
      jsonb_array_elements(c -> 'ports') as p;
  EOQ
}

query "deployment_container_liveness_probe" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_memory_limit" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_host_network_access_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when template -> 'spec' ->> 'hostNetwork' = 'true' then 'alarm'
        else 'ok'
      end as status,
      case
        when template -> 'spec' ->> 'hostNetwork' = 'true' then 'Deployment pods using host network.'
        else 'Deployment pods not using host network.'
      end as reason,
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment;
  EOQ
}

query "deployment_container_readiness_probe" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_non_root_container" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_privilege_escalation_disabled" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_hostpid_hostipc_sharing_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when template -> 'spec' ->> 'hostPID' = 'true' or template -> 'spec' ->> 'hostIPC' = 'true' then 'alarm'
        else 'ok'
      end as status,
      case
        when template -> 'spec' ->> 'hostPID' = 'true' then 'Deployment pods share host pid namespaces.'
        when template -> 'spec' ->> 'hostIPC' = 'true' then 'Deployment pods share host ipc namespaces.'
        else 'Deployment pods cannot share host process namespaces.'
      end as reason,
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment;
  EOQ
}

query "deployment_container_with_added_capabilities" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_security_context_exists" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_image_tag_specified" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c ->> 'image' is null or c ->> 'image' = '' then 'alarm'
        when c ->> 'image' like '%@%' then 'ok'
        when (
          select (regexp_matches(c ->> 'image', '(?:[^\s\/]+\/)?([^\s:]+):?([^\s]*)'))[2]
        ) in ('latest', '') then 'alarm'
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_image_pull_policy_always" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when c ->> 'image' is null or c ->> 'image' = '' then 'alarm'
        when c ->> 'imagePullPolicy' is null
          and ( select (regexp_matches(c ->> 'image', '(?:[^\s\/]+\/)?([^\s:]+):?([^\s]*)'))[2]
          ) not in ('latest', '') then 'alarm'
        when c ->> 'imagePullPolicy' <> 'Always' then 'alarm'
        else 'ok'
      end as status,
      case
        when c ->> 'image' is null or c ->> 'image' = '' then c ->> 'name' || ' no image specified.'
        when c ->> 'imagePullPolicy' is null
          and ( select (regexp_matches(c ->> 'image', '(?:[^\s\/]+\/)?([^\s:]+):?([^\s]*)'))[2]
          ) not in ('latest', '') then c ->> 'name' || ' image pull policy is not specified.'
        when c ->> 'imagePullPolicy' <> 'Always' then c ->> 'name' || ' image pull policy is not set to ''Always''.'
        else c ->> 'name' || ' image pull policy is set to ''Always''.'
      end as reason,
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_admission_capability_restricted" {
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
      name as deployment_name
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_encryption_providers_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%"--encryption-provider-config=%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%"--encryption-provider-config=%') then c ->> 'name' || ' encryption providers not configured appropriately.'
        else c ->> 'name' || ' encryption providers configured appropriately.'
      end as reason,
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_sys_admin_capability_disabled" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_capabilities_drop_all" {
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
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_arg_peer_client_cert_auth_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'args') @> '["--peer-client-cert-auth=true"]' then 'ok'
        else 'alarm'
      end as status,
      case
        when (c -> 'args') @> '["--peer-client-cert-auth=true"]' then c ->> 'name' || ' peer client cert auth enabled.'
        else c ->> 'name' || ' peer client cert auth disabled.'
      end as reason,
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_rotate_certificate_enabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--rotate-certificates=false"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') @> '["kubelet"]'
        and (c -> 'command') @> '["--rotate-certificates=false"]' then c ->> 'name' || ' rotate certificates disabled.'
        else c ->> 'name' || ' rotate certificates enabled.'
      end as reason,
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_argument_event_qps_less_than_5" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value
      from
        kubernetes_deployment,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%event-qps=%'
    )
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when l.container_name is null then 'ok'
        when l.container_name is not null and (c -> 'command') @> '["kubelet"]' and coalesce((l.value)::int, 0) > 5 then 'alarm'
        else 'ok'
      end as status,
      case
        when l.container_name is null then c ->> 'name' || ' event-qps is not set.'
        else c ->> 'name' || ' event-qps is set to ' || l.value || '.'
      end as reason,
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c
      left join container_list as l on c ->> 'name' = l.container_name;
  EOQ
}

query "deployment_container_argument_anonymous_auth_disabled" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--anonymous-auth=true"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--anonymous-auth=true"]' then c ->> 'name' || ' anonymous auth enabled.'
        else c ->> 'name' || ' anonymous auth disabled.'
      end as reason,
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_argument_audit_log_path_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%"--audit-log-path=%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%"--audit-log-path=%') then c ->> 'name' || ' audit log path not configured.'
        else c ->> 'name' || ' audit log path configured.'
      end as reason,
      name as deployment_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_deployment,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "deployment_container_argument_audit_log_maxage_greater_than_30" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value,
        d.name as deployment
      from
        kubernetes_deployment as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%audit-log-maxage=%'
    ), container_name_with_deployment_name as (
      select
        d.name as deployment_name,
        d.uid as deployment_uid,
        d.path as path,
        d.start_line as start_line,
        c.*
      from
        kubernetes_deployment as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.deployment_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when l.container_name is null then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and coalesce((l.value)::int, 0) >= 30 then 'ok'
        else 'alarm'
      end as status,
      case
        when l.container_name is null then d.value ->> 'name' || ' audit-log-maxage is not set.'
        else d.value ->> 'name' || ' audit-log-maxage is set to ' || l.value || '.'
      end as reason,
      d.deployment_name as deployment_name
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      container_name_with_deployment_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.deployment_name = l.deployment
  EOQ
}

query "deployment_container_argument_audit_log_maxbackup_greater_than_10" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value,
        d.name as deployment
      from
        kubernetes_deployment as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%audit-log-maxbackup=%'
    ), container_name_with_deployment_name as (
      select
        d.name as deployment_name,
        d.uid as deployment_uid,
        d.path as path,
        d.start_line as start_line,
        c.*
      from
        kubernetes_deployment as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.deployment_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when l.container_name is null then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and coalesce((l.value)::int, 0) >= 30 then 'ok'
        else 'alarm'
      end as status,
      case
        when l.container_name is null then d.value ->> 'name' || ' audit-log-maxbackup is not set.'
        else d.value ->> 'name' || ' audit-log-maxbackup is set to ' || l.value || '.'
      end as reason,
      d.deployment_name as deployment_name
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      container_name_with_deployment_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.deployment_name = l.deployment
  EOQ
}

query "deployment_container_argument_audit_log_maxsize_greater_than_100" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value,
        d.name as deployment
      from
        kubernetes_deployment as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%audit-log-maxsize=%'
    ), container_name_with_deployment_name as (
      select
        d.name as deployment_name,
        d.uid as deployment_uid,
        d.path as path,
        d.start_line as start_line,
        c.*
      from
        kubernetes_deployment as d,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(d.deployment_uid, concat(d.path, ':', d.start_line)) as resource,
      case
        when l.container_name is null then 'ok'
        when l.container_name is not null and (d.value -> 'command') @> '["kube-apiserver"]' and coalesce((l.value)::int, 0) >= 100 then 'ok'
        else 'alarm'
      end as status,
      case
        when l.container_name is null then d.value ->> 'name' || ' audit-log-maxsize is not set.'
        else d.value ->> 'name' || ' audit-log-maxsize is set to ' || l.value || '.'
      end as reason,
      d.deployment_name as deployment_name
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      container_name_with_deployment_name as d
      left join container_list as l on d.value ->> 'name' = l.container_name and d.deployment_name = l.deployment;
  EOQ
}
