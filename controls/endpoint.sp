locals {
  endpoint_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Endpoint"
  })
}

control "endpoint_api_serve_on_secure_port" {
  title       = "Kubernetes API should serve on secure port"
  description = "Kubernetes API should serve on port 443 or port 6443, protected by TLS. Once TLS is established, the HTTP request moves to the authentication step. If the request cannot be authenticated, it is rejected with HTTP status code 401."
  query = query.endpoint_api_serve_on_secure_port

  tags = merge(local.endpoint_common_tags, {
    nsa_cisa_v1 = "true"
  })
}
