locals {
  nsa_cisa_v1_common_tags = {
    nsa_cisa_v1 = "true"
    plugin      = "kubernetes"
  }
}

benchmark "nsa_cisa_v1" {
  title         = "NSA and CISA Kubernetes Hardening Guidance v1.0"
  documentation = file("./nsa_cisa_v1/docs/nsa_cisa_kubernetes_hardening_overview.md")
  tags          = local.nsa_cisa_v1_common_tags
  children = [
    benchmark.nsa_cisa_v1_pod_security,
    benchmark.nsa_cisa_v1_network_hardening
  ]
}
