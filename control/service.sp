control "service_type_forbidden" {
  title       = "Containers should not exposed through a forbidden service type"
  description = local.service_type_forbidden_desc
  sql         = query.service_type_forbidden.sql
  tags        = local.extra_checks_tags
}
