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
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_role_binding;
  EOQ
}

