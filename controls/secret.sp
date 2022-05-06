locals {
  secret_common_tags = {
    plugin = "kubernetes"
  }
}

control "secret_default_namespace_used" {
  title       = "Secret definition should not use default namespace"
  description = "Default namespace should not be used by Secret definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.secret_default_namespace_used.sql
  tags = merge(local.secret_common_tags, {
   cis = "true"
  })
}