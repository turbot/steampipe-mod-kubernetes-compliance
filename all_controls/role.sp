locals {
  all_controls_role_common_tags = merge(local.all_controls_common_tags, {
  })
}

benchmark "all_controls_role" {
  title       = "Role"
  description = "This section contains recommendations for configuring Role resources."
  children = [
    control.role_default_namespace_used,
    control.role_with_wildcards_used
  ]

  tags = merge(local.all_controls_role_common_tags, {
    type = "Benchmark"
  })
}
