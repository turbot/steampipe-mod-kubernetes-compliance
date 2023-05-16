query "config_map_default_namespace_used" {
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
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_config_map;
  EOQ
}

