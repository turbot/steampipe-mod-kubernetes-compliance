query "service_default_namespace_used" {
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
      kubernetes_service;
  EOQ
}

query "service_type_forbidden" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when type in ('NodePort','LoadBalancer') then 'alarm'
        else 'ok'
      end as status,
      case
        when type in ('NodePort','LoadBalancer') then 'Containers using ' || name || ' service exposed through ' || type || ' service type.'
        else 'Containers using ' || name || ' service not exposed through a forbidden service type.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_service;
  EOQ
}

