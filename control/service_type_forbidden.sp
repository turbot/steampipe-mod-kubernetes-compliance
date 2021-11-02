control "service_type_forbidden" {
  title       = "Containers should not exposed through a forbidden service type"
  description = "Containers should not exposed through a forbidden service type"
  sql         = query.service_type_forbidden.sql
  tags        = local.best_practices_tags
}
