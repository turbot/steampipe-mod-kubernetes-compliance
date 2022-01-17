locals {
  service_account_common_tags = {
    plugin = "kubernetes"
  }
}

control "service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled in service account"
  description = local.service_account_token_disabled_desc
  sql         = query.service_account_token_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "service_account_default_namesapce_used" {
  title       = "ServiceAccount definition should not use default namespace"
  description = "Default namespace should not be used by ServiceAccount definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.service_account_default_namesapce_used.sql
  tags = merge(local.service_account_common_tags, {
   cis = "true"
  })
}