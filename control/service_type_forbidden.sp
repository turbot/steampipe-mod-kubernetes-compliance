control "service_type_forbidden" {
  title       = "Containers should not exposed through a forbidden service type"
  description = "Containers should not exposed through a forbidden service type such as NodePort or LoadBalancer."
  sql         = query.service_type_forbidden.sql
  tags        = local.extra_checks_tags
}
