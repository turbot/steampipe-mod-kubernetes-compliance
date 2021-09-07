benchmark "network_separation_and_hardening" {
  title = "Network separation and hardening "
  children = [
    control.k8s_api_serve_on_secure_port,
    control.k8s_cpu_limit,
    control.k8s_cpu_request,
    control.k8s_default_network_policy_deny_all_ingress_egress,
    control.k8s_default_network_policy_deny_egress,
    control.k8s_default_network_policy_deny_ingress,
    control.k8s_memory_limit,
    control.k8s_memory_request,

  ]
  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_default_network_policy_deny_all_ingress_egress" {
  title       = "Network policy should have a default policy to deny all ingress and egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.k8s_default_network_policy_deny_all_ingress_egress.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_default_network_policy_deny_ingress" {
  title       = "Network policy should have a default policy to deny all ingress and egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.k8s_default_network_policy_deny_ingress.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_default_network_policy_deny_egress" {
  title       = "Network policy should have a default policy to deny all ingress and egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.k8s_default_network_policy_deny_egress.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_cpu_limit" {
  title       = "Container should have CPU limit"
  description = "Container should have a CPU limit which restricts the container to use no more than a given amount of CPU."
  sql         = query.k8s_cpu_limit.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_memory_limit" {
  title       = "Container should have Memory limit"
  description = "Container should have a memory limit which restricts the container to use no more than a given amount of user or system memory."
  sql         = query.k8s_memory_limit.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_cpu_request" {
  title       = "Container should have CPU request"
  description = "Container should have a CPU request. If required Kubernetes will make sure your containers get the CPU they requested."
  sql         = query.k8s_cpu_request.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_memory_request" {
  title       = "Container should have Memory request"
  description = "Container should have Memory request. If required Kubernetes will make sure your containers get the memory they requested."
  sql         = query.k8s_memory_request.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "k8s_api_serve_on_secure_port" {
  title       = "Kubernetes API should serve on secure port"
  description = "Kubernetes API should serve on port 443 or port 6443, protected by TLS. Once TLS is established, the HTTP request moves to the Authentication step. If the request cannot be authenticated, it is rejected with HTTP status code 401."
  sql         = query.k8s_api_serve_on_secure_port.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}
