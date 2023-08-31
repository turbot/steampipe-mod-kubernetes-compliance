locals {
  all_controls_config_map_common_tags = merge(local.all_controls_common_tags, {
  })
}

benchmark "all_controls_config_map" {
  title       = "ConfigMap"
  description = "This section contains recommendations for configuring ConfigMap resources."
  children = [
    control.config_map_default_namespace_used
  ]

  tags = merge(local.all_controls_config_map_common_tags, {
    type = "Benchmark"
  })
}
