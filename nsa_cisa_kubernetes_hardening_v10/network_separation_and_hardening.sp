benchmark "network_separation_and_hardening" {
  title    = "Network separation and hardening "
  children = [
    control.k8s_default_network_policy_isolate_resources,
    control.k8s_cpu_limit,
    control.k8s_memory_limit,
    control.k8s_credentials_not_in_configuration_file,
    control.k8s_cpu_request,
    control.k8s_memory_request,
    control.k8s_api_serve_on_secure_port
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
  title       = "Container should have CPU limit"
  description = "Container should have CPU limit."
  sql         = query.k8s_cpu_limit.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_memory_limit" {
  title       = "Container should have Memory limit"
  description = "Container should have Memory limit."
  sql         = query.k8s_memory_limit.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_credentials_not_in_configuration_file" {
  title       = "Credentails should not store in configuration file"
  description = "Credentails should not store in configuration file."
  sql         = query.k8s_credentials_not_in_configuration_file.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_cpu_request" {
  title       = "Container should have CPU request"
  description = "Container should have CPU request."
  sql         = query.k8s_cpu_request.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_memory_request" {
  title       = "Container should have Memory request"
  description = "Container should have Memory request."
  sql         = query.k8s_memory_request.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_api_serve_on_secure_port" {
  title       = "Kubernetes API should serve on secure port"
  description = "Kubernetes API should serve on port 443 or port 6443."
  sql         = query.k8s_api_serve_on_secure_port.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}