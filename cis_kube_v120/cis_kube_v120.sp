locals {
  cis_kube_v120_common_tags = merge(local.kubernetes_compliance_common_tags, {
    cis                = "true"
    kubernetes_version = "v1.20"
  })
}

benchmark "cis_kube_v120" {
  title       = "CIS Kubernetes v1.20"
  description = "CIS Kubernetes v1.20 benchmark provides prescriptive guidance for establishing a secure configuration posture for Kubernetes 1.19 - 1.20."
  children = [
    benchmark.cis_kube_v120_v100
  ]

  tags = merge(local.cis_kube_v120_common_tags, {
    type = "Benchmark"
  })
}
