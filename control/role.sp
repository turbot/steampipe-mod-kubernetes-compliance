locals {
  role_common_tags = {
    plugin = "kubernetes"
  }
}

control "role_default_namespace_used" {
  title       = "Role definition should not use default namespace"
  description = "Default namespace should not be used by Role definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.role_default_namespace_used.sql
  tags = merge(local.role_common_tags, {
   cis = "true"
  })
}