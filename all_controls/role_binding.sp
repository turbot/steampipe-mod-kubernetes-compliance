locals {
  all_controls_role_binding_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/RoleBinding"
  })
}

benchmark "all_controls_role_binding" {
  title       = "Role Binding"
  description = "This section contains recommendations for configuring Role Binding resources."
  children = [
    control.role_binding_default_namespace_used,
    control.role_binding_default_service_account_binding_not_active,
  ]

  tags = merge(local.all_controls_role_binding_common_tags, {
    type = "Benchmark"
  })
}
