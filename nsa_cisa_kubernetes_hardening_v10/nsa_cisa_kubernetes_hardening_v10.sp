locals {
  nsa_cisa_kubernetes_hardening_v10_common_tags = {
    nsa_cisa_kubernetes_hardening_v10 = "true"
    plugin                            = "kubernetes"
  }
}

benchmark "nsa_cisa_kubernetes_hardening_v10" {
  title         = "NSA and CISA Kubernetes Hardening Guidance"
  documentation = file("./nsa_cisa_kubernetes_hardening_v10/docs/k8s_overview.md")
  tags          = local.nsa_cisa_kubernetes_hardening_v10_common_tags
  children = [
    benchmark.kubernetes_pod_security,
    benchmark.network_separation_and_hardening
  ]
}
