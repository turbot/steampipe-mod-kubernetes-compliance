benchmark "kubernetes_pod_security" {
  title    = "Kubernetes Pod security"
  children = [
    control.k8s_non_root_container,
    control.k8s_allow_elevation_root,
    control.k8s_allowed_host_paths,
    control.k8s_host_network_access,
    control.k8s_hostpid_hostipc_namesapce_privilege,
    control.k8s_immutable_container_filesystem,
    control.k8s_pod_service_account_token,
    control.k8s_privileged_container,
    control.k8s_security_services_hardening
  ]
  tags     = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_non_root_container" {
  title       = "Containers should not be deployed with root privileges"
  description = "Use containers built to run applications as non-root users."
  sql         = query.k8s_non_root_container.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_allow_elevation_root" {
  title       = "Container should not have privilege escalation"
  description = "Container should not have privilege escalation."
  sql         = query.k8s_allow_elevation_root.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_allowed_host_paths" {
  title       = "Containers should use specified host paths"
  description = "Containers should use specified host paths.."
  sql         = query.k8s_allowed_host_paths.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_host_network_access" {
  title       = "Host network access should be disabled for the containers"
  description = "Host network access should be disabled for the containers."
  sql         = query.k8s_host_network_access.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_hostpid_hostipc_namesapce_privilege" {
  title       = "Containers should not share host process namespaces"
  description = "Containers should not share host process namespaces."
  sql         = query.k8s_hostpid_hostipc_namesapce_privilege.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_immutable_container_filesystem" {
  title       = "Containers should always run with a read only root file system"
  description = "Containers should always run with a read only root file system."
  sql         = query.k8s_immutable_container_filesystem.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_pod_service_account_token" {
  title       = "Automatic mapping of the service account tokens should be disabled in pod service account"
  description = "Automatic mapping of the service account tokens should be disabled in pod service account."
  sql         = query.k8s_pod_service_account_token.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_privileged_container" {
  title       = "Containers Should not have privileged access"
  description = "Containers Should not have privileged access."
  sql         = query.k8s_privileged_container.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_security_services_hardening" {
  title       = "Container applications should use security services such as SELinux or AppArmor or Seccomp"
  description = "Container applications should use security services such as SELinux or AppArmor or Seccomp."
  sql         = query.k8s_security_services_hardening.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}