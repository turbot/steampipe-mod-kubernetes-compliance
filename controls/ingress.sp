locals {
  ingress_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Ingress"
  })
}

control "ingress_default_namespace_used" {
  title       = "Ingress definition should not use default namespace"
  description = "Default namespace should not be used by Ingress definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.ingress_default_namespace_used

  tags = merge(local.ingress_common_tags, {
    cis = "true"
  })
}

control "ingress_nginx_annotations_snippets_alias_not_used" {
  title       = "Ingress definition should not have NGINX ingress annotation snippets containing alias statements"
  description = "This check ensures that the NGINX ingress annotation snippets in the Ingress does not contain alias statements."
  query       = query.ingress_nginx_annotations_snippets_alias_not_used

  tags = local.ingress_common_tags
}

control "ingress_nginx_annotations_all_snippets_not_used" {
  title       = "Ingress definition should not allow any usage of NGINX ingress annotation snippets"
  description = "This check ensures that the NGINX ingress annotation snippets usage is not allowed in the Ingress."
  query       = query.ingress_nginx_annotations_all_snippets_not_used

  tags = local.ingress_common_tags
}

control "ingress_nginx_annotations_snippets_lua_code_not_used" {
  title       = "Ingress definition should not have NGINX ingress annotation snippets containing lua code snippets"
  description = "This check ensures that the NGINX ingress annotation snippets in the Ingress does not contain lua code snippets."
  query       = query.ingress_nginx_annotations_snippets_lua_code_not_used

  tags = local.ingress_common_tags
}