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

control "role_with_rbac_escalate_permissions" {
  title       = "ClusterRoles permissions to escalate Roles or ClusterRoles should be minimized."
  description = "Minimize the permissions granted to ClusterRoles to escalate Roles or ClusterRoles. It is recommended to follow the principle of least privilege to enhance security."
  query       = query.role_with_rbac_escalate_permissions

  tags = merge(local.role_common_tags, {
    cis = "true"
  })
}

control "role_with_bind_cluster_role_bindings" {
  title       = "ClusterRoles permissions to bind RoleBindings or ClusterRoleBindings should be minimized."
  description = "Minimize the permissions granted to ind RoleBindings or ClusterRoleBinding. It is recommended to follow the principle of least privilege to enhance security."
  query       = query.role_with_bind_cluster_role_bindings

  tags = merge(local.role_common_tags, {
    cis = "true"
  })
}

control "cluster_role_with_validating_or_mutating_admission_webhook_configurations" {
  title       = "ClusterRoles permissions for managing the configuration of validation or mutation admission webhooks should be minimized."
  description = "Minimize the permissions granted to ClusterRoles for managing admission webhooks. It is recommended to follow the principle of least privilege to enhance security."
  query       = query.cluster_role_with_validating_or_mutating_admission_webhook_configurations

  tags = merge(local.role_common_tags, {
    cis = "true"
  })
}

control "role_with_rbac_approve_certificate_signing_requests" {
  title       = "ClusterRoles permissions for approving CertificateSigningRequests."
  description = "Minimize the permissions granted to ClusterRoles for approving CertificateSigningRequests. It is recommended to follow the principle of least privilege to enhance security."
  query       = query.role_with_rbac_approve_certificate_signing_requests

  tags = local.role_common_tags
}
