locals {
  all_controls_network_policy_common_tags = merge(local.all_controls_common_tags, {
    service = "Kubernetes/NetworkPolicy"
  })
}

benchmark "all_controls_network_policy" {
  title       = "Network Policy"
  description = "This section contains recommendations for configuring Network Policy resources."
  children = [
    control.network_policy_default_deny_egress,
    control.network_policy_default_deny_ingress,
    control.network_policy_default_dont_allow_egress,
    control.network_policy_default_dont_allow_ingress
  ]

  tags = merge(local.all_controls_network_policy_common_tags, {
    type = "Benchmark"
  })
}
