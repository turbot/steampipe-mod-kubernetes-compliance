locals {
  role_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Role"
  })
}

control "role_default_namespace_used" {
  title       = "Role definition should not use default namespace"
  description = "Default namespace should not be used by Role definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.role_default_namespace_used

  tags = merge(local.role_common_tags, {
    cis = "true"
  })
}
