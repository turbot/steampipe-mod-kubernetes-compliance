benchmark "network_separation_and_hardening" {
  title    = "Network separation and hardening "
  children = [
    control.k8s_default_network_policy_isolate_resources,
    control.k8s_cpu_limit,
    control.k8s_memory_limit,
    control.k8s_credentials_not_in_configuration_file
  ]
  tags     = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_default_network_policy_isolate_resources" {
  title       = "Network policy should have a default policy to deny all ingress and egress traffic"
  description = "Network policy should have a default policy to deny all ingress and egress traffic."
  sql         = query.k8s_default_network_policy_isolate_resources.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_cpu_limit" {
  title       = "Container should have CPU request limit"
  description = "Container should have CPU request limit."
  sql         = query.k8s_cpu_limit.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_memory_limit" {
  title       = "Container should have Memory request limit"
  description = "Container should have Memory request limit."
  sql         = query.k8s_memory_limit.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_credentials_not_in_configuration_file" {
  title       = "Credentails should not store in configuration file"
  description = "Credentails should not store in configuration file."
  sql         = query.k8s_credentials_not_in_configuration_file.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}