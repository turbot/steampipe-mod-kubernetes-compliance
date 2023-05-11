locals {
  cis_v170_common_tags = merge(local.kubernetes_compliance_common_tags, {
    cis         = "true"
    cis_version = "v1.7.0"
  })
}

benchmark "cis_v170" {
  title         = "v1.7.0"
  documentation = file("./cis_v170/docs/cis_v170_overview.md")
  children = [
    benchmark.cis_v170_5
  ]

  tags = merge(local.cis_v170_common_tags, {
    type = "Benchmark"
  })
}
