control "endpoint_api_serve_on_secure_port" {
  title       = "Kubernetes API should serve on secure port"
  description = "Kubernetes API should serve on port 443 or port 6443, protected by TLS. Once TLS is established, the HTTP request moves to the authentication step. If the request cannot be authenticated, it is rejected with HTTP status code 401."
  sql         = query.endpoint_api_serve_on_secure_port.sql
  tags        = local.nsa_cisa_v1_common_tags
}
