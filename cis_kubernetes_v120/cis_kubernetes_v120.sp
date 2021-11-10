locals {
  cis_kubernetes_v120_common_tags = {
    cis                = "true"
    kubernetes_version = "v1.20"
    plugin             = "kubernetes"
  }
}

benchmark "cis_kubernetes_v120" {
  title         = "CIS Kubernetes v1.20"
  description   = "CIS Kubernetes v1.20 benchmark provides prescriptive guidance for establishing a secure configuration posture for Kubernetes 1.19 - 1.20."
  tags          = local.cis_kubernetes_v120_common_tags
  children = [
    benchmark.cis_v100  
  ]
}
