locals {
  all_controls_namespace_common_tags = merge(local.all_controls_common_tags, {
  })
}

benchmark "all_controls_namespace" {
  title       = "Namespace"
  description = "This section contains recommendations for configuring Namespace resources."
  children = [
    control.namespace_limit_range_default_cpu_limit,
    control.namespace_limit_range_default_cpu_request,
    control.namespace_limit_range_default_memory_limit,
    control.namespace_limit_range_default_memory_request,
    control.namespace_resource_quota_cpu_limit,
    control.namespace_resource_quota_cpu_request,
    control.namespace_resource_quota_memory_limit,
    control.namespace_resource_quota_memory_request
  ]

  tags = merge(local.all_controls_namespace_common_tags, {
    type = "Benchmark"
  })
}
