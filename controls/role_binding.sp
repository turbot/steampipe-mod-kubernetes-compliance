locals {
  role_binding_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/RoleBinding"
  })
}

control "role_binding_default_namespace_used" {
  title       = "RoleBinding definition should not use default namespace"
  description = "Default namespace should not be used by RoleBinding definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.role_binding_default_namespace_used

  tags = merge(local.role_binding_common_tags, {
    cis = "true"
  })
}

control "role_binding_default_service_account_binding_not_active" {
  title       = "RoleBinding subjects should not actively use default service accounts"
  description = "Default service accounts should not be used by RoleBinding subjects."
  query       = query.role_binding_default_service_account_binding_not_active

  tags = local.role_binding_common_tags
}
