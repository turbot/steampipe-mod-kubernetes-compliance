locals {
  namespace_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Namespace"
  })
}

control "namespace_limit_range_default_cpu_limit" {
  title       = "Namespaces should have default CPU limit in limitRange policy"
  description = "Administrators should use default limitRange policy for CPU limit for each namespace."
  query       = query.namespace_limit_range_default_cpu_limit

  tags = merge(local.namespace_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "namespace_resource_quota_cpu_limit" {
  title       = "Namespaces should be restricted on CPU usage with resourceQuota CPU limit"
  description = "Administrators should use resourceQuota CPU limit to restrict namespaces CPU usage."
  query       = query.namespace_resource_quota_cpu_limit

  tags = merge(local.namespace_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "namespace_limit_range_default_cpu_request" {
  title       = "Namespaces should have default CPU request in limitRange policy"
  description = "Administrators should use default limitRange policy for CPU request for each namespace."
  query       = query.namespace_limit_range_default_cpu_request

  tags = merge(local.namespace_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "namespace_resource_quota_cpu_request" {
  title       = "Namespaces should have resourceQuota CPU request"
  description = "Administrators should use resourceQuota CPU request for each namespace."
  query       = query.namespace_resource_quota_cpu_request

  tags = merge(local.namespace_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "namespace_limit_range_default_memory_limit" {
  title       = "Namespaces should have default memory limit in limitRange policy"
  description = "Administrators should use default limitRange policy for memory limit for each namespace."
  query       = query.namespace_limit_range_default_memory_limit

  tags = merge(local.namespace_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "namespace_resource_quota_memory_limit" {
  title       = "Namespaces should be restricted on memory usage with resourceQuota memory limit"
  description = "Administrators should use resourceQuota memory limit to restrict namespaces memory usage."
  query       = query.namespace_resource_quota_memory_limit

  tags = merge(local.namespace_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "namespace_limit_range_default_memory_request" {
  title       = "Namespaces should have default memory request in limitRange policy"
  description = "Administrators should use default limitRange policy for memory request for each namespace."
  query       = query.namespace_limit_range_default_memory_request

  tags = merge(local.namespace_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "namespace_resource_quota_memory_request" {
  title       = "Namespaces should have resourceQuota memory request"
  description = "Administrators should use resourceQuota memory request for each namespace."
  query       = query.namespace_resource_quota_memory_request

  tags = merge(local.namespace_common_tags, {
    nsa_cisa_v1 = "true"
  })
}
