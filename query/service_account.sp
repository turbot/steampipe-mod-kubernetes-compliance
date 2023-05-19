query "service_account_token_disabled" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when automount_service_account_token then 'alarm'
        else 'ok'
      end as status,
      case
        when automount_service_account_token then name || ' service account token will be automatically mounted.'
        else name || ' service account token will not be automatically mounted.'
      end as reason,
      name as service_account_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_service_account;
  EOQ
}

query "service_account_default_namespace_used" {
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
      name as service_account_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_source_type_sql}
    from
      kubernetes_service_account;
  EOQ
}

