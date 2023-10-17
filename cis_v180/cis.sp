locals {
  cis_v180_common_tags = merge(local.kubernetes_compliance_common_tags, {
    cis                = "true"
    cis_version        = "v1.8.0"
    kubernetes_version = "v1.25"
  })
}

benchmark "cis_v180" {
  title         = "CIS v1.8.0"
  description   = "CIS v1.8.0 benchmark provides prescriptive guidance for establishing a secure configuration posture for Kubernetes v1.25."
  documentation = file("./cis_v180/docs/cis_v180_overview.md")
  children = [
    benchmark.cis_v180_1,
    benchmark.cis_v180_2,
    benchmark.cis_v180_4,
    benchmark.cis_v180_5
  ]

  tags = merge(local.cis_v180_common_tags, {
    type = "Benchmark"
  })
}

