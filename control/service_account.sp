control "service_account_token_disabled" {
  title       = "Automatic mapping of the service account tokens should be disabled in service account"
  description = local.service_account_token_disabled_desc
  sql         = query.service_account_token_disabled.sql
  tags        = local.nsa_cisa_v1_common_tags
}
