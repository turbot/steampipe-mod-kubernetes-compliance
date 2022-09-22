locals {
  cert_manager_common_tags = merge(local.kubernetes_compliance_common_tags, {
    cert_manager = "true"
  })
}

benchmark "cert_manager_best_practices" {
  title = "cert-manager"
  // documentation = file("./nsa_cisa_v1/docs/nsa_cisa_v1_overview.md")
  children = [
    control.cert_manager_certificate_with_no_expiry
  ]

  tags = merge(local.cert_manager_common_tags, {
    type = "Benchmark"
  })
}

control "cert_manager_certificate_with_no_expiry" {
  title       = "Certificate with no expiry"
  description = "Certificate with no expiry."
  query       = query.cert_manager_certificate_with_no_expiry
}
