benchmark "kubernetes_pod_security" {
  title    = "Kubernetes Pod security"
  children = [
    control.k8s_non_root_container
  ]
  tags     = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_non_root_container" {
  title       = "Containers should not be deployed with root privileges"
  description = "Use containers built to run applications as non-root users."
  sql         = query.k8s_non_root_container.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}