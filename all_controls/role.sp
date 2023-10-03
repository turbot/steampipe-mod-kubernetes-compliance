locals {
  all_controls_role_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Role"
  })
}

benchmark "all_controls_role" {
  title       = "Role"
  description = "This section contains recommendations for configuring Role resources."
  children = [
    control.role_default_namespace_used,
    control.role_with_wildcards_used,
    control.role_with_rbac_approve_certificate_signing_requests,
    control.role_with_rbac_escalate_permissions,
    control.role_with_bind_cluster_role_bindings,
    control.cluster_role_with_validating_or_mutating_admission_webhook_configurations,
  ]

  tags = merge(local.all_controls_role_common_tags, {
    type = "Benchmark"
  })
}
