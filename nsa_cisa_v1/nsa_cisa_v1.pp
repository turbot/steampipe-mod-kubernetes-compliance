locals {
  nsa_cisa_v1_common_tags = merge(local.kubernetes_compliance_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

benchmark "nsa_cisa_v1" {
  title         = "Kubernetes NSA and CISA Hardening Guidance v1.0"
  documentation = file("./nsa_cisa_v1/docs/nsa_cisa_v1_overview.md")
  children = [
    benchmark.nsa_cisa_v1_pod_security,
    benchmark.nsa_cisa_v1_network_hardening
  ]

  tags = merge(local.nsa_cisa_v1_common_tags, {
    type = "Benchmark"
  })
}
