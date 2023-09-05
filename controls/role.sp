locals {
  role_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Role"
  })
}

control "role_default_namespace_used" {
  title       = "Role definition should not use default namespace"
  description = "Default namespace should not be used by Role definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.role_default_namespace_used

  tags = merge(local.role_common_tags, {
    cis = "true"
  })
}

control "role_with_wildcards_used" {
  title       = "Minimize wildcard use in Roles and ClusterRoles"
  description = "Kubernetes Roles and ClusterRoles provide access to resources based on sets of objects and actions that can be taken on those objects. It is possible to set either of these to be the wildcard \"*\" which matches all items. Use of wildcards is not optimal from a security perspective as it may allow for inadvertent access to be granted when new resources are added to the Kubernetes API either as CRDs or in later versions of the product."
  query       = query.role_with_wildcards_used

  tags = merge(local.role_common_tags, {
    cis = "true"
  })
}
