locals {
  cluster_role_binding_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/ClusterRoleBinding"
  })
}

control "cluster_role_binding_default_service_account_binding_not_active" {
  title       = "ClusterRoleBinding subjects should not actively use default service accounts"
  description = "Default service accounts should not be used by ClusterRoleBinding subjects."
  query       = query.cluster_role_binding_default_service_account_binding_not_active

  tags = local.cluster_role_binding_common_tags
}
