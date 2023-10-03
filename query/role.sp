query "role_default_namespace_used" {
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
      name as role_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      kubernetes_role;
  EOQ
}

query "role_with_wildcards_used" {
  sql = <<-EOQ
    select
      coalesce(uid, concat(path, ':', start_line)) as resource,
      case
        when rule ->> 'apiGroups' like '%*%'
          or rule ->> 'resources' like '%*%'
          or rule ->> 'verbs' like '%*%' then 'alarm'
        else 'ok'
      end as status,
      case
        when rule ->> 'apiGroups' like '%*%' then name || ' api groups use wildcards.'
        when rule ->> 'resources' like '%*%' then name || ' resources use wildcards.'
        when rule ->> 'verbs' like '%*%' then name || ' actions use wildcards.'
        else name || ' uses no wildcard.'
      end as reason,
      name as role_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_cluster_role,
      jsonb_array_elements(rules) rule
    where
      name not like '%system%'
    group by
      uid,
      status,
      reason,
      role_name,
      path,
      start_line,
      end_line,
      source_type,
      context_name,
      tags,
      _ctx;
  EOQ
}

query "role_with_rbac_escalate_permissions" {
  sql = <<-EOQ
    with role_with_escalate as (
      select
        uid,
         count(*) as num
      from
        kubernetes_cluster_role,
        jsonb_array_elements(rules) rule
      where
        rule -> 'apiGroups' @> '["rbac.authorization.k8s.io"]'
        and (
          rule -> 'resources' @> '["roles"]'
          or rule -> 'resources' @> '["clusterroles"]'
        )
        and rule -> 'verbs'  @> '["escalate"]'
      group by
        uid
      union
      select
        uid,
         count(*) as num
      from
        kubernetes_role,
        jsonb_array_elements(rules) rule
      where
        rule -> 'apiGroups' @> '["rbac.authorization.k8s.io"]'
        and (
          rule -> 'resources' @> '["roles"]'
          or rule -> 'resources' @> '["clusterroles"]'
        )
        and rule -> 'verbs'  @> '["escalate"]'
      group by
        uid
    ), union_role_and_cluster_role as (
      select
        uid,
        path,
        name,
        start_line,
        end_line,
        source_type,
        context_name
      from
        kubernetes_role
      union
      select
        uid,
        path,
        name,
        start_line,
        end_line,
        source_type,
        context_name
      from
        kubernetes_cluster_role
    )
    select
      coalesce(r.uid, concat(r.path, ':', r.start_line)) as resource,
      case
        when e.num > 0 then 'alarm'
        else 'ok'
      end as status,
      case
        when e.num > 0  then name || ' contains ' || e.num || ' RBAC escalate permissions.'
        else name || ' does not contain any RBAC escalate permissions.'
      end as reason,
      name as role_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      union_role_and_cluster_role as r
      left join role_with_escalate as e on e.uid = r.uid
  EOQ
}

query "role_with_bind_cluster_role_bindings" {
  sql = <<-EOQ
    with role_with_escalate as (
      select
        uid,
        count(*) as num
      from
        kubernetes_cluster_role,
        jsonb_array_elements(rules) rule
      where
        rule -> 'apiGroups' @> '["rbac.authorization.k8s.io"]'
        and (
          rule -> 'resources' @> '["rolebindings"]'
          or rule -> 'resources' @> '["clusterrolebindings"]'
        )
        and rule -> 'verbs' @> '["bind"]'
      group by
        uid
      union
      select
        uid,
        count(*) as num
      from
        kubernetes_role,
        jsonb_array_elements(rules) rule
      where
        rule -> 'apiGroups' @> '["rbac.authorization.k8s.io"]'
        and (
          rule -> 'resources' @> '["rolebindings"]'
          or rule -> 'resources' @> '["clusterrolebindings"]'
        )
        and rule -> 'verbs' @> '["bind"]'
      group by
        uid
    ), union_role_and_cluster_role as (
      select
        uid,
        path,
        name,
        start_line,
        end_line,
        source_type,
        context_name
      from
        kubernetes_role
      union
      select
        uid,
        path,
        name,
        start_line,
        end_line,
        source_type,
        context_name
      from
        kubernetes_cluster_role
    )
    select
      coalesce(r.uid, concat(r.path, ':', r.start_line)) as resource,
      case
        when e.num > 0 then 'alarm'
        else 'ok'
      end as status,
      case
        when e.num > 0  then name || ' contains ' || e.num || ' RBAC bind role bindings or cluster role bindings permissions.'
        else name || ' does not contain any RBAC bind role bindings or cluster role bindings permissions.'
      end as reason,
      name as role_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      union_role_and_cluster_role as r
      left join role_with_escalate as e on e.uid = r.uid;
  EOQ
}

query "cluster_role_with_validating_or_mutating_admission_webhook_configurations" {
  sql = <<-EOQ
    with role_with_escalate as (
      select
        uid,
        count(*) as num
      from
        kubernetes_cluster_role,
        jsonb_array_elements(rules) rule
      where
        rule -> 'apiGroups' @> '["admissionregistration.k8s.io"]'
        and (
          rule -> 'resources' @> '["mutatingwebhookconfigurations"]'
          or rule -> 'resources' @> '["validatingwebhookconfigurations"]'
        )
        and rule -> 'verbs' @> '["create", "update", "patch"]'
      group by
        uid
    )
    select
      coalesce(r.uid, concat(r.path, ':', r.start_line)) as resource,
      case
        when e.num > 0 then 'alarm'
        else 'ok'
      end as status,
      case
        when e.num > 0  then name || ' contains ' || e.num || ' RBAC cluster role validating or mutating admission webhook configurations permissions.'
        else name || ' does not contain any bind role bindings or cluster role validating or mutating admission webhook configurations permissions.'
      end as reason,
      name as role_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_cluster_role as r
      left join role_with_escalate as e on e.uid = r.uid;
  EOQ
}

query "role_with_rbac_approve_certificate_signing_requests" {
  sql = <<-EOQ
    with role_with_escalate as (
      select
        uid,
        count(*) as num
      from
        kubernetes_cluster_role,
        jsonb_array_elements(rules) rule
      where
        rule -> 'apiGroups' @> '["certificates.k8s.io"]'
        and
        ((rule -> 'resources' @> '["certificatesigningrequests/approval"]' and rule -> 'verbs' @> '["update", "patch"]')
        or (rule -> 'resources' @> '["signers"]' and rule -> 'verbs' @> '["approve"]'))
      group by
        uid
    )
    select
      coalesce(r.uid, concat(r.path, ':', r.start_line)) as resource,
      case
        when e.num > 0 then 'alarm'
        else 'ok'
      end as status,
      case
        when e.num > 0  then name || ' contains ' || e.num || ' RBAC cluster role grant permissions to approve CertificateSigningRequests.'
        else name || ' does not contains any cluster role granting permissions to approve CertificateSigningRequests.'
      end as reason,
      name as role_name
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_cluster_role as r
      left join role_with_escalate as e on e.uid = r.uid;
  EOQ
}