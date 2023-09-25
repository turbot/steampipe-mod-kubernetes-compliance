query "pod_template_container_privilege_escalation_disabled" {
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
      name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_pod_template,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "pod_template_container_with_added_capabilities" {
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
      name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_pod_template,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "pod_template_container_sys_admin_capability_disabled" {
  sql = <<-EOQ
    select
      distinct(coalesce(uid, concat(path, ':', start_line))) as resource,
      case
        when c -> 'securityContext' -> 'capabilities' -> 'add' @> '["CAP_SYS_ADMIN"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when c -> 'securityContext' -> 'capabilities' -> 'add' @> '["CAP_SYS_ADMIN"]' then c ->> 'name' || ' CAP_SYS_ADMIN enabled.'
        else c ->> 'name' || ' CAP_SYS_ADMIN disabled.'
      end as reason,
      name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_pod_template,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "pod_template_container_admission_control_plugin_no_always_admit" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        j.name as pod_template
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--enable-admission-plugins=%'
    ), container_name_with_pod_template_name as (
      select
        j.name as pod_template_name,
        j.uid as pod_template_uid,
        j.path as path,
        j.start_line as start_line,
        j.context_name as context_name,
        j.namespace as namespace,
        j.source_type as source_type,
        c.*
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(j.pod_template_uid, concat(j.path, ':', j.start_line)) as resource,
      case
        when (j.value -> 'command') is null or not ((j.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysAdmit%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (j.value -> 'command') is null then j.value ->> 'name' || ' command not defined.'
        when not ((j.value -> 'command') @> '["kube-apiserver"]') then j.value ->> 'name' || ' kube-apiserver not defined.'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysAdmit%') then j.value ->> 'name' || ' admission control plugin set to always admit.'
        else j.value ->> 'name' || ' admission control plugin not set to always pull images.'
      end as reason,
      j.pod_template_name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_pod_template_name as j
      left join container_list as l on j.value ->> 'name' = l.container_name and j.pod_template_name = l.pod_template;
  EOQ
}

query "pod_template_container_admission_control_plugin_always_pull_images" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        j.name as pod_template
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--enable-admission-plugins=%'
    ), container_name_with_pod_template_name as (
      select
        j.name as pod_template_name,
        j.uid as pod_template_uid,
        j.path as path,
        j.start_line as start_line,
        j.context_name as context_name,
        j.namespace as namespace,
        j.source_type as source_type,
        c.*
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(j.pod_template_uid, concat(j.path, ':', j.start_line)) as resource,
      case
        when (j.value -> 'command') is null or not ((j.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysPullImages%') then 'ok'
        else 'alarm'
      end as status,
      case
        when (j.value -> 'command') is null then j.value ->> 'name' || ' command not defined.'
        when not ((j.value -> 'command') @> '["kube-apiserver"]') then j.value ->> 'name' || ' kube-apiserver not defined.'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysPullImages%') then j.value ->> 'name' || ' admission control plugin set to always pull images.'
        else j.value ->> 'name' || ' admission control plugin not set to always pull images.'
      end as reason,
      j.pod_template_name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_pod_template_name as j
      left join container_list as l on j.value ->> 'name' = l.container_name and j.pod_template_name = l.pod_template;
  EOQ
}

query "pod_template_container_argument_anonymous_auth_disabled" {
  sql = <<-EOQ
    select
      distinct(coalesce(uid, concat(path, ':', start_line))) as resource,
      case
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--anonymous-auth=true"]' then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
         when not ((c -> 'command') @> '["kubelet"]') then c ->> 'name' || ' kubelet not defined.'
        when (c -> 'command') @> '["kubelet"]'
          and (c -> 'command') @> '["--anonymous-auth=true"]' then c ->> 'name' || ' anonymous auth enabled.'
        else c ->> 'name' || ' anonymous auth disabled.'
      end as reason,
      name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_pod_template,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "pod_template_container_argument_audit_log_path_configured" {
  sql = <<-EOQ
    select
      distinct(coalesce(uid, concat(path, ':', start_line))) as resource,
      case
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
      name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_pod_template,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "pod_template_container_argument_audit_log_maxage_greater_than_30" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value,
        j.name as pod_template
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%audit-log-maxage=%'
    ), container_name_with_pod_template_name as (
      select
        j.name as pod_template_name,
        j.uid as pod_template_uid,
        j.path as path,
        j.start_line as start_line,
        j.context_name as context_name,
        j.namespace as namespace,
        j.source_type as source_type,
        c.*
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(j.pod_template_uid, concat(j.path, ':', j.start_line)) as resource,
      case
        when (j.value -> 'command') is null then 'ok'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'alarm'
        when not ((j.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and coalesce((l.value)::int, 0) >= 30 then 'ok'
        else 'alarm'
      end as status,
      case
        when (j.value -> 'command') is null then j.value ->> 'name' || ' command not defined.'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then j.value ->> 'name' || ' audit-log-maxage not set.'
        when not ((j.value -> 'command') @> '["kube-apiserver"]') then j.value ->> 'name' || ' kube-apiserver not defined.'
        else j.value ->> 'name' || ' audit-log-maxage is set to ' || l.value || '.'
      end as reason,
      j.pod_template_name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_pod_template_name as j
      left join container_list as l on j.value ->> 'name' = l.container_name and j.pod_template_name = l.pod_template;
  EOQ
}

query "pod_template_container_argument_audit_log_maxbackup_greater_than_10" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value,
        j.name as pod_template
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%audit-log-maxbackup=%'
    ), container_name_with_pod_template_name as (
      select
        j.name as pod_template_name,
        j.uid as pod_template_uid,
        j.path as path,
        j.start_line as start_line,
        j.context_name as context_name,
        j.namespace as namespace,
        j.source_type as source_type,
        c.*
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(j.pod_template_uid, concat(j.path, ':', j.start_line)) as resource,
      case
        when (j.value -> 'command') is null then 'ok'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'alarm'
        when not ((j.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and coalesce((l.value)::int, 0) >= 10 then 'ok'
        else 'alarm'
      end as status,
      case
        when (j.value -> 'command') is null then j.value ->> 'name' || ' command not defined.'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then j.value ->> 'name' || ' audit-log-maxbackup not set.'
        when not ((j.value -> 'command') @> '["kube-apiserver"]') then j.value ->> 'name' || ' kube-apiserver not defined.'
        else j.value ->> 'name' || ' audit-log-maxbackup is set to ' || l.value || '.'
      end as reason,
      j.pod_template_name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_pod_template_name as j
      left join container_list as l on j.value ->> 'name' = l.container_name and j.pod_template_name = l.pod_template;
  EOQ
}

query "pod_template_container_argument_audit_log_maxsize_greater_than_100" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2))::integer as value,
        j.name as pod_template
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%audit-log-maxsize=%'
    ), container_name_with_pod_template_name as (
      select
        j.name as pod_template_name,
        j.uid as pod_template_uid,
        j.path as path,
        j.start_line as start_line,
        j.context_name as context_name,
        j.namespace as namespace,
        j.source_type as source_type,
        c.*
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(j.pod_template_uid, concat(j.path, ':', j.start_line)) as resource,
      case
        when (j.value -> 'command') is null then 'ok'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'alarm'
        when not ((j.value -> 'command') @> '["kube-apiserver"]') then 'ok'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and coalesce((l.value)::int, 0) >= 100 then 'ok'
        else 'alarm'
      end as status,
      case
        when (j.value -> 'command') is null then j.value ->> 'name' || ' command not defined.'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then j.value ->> 'name' || ' audit-log-maxsize not set.'
        when not ((j.value -> 'command') @> '["kube-apiserver"]') then j.value ->> 'name' || ' kube-api server not defined.'
        else j.value ->> 'name' || ' audit-log-maxsize is set to ' || l.value || '.'
      end as reason,
      j.pod_template_name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_pod_template_name as j
      left join container_list as l on j.value ->> 'name' = l.container_name and j.pod_template_name = l.pod_template;
  EOQ
}

query "pod_template_container_argument_authorization_mode_node" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        j.name as pod_template
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--authorization-mode=%'
    ), container_name_with_pod_template_name as (
      select
        j.name as pod_template_name,
        j.uid as pod_template_uid,
        j.path as path,
        j.start_line as start_line,
        j.context_name as context_name,
        j.namespace as namespace,
        j.source_type as source_type,
        c.*
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(j.pod_template_uid, concat(j.path, ':', j.start_line)) as resource,
      case
        when (j.value -> 'command') is null then 'ok'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'alarm'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and not ((l.value) like '%Node%') then 'alarm'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%Node%') then 'ok'
        else 'ok'
      end as status,
      case
        when (j.value -> 'command') is null then j.value ->> 'name' || ' command not defined.'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then  j.value ->> 'name' || ' authorization mode not set.'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and not ((l.value) like '%Node%') then j.value ->> 'name' || ' authorization mode not set to node.'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%Node%') then j.value ->> 'name' || ' authorization mode set to node.'
        else j.value ->> 'name' || ' kube-apiserver not defined.'
      end as reason,
      j.pod_template_name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_pod_template_name as j
      left join container_list as l on j.value ->> 'name' = l.container_name and j.pod_template_name = l.pod_template;
  EOQ
}

query "pod_template_container_argument_authorization_mode_no_always_allow" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        j.name as pod_template
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--authorization-mode=%'
    ), container_name_with_pod_template_name as (
      select
        j.name as pod_template_name,
        j.uid as pod_template_uid,
        j.path as path,
        j.start_line as start_line,
        j.context_name as context_name,
        j.namespace as namespace,
        j.source_type as source_type,
        c.*
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(j.pod_template_uid, concat(j.path, ':', j.start_line)) as resource,
      case
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysAllow%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (j.value -> 'command') is null then j.value ->> 'name' || ' command not defined.'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then  j.value ->> 'name' || ' authorization mode not set.'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%AlwaysAllow%') then j.value ->> 'name' || ' authorization mode set to always allow.'
        else j.value ->> 'name' || ' authorization mode not set to always allow.'
      end as reason,
      j.pod_template_name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_pod_template_name as j
      left join container_list as l on j.value ->> 'name' = l.container_name and j.pod_template_name = l.pod_template;
  EOQ
}

query "pod_template_container_argument_authorization_mode_rbac" {
  sql = <<-EOQ
    with container_list as (
      select
        c ->> 'name' as container_name,
        trim('"' from split_part(co::text, '=', 2)) as value,
        j.name as pod_template
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c,
        jsonb_array_elements(c -> 'command') as co
      where
        (co)::text LIKE '%--authorization-mode=%'
    ), container_name_with_pod_template_name as (
      select
        j.name as pod_template_name,
        j.uid as pod_template_uid,
        j.path as path,
        j.start_line as start_line,
        j.context_name as context_name,
        j.namespace as namespace,
        j.source_type as source_type,
        c.*
      from
        kubernetes_pod_template as j,
        jsonb_array_elements(template -> 'spec' -> 'containers') as c
    )
    select
      coalesce(j.pod_template_uid, concat(j.path, ':', j.start_line)) as resource,
      case
        when (j.value -> 'command') is null then 'ok'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then 'alarm'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and not ((l.value) like '%RBAC%') then 'alarm'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%RBAC%') then 'ok'
        else 'ok'
      end as status,
      case
        when (j.value -> 'command') is null then j.value ->> 'name' || ' command not defined.'
        when (j.value -> 'command') @> '["kube-apiserver"]' and l.container_name is null then  j.value ->> 'name' || ' authorization mode not set.'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and not ((l.value) like '%RBAC%') then j.value ->> 'name' || ' authorization mode not set to RBAC.'
        when l.container_name is not null and (j.value -> 'command') @> '["kube-apiserver"]' and ((l.value) like '%RBAC%') then j.value ->> 'name' || ' authorization mode set to RBAC.'
        else j.value ->> 'name' || ' kube-apiserver not defined.'
      end as reason,
      j.pod_template_name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      container_name_with_pod_template_name as j
      left join container_list as l on j.value ->> 'name' = l.container_name and j.pod_template_name = l.pod_template;
  EOQ
}

query "pod_template_container_no_argument_basic_auth_file" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' like '%--basic-auth-file%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' like '%--basic-auth-file%') then c ->> 'name' || ' basic auth file set.'
        else c ->> 'name' || ' basic auth file not set.'
      end as reason,
      name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_pod_template,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "pod_template_container_encryption_providers_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%"--encryption-provider-config=%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%"--encryption-provider-config=%') then c ->> 'name' || ' encryption providers not configured appropriately.'
        else c ->> 'name' || ' encryption providers configured appropriately.'
      end as reason,
      name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_pod_template,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "pod_template_container_argument_etcd_cafile_configured" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%--etcd-cafile%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' not like '%--etcd-cafile%') then c ->> 'name' || ' etcd cafile not set.'
        else c ->> 'name' || ' etcd cafile set.'
      end as reason,
      name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_pod_template,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "pod_template_container_argument_etcd_certfile_and_keyfile_configured" {
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
          ) then c ->> 'name' || ' etcd certfile and etcd keyfile not set.'
        else c ->> 'name' || ' etcd certfile and etcd keyfile set.'
      end as reason,
      name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_pod_template,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}

query "pod_template_container_no_argument_insecure_bind_address" {
  sql = <<-EOQ
   select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (c -> 'command') is null then 'ok'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' like '%--insecure-bind-address%') then 'alarm'
        else 'ok'
      end as status,
      case
        when (c -> 'command') is null then c ->> 'name' || ' command not defined.'
        when (c -> 'command') @> '["kube-apiserver"]'
          and (c ->> 'command' like '%--insecure-bind-address%') then c ->> 'name' || ' has insecure bind address.'
        else c ->> 'name' || ' has no insecure bind address.'
      end as reason,
      name as pod_template_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_pod_template,
      jsonb_array_elements(template -> 'spec' -> 'containers') as c;
  EOQ
}
