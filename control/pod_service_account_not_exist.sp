control "pod_service_account_not_exist" {
  title       = "Pods should not refer to an non existing service account"
  description = "Pods should not refer a service account which is not available."
  sql         = query.pod_service_account_not_exist.sql
  tags        = local.extra_checks_tags
}
