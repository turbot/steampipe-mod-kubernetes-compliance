locals {
  nsa_cisa_kubernetes_hardening_v10_common_tags = {
    nsa_cisa_kubernetes_hardening_v10 = "true"
    plugin                            = "kubernetes"
  }
}

benchmark "nsa_cisa_kubernetes_hardening_v10" {
  title       = "Kubernetes Hardening Guidance by NSA and CISA"
  description = "Cybersecurity Technical Report for Kubernetes hardening. The hardening guidance detailed in this report is designed to help organizations handle associated risks and enjoy the benefits of using this technology."
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
  children = [
    benchmark.kubernetes_pod_security,
    benchmark.network_separation_and_hardening
  ]
}