query "service_default_namespace_used" {
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
      coalesce(uid, concat(path, ':', start_line)) as resource,
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

query "service_no_tiller_service" {
  sql = <<-EOQ
    with tiller_service as (
      select
        distinct uid
      from
        kubernetes_service
      where
        (select 'tiller' ilike any (select jsonb_object_keys(tags)::text))
        or (select 'tiller' ilike any (select jsonb_object_keys(selector)::text))
    )
    select
      coalesce(s.uid, concat(s.path, ':', s.start_line)) as resource,
      case
        when t.uid is not null then 'alarm'
        else 'ok'
      end as status,
      case
        when t.uid is not null then name || ' using tiller service.'
        else  name || ' not using tiller service.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_service as s
      left join tiller_service as t on t.uid = s.uid;
  EOQ
}

query "service_no_tiller_deployed" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      name,
      case
        when labels ->> 'app' = 'helm' or labels ->> 'name' = 'tiller' then 'alarm'
        else 'ok'
      end as status,
      case
        when labels ->> 'app' = 'helm' or labels ->> 'name' = 'tiller' then name || ' has tiller deployed.'
        else  name || ' tiller not deployed.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_service;
  EOQ
}