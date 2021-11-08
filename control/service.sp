control "service_type_forbidden" {
  title       = "Containers should not exposed through a forbidden service type"
  description = local.service_type_forbidden_desc
  sql         = query.service_type_forbidden.sql
  tags        = local.extra_checks_tags
}

control "service_default_namesapce_used" {
  title       = "Services should not use default namespace"
  description = "Default namespace should not be used by services. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  sql         = query.service_default_namesapce_used.sql
  tags        = local.extra_checks_tags
}