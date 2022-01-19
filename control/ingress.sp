locals {
  ingress_common_tags = {
    plugin = "kubernetes"
  }
}

control "ingress_default_namesapce_used" {
  title       = "Ingress definition should not use default namespace"
  description = "Default namespace should not be used by Ingress definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.ingress_default_namesapce_used.sql
  tags = merge(local.ingress_common_tags, {
   cis = "true"
  })
}