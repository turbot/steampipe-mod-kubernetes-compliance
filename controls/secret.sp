locals {
  secret_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Secret"
  })
}

control "secret_default_namespace_used" {
  title       = "Secret definition should not use default namespace"
  description = "Default namespace should not be used by Secret definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.secret_default_namespace_used.sql

  tags = merge(local.secret_common_tags, {
    cis = "true"
  })
}
