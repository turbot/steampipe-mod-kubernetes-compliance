query "ingress_default_namespace_used" {
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
      name as ingress_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_ingress;
  EOQ
}

query "ingress_nginx_annotations_snippets_alias_not_used" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case when a.key like '%snippet%' and a.value like '%alias%' then 'alarm'
        else 'ok'
      end as status,
      case
        when a.key like '%snippet%' and a.value like '%alias%' then a.key || ' annotation snippet contains alias statements'
        else a.key || ' annotation snippet not containing alias statements'
      end as reason,
      name as ingress_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_ingress,
      jsonb_each_text(annotations) as a
  EOQ
}

query "ingress_nginx_annotations_all_snippets_not_used" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case when a.key like '%snippet%' then 'alarm'
        else 'ok'
      end as status,
      case
        when a.key like '%snippet%' then a.key || ' annotation snippet used'
        else a.key || ' annotation snippet not used'
      end as reason,
      name as ingress_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_ingress,
      jsonb_each_text(annotations) as a
  EOQ
}

query "ingress_nginx_annotations_snippets_lua_code_not_used" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case when a.key like '%snippet%' and a.value ~ '(lua_|_lua|_lua_|kubernetes\.io)' then 'alarm'
        else 'ok'
      end as status,
      case
        when a.key like '%snippet%' and a.value ~ '(lua_|_lua|_lua_|kubernetes\.io)' then a.key || ' annotation snippet contains lua code execution'
        else a.key || ' annotation snippet not containing lua code execution'
      end as reason,
      name as ingress_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_ingress,
      jsonb_each_text(annotations) as a
  EOQ
}