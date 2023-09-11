query "role_default_namespace_used" {
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
      name as role_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_role;
  EOQ
}

query "role_with_wildcards_used" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when rule ->> 'apiGroups' like '%*%'
          or rule ->> 'resources' like '%*%'
          or rule ->> 'verbs' like '%*%' then 'alarm'
        else 'ok'
      end as status,
      case
        when rule ->> 'apiGroups' like '%*%' then name || ' api groups use wildcards.'
        when rule ->> 'resources' like '%*%' then name || ' resources use wildcards.'
        when rule ->> 'verbs' like '%*%' then name || ' actions use wildcards.'
        else name || ' uses no wildcard.'
      end as reason,
      name as role_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_cluster_role,
      jsonb_array_elements(rules) rule
    where
      name not like '%system%'
    group by
      uid,
      status,
      reason,
      role_name,
      path,
      start_line,
      end_line,
      source_type,
      context_name,
      tags,
      _ctx;
  EOQ
}
