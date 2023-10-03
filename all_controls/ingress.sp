locals {
  all_controls_ingress_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/Ingress"
  })
}

benchmark "all_controls_ingress" {
  title       = "Ingress"
  description = "This section contains recommendations for configuring Ingress resources."
  children = [
    control.ingress_default_namespace_used,
    control.ingress_nginx_annotations_snippets_alias_not_used,
    control.ingress_nginx_annotations_all_snippets_not_used,
    control.ingress_nginx_annotations_snippets_lua_code_not_used,
  ]

  tags = merge(local.all_controls_ingress_common_tags, {
    type = "Benchmark"
  })
}
