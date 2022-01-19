locals {
  role_binding_common_tags = {
    plugin = "kubernetes"
  }
}

control "role_binding_default_namesapce_used" {
  title       = "RoleBinding definition should not use default namespace"
  description = "Default namespace should not be used by RoleBinding definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.role_binding_default_namesapce_used.sql
  tags = merge(local.role_binding_common_tags, {
   cis = "true"
  })
}