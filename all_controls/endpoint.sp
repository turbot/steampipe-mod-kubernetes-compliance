locals {
  all_controls_endpoint_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Endpoint"
  })
}

benchmark "all_controls_endpoint" {
  title       = "Endpoint"
  description = "This section contains recommendations for configuring Endpoint resources."
  children = [
    control.endpoint_api_serve_on_secure_port
  ]

  tags = merge(local.all_controls_endpoint_common_tags, {
    type = "Benchmark"
  })
}
