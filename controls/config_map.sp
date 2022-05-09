locals {
  config_map_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/ConfigMap"
  })
}

control "config_map_default_namespace_used" {
  title       = "ConfigMap definition should not use default namespace"
  description = "Default namespace should not be used by ConfigMap definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.config_map_default_namespace_used.sql

  tags = merge(local.config_map_common_tags, {
    cis = "true"
  })
}
