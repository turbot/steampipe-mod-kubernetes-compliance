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
