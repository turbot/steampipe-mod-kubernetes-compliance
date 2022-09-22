locals {
  cert_manager_common_tags = merge(local.kubernetes_compliance_common_tags, {
    cert_manager = "true"
  })
}

benchmark "cert_manager_best_practices" {
  title = "cert-manager"
  // documentation = file("./nsa_cisa_v1/docs/nsa_cisa_v1_overview.md")
  children = [
    control.cert_manager_certificate_with_no_expiration_date,
    control.cert_manager_certificate_expired
  ]

  tags = merge(local.cert_manager_common_tags, {
    type = "Benchmark"
  })
}

control "cert_manager_certificate_with_no_expiration_date" {
  title       = "Certificate with no expiration date"
  description = "Certificate with no expiration date."
  query       = query.cert_manager_certificate_with_no_expiration_date
}

control "cert_manager_certificate_expired" {
  title       = "Certificate expired"
  description = "Certificate expired."
  query       = query.cert_manager_certificate_expired
}
