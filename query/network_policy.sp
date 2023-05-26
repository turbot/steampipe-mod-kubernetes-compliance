query "network_policy_default_dont_allow_ingress" {
  sql = <<-EOQ
    with default_allows_all_ingress_count as (
      select
        namespace,
        name,
        uid,
        context_name,
        _ctx,
        tags,
        p.path,
        p.start_line,
        p.source_type,
        -- Get the count of default allow Ingress policy
        count(*) filter (where rule = '{}') as num_allow_all_rules
      from
        kubernetes_network_policy p
        left join jsonb_array_elements(ingress) as rule on true
      group by
        namespace,
        name,
        uid,
        context_name,
        rule,
        policy_types,
        tags,
        _ctx,
        p.path,
        p.start_line,
        p.source_type
    )
    select
      coalesce(uid, concat(p.path, ':', p.start_line)) as resource,
      case
        when num_allow_all_rules > 0 then 'alarm'
        else 'ok'
      end as status,
      case
        when num_allow_all_rules > 0 then name || ' allows all ingress'
        else name || ' does not allow all ingress'
      end as reason,
      name as network_policy_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      default_allows_all_ingress_count p;
  EOQ
}

query "network_policy_default_dont_allow_egress" {
  sql = <<-EOQ
    with default_allows_all_egress_count as (
      select
        namespace,
        name,
        uid,
        context_name,
        tags,
        _ctx,
        p.path,
        p.start_line,
        p.source_type,
        -- Get the count of default allow Egress policy
        count(*) filter (where rule = '{}') as num_allow_all_rules
      from
        kubernetes_network_policy p
        left join jsonb_array_elements(egress) as rule on true
      group by
        namespace,
        name,
        uid,
        context_name,
        rule,
        policy_types,
        tags,
        _ctx,
        p.path,
        p.start_line,
        p.source_type
    )
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when num_allow_all_rules > 0 then 'alarm'
        else 'ok'
      end as status,
      case
        when num_allow_all_rules > 0 then name || ' allows all egress'
        else name || ' does not allow all egress'
      end as reason,
      name as network_policy_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      default_allows_all_egress_count;
  EOQ
}

query "network_policy_default_deny_ingress" {
  sql = <<-EOQ
    with default_deny_ingress_count as (
      select
        ns.uid,
        ns.name as namespace,
        ns.context_name,
        count(pol.*) as num_netpol,
        ns.tags,
        ns._ctx,
        ns.path,
        ns.start_line,
        ns.source_type,
        -- Get the count of default deny Ingress policy assoicated to each namespace
        count(*) filter (where policy_types @> '["Ingress"]' and pod_selector = '{}' and ingress is null) AS num_default_deny
      from kubernetes_namespace as ns
      left join kubernetes_network_policy as pol on pol.namespace = ns.name and pol.source_type = ns.source_type
      group by
        ns.name,
        ns.uid,
        ns.context_name,
        ns.tags,
        ns._ctx,
        ns.path,
        ns.start_line,
        ns.source_type
    )
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when num_default_deny > 0  then 'ok'
        else 'alarm'
      end as status,
      namespace || ' has ' || num_default_deny || ' default deny ingress policies.' as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      default_deny_ingress_count;
  EOQ
}

query "network_policy_default_deny_egress" {
  sql = <<-EOQ
    with default_deny_egress_count as (
      select
        ns.uid,
        ns.name as namespace,
        ns.context_name,
        ns._ctx,
        count(pol.*) as num_netpol,
        ns.tags,
        ns.path,
        ns.start_line,
        ns.source_type,
        -- Get the count of default deny Egress policy assoicated to each namespace
        COUNT(*) FILTER (where policy_types @> '["Egress"]' and pod_selector = '{}' and egress is null) AS num_default_deny
      from kubernetes_namespace as ns
      left join kubernetes_network_policy as pol on pol.namespace = ns.name and pol.source_type = ns.source_type
      group by
        ns.name,
        ns.uid,
        ns.context_name,
        ns.tags,
        ns._ctx,
        ns.path,
        ns.start_line,
        ns.source_type
    )
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when num_default_deny > 0  then 'ok'
        else 'alarm'
      end as status,
      namespace || ' has ' || num_default_deny || ' default deny egress policies.' as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      default_deny_egress_count;
  EOQ
}

