locals {
  all_controls_cluster_role_binding_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/ClusterRoleBinding"
  })
}

benchmark "all_controls_cluster_role_binding" {
  title       = "Cluster Role Binding"
  description = "This section contains recommendations for configuring Cluster Role Binding resources."
  children = [
    control.cluster_role_binding_default_service_account_binding_not_active
  ]

  tags = merge(local.all_controls_cluster_role_binding_common_tags, {
    type = "Benchmark"
  })
}
