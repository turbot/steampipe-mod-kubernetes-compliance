query "namespace_limit_range_default_memory_limit" {
  sql = <<-EOQ
    with default_limit_range as (
      select
        namespace,
        l -> 'default' as default_limit,
        l -> 'defaultRequest' as default_request
        from
        kubernetes_limit_range,
        jsonb_array_elements(spec_limits) as l
    )
    select
      coalesce(n.uid, concat(n.path, ':', n.start_line)) as resource,
      case
        when default_limit ->> 'memory' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when default_limit ->> 'memory' is null then n.name || ' do not have LimitRange default memory limit.'
        else n.name || ' has LimitRange default memory limit.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "n.")}
      ${replace(local.common_dimensions_qualifier_source_type_sql, "__QUALIFIER__", "n.")}
    from
      kubernetes_namespace n
      left join default_limit_range r
      on n.name = r.namespace;
  EOQ
}

query "namespace_resource_quota_memory_limit" {
  sql = <<-EOQ
    select
      distinct(coalesce(n.uid, concat(n.path, ':', n.start_line))) as resource,
      case
        when q.spec_hard -> 'limits.memory' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when q.spec_hard -> 'limits.memory' is null then n.name || ' do not have ResourceQuota for memory limit.'
        else n.name || ' have ResourceQuota for memory limit.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "n.")}
      ${replace(local.common_dimensions_qualifier_source_type_sql, "__QUALIFIER__", "n.")}
    from
      kubernetes_namespace n
      left join kubernetes_resource_quota q
      on n.name = q.namespace;
  EOQ
}

query "namespace_resource_quota_cpu_limit" {
  sql = <<-EOQ
    select
      distinct(coalesce(n.uid, concat(n.path, ':', n.start_line))) as resource,
      case
        when q.spec_hard -> 'limits.cpu' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when q.spec_hard -> 'limits.cpu' is null then n.name || ' do not have ResourceQuota for CPU limit.'
        else n.name || ' have ResourceQuota for CPU limit.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "n.")}
      ${replace(local.common_dimensions_qualifier_source_type_sql, "__QUALIFIER__", "n.")}
    from
      kubernetes_namespace n
      left join kubernetes_resource_quota q
      on n.name = q.namespace;
  EOQ
}

query "namespace_limit_range_default_memory_request" {
  sql = <<-EOQ
    with default_limit_range as (
      select
        namespace,
        l -> 'default' as default_limit,
        l -> 'defaultRequest' as default_request
        from
        kubernetes_limit_range,
        jsonb_array_elements(spec_limits) as l
    )
    select
      coalesce(n.uid, concat(n.path, ':', n.start_line)) as resource,
      case
        when default_request ->> 'memory' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when default_request ->> 'memory' is null then n.name || ' do not have LimitRange default memory request.'
        else n.name || ' has LimitRange default memory request.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "n.")}
      ${replace(local.common_dimensions_qualifier_source_type_sql, "__QUALIFIER__", "n.")}
    from
      kubernetes_namespace n
      left join default_limit_range r
      on n.name = r.namespace;
  EOQ
}

query "namespace_limit_range_default_cpu_request" {
  sql = <<-EOQ
    with default_limit_range as (
      select
        namespace,
        l -> 'default' as default_limit,
        l -> 'defaultRequest' as default_request
      from
        kubernetes_limit_range,
        jsonb_array_elements(spec_limits) as l
    )
    select
      coalesce(n.uid, concat(n.path, ':', n.start_line)) as resource,
      case
        when default_request ->> 'cpu' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when default_request ->> 'cpu' is null then n.name || ' do not have LimitRange default CPU request.'
        else n.name || ' has LimitRange default CPU request.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "n.")}
      ${replace(local.common_dimensions_qualifier_source_type_sql, "__QUALIFIER__", "n.")}
    from
      kubernetes_namespace n
      left join default_limit_range r
      on n.name = r.namespace;
  EOQ
}

query "namespace_resource_quota_memory_request" {
  sql = <<-EOQ
    select
      distinct(coalesce(n.uid, concat(n.path, ':', n.start_line))) as resource,
      case
        when q.spec_hard -> 'requests.memory' is null and q.spec_hard -> 'memory' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when q.spec_hard -> 'requests.memory' is null and q.spec_hard -> 'memory' is null then n.name || ' do not have ResourceQuota for memory request.'
        else n.name || ' have ResourceQuota for memory request.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "n.")}
      ${replace(local.common_dimensions_qualifier_source_type_sql, "__QUALIFIER__", "n.")}
    from
      kubernetes_namespace n
      left join kubernetes_resource_quota q
      on n.name = q.namespace;
  EOQ
}

query "namespace_limit_range_default_cpu_limit" {
  sql = <<-EOQ
    with default_limit_range as (
      select
        namespace,
        l -> 'default' as default_limit,
        l -> 'defaultRequest' as default_request
        from
        kubernetes_limit_range,
        jsonb_array_elements(spec_limits) as l
    )
    select
      coalesce(n.uid, concat(n.path, ':', n.start_line)) as resource,
      case
        when default_limit ->> 'cpu' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when default_limit ->> 'cpu' is null then n.name || ' do not have LimitRange default CPU limit.'
        else n.name || ' has LimitRange default CPU limit.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "n.")}
      ${replace(local.common_dimensions_qualifier_source_type_sql, "__QUALIFIER__", "n.")}
    from
      kubernetes_namespace n
      left join default_limit_range r
      on n.name = r.namespace;
  EOQ
}

query "namespace_resource_quota_cpu_request" {
  sql = <<-EOQ
    select
      distinct(coalesce(n.uid, concat(n.path, ':', n.start_line))) as resource,
      case
        when q.spec_hard -> 'requests.cpu' is null and q.spec_hard -> 'cpu' is null then 'alarm'
        else 'ok'
      end as status,
      case
        when q.spec_hard -> 'requests.cpu' is null and q.spec_hard -> 'cpu' is null then n.name || ' do not have ResourceQuota for CPU request.'
        else n.name || ' have ResourceQuota for CPU request.'
      end as reason
      ${replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "n.")}
      ${replace(local.common_dimensions_qualifier_source_type_sql, "__QUALIFIER__", "n.")}
    from
      kubernetes_namespace n
      left join kubernetes_resource_quota q
      on n.name = q.namespace;
  EOQ
}

