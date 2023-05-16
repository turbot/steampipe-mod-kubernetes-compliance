query "role_default_namespace_used" {
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
      name as role_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_role;
  EOQ
}

query "role_wildcards_used" {
  sql = <<-EOQ
    select
      -- Required Columns
      uid as resource,
      case
        when rule ->> 'apiGroups' like '%*%'
          or rule ->> 'resources' like '%*%'
          or rule ->> 'verbs' like '%*%' then 'alarm'
        else 'ok'
      end as status,
      case
        when rule ->> 'apiGroups' like '%*%' then name || 'api groups uses wildcard.'
        when rule ->> 'resources' like '%*%' then name || 'resources uses wildcard.'
        when rule ->> 'verbs' like '%*%' then name || 'actions uses wildcard.'
        else name || 'uses no wildcards.'
      end as reason,
      -- Additional Dimensions
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
      context_name;
  EOQ
}