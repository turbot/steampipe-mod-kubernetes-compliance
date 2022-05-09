locals {
  service_account_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/ServiceAccount"
  })
}

control "service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled in service account"
  description = local.service_account_token_disabled_desc
  sql         = query.service_account_token_disabled.sql

  tags = merge(local.service_account_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "service_account_default_namespace_used" {
  title       = "ServiceAccount definition should not use default namespace"
  description = "Default namespace should not be used by ServiceAccount definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.service_account_default_namespace_used.sql

  tags = merge(local.service_account_common_tags, {
    cis = "true"
  })
}
