query "endpoint_api_serve_on_secure_port" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when p ->> 'name' = 'https' and (p ->> 'port' = '443' or p ->> 'port' = '6443') then 'ok'
        else 'alarm'
      end as status,
      case
        when p ->> 'name' = 'https' and (p ->> 'port' = '443' or p ->> 'port' = '6443') then name || ' Kubernetes API serving on secure port.'
        else name || ' Kubernetes API not serving on secure port.'
      end as reason,
      name as endpoint_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_endpoint,
      jsonb_array_elements(subsets) as s,
      jsonb_array_elements(s -> 'ports') as p
      where name = 'kubernetes';
  EOQ
}

