query "role_binding_default_namespace_used" {
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
      name as role_binding_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_role_binding;
  EOQ
}

query "role_binding_default_service_account_binding_not_active" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when (subject ->> 'kind') = 'ServiceAccount' and (subject ->> 'name') = 'default' then 'alarm'
        else 'ok'
      end as status,
      case
        when (subject ->> 'kind' = 'ServiceAccount') and (subject ->> 'name' = 'default') then name || ' default service accounts active.'
        else name || ' default service accounts not active.'
      end as reason,
      name as role_binding_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_role_binding,
      jsonb_array_elements(subjects) as subject;
  EOQ
}
