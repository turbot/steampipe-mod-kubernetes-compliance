benchmark "nsa_cisa_v1_network_hardening" {
  title = "Network Separation and Hardening"
  tags  = local.nsa_cisa_v1_common_tags
  children = [
    benchmark.nsa_cisa_v1_network_hardening_cpu_limit,
    benchmark.nsa_cisa_v1_network_hardening_cpu_request,
    benchmark.nsa_cisa_v1_network_hardening_api_serve_on_secure_port_endpoint,
    benchmark.nsa_cisa_v1_network_hardening_memory_limit,
    benchmark.nsa_cisa_v1_network_hardening_memory_request,
    benchmark.nsa_cisa_v1_network_hardening_default_deny_network_policy,
  ]
}

// CPU limit benchmark
benchmark "nsa_cisa_v1_network_hardening_cpu_limit" {
  title       = "Containers should have a CPU limit"
  description = "Containers should have CPU limit which restricts the container to use no more than a given amount of CPU."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.daemonset_cpu_limit,
    control.deployment_cpu_limit,
    control.job_cpu_limit,
    control.namespace_limit_range_default_cpu_limit,
    control.namespace_resource_quota_cpu_limit,
    control.replicaset_cpu_limit,
    control.replication_controller_cpu_limit,
  ]
}

// CPU request benchmark
benchmark "nsa_cisa_v1_network_hardening_cpu_request" {
  title       = "Containers should have a CPU request"
  description = "Containers should have CPU request. If required Kubernetes will make sure your containers get the CPU they requested."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.daemonset_cpu_request,
    control.deployment_cpu_request,
    control.job_cpu_request,
    control.namespace_limit_range_default_cpu_request,
    control.namespace_resource_quota_cpu_request,
    control.replicaset_cpu_request,
    control.replication_controller_cpu_request,
  ]
}

// Endpoint api serve on secure port benchmark
benchmark "nsa_cisa_v1_network_hardening_api_serve_on_secure_port_endpoint" {
  title       = "Kubernetes API should serve on secure port"
  description = "Kubernetes API should serve on port 443 or port 6443, protected by TLS. Once TLS is established, the HTTP request moves to the authentication step. If the request cannot be authenticated, it is rejected with HTTP status code 401."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.endpoint_api_serve_on_secure_port,
  ]
}

// Memory limit benchmark
benchmark "nsa_cisa_v1_network_hardening_memory_limit" {
  title       = "Containers should have a memory limit"
  description = "Containers should have a memory limit which restricts the container to use no more than a given amount of user or system memory."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.daemonset_memory_limit,
    control.deployment_memory_limit,
    control.job_memory_limit,
    control.namespace_limit_range_default_memory_limit,
    control.namespace_resource_quota_memory_limit,
    control.replicaset_memory_limit,
    control.replication_controller_memory_limit,
  ]
}

// Memory request benchmark
benchmark "nsa_cisa_v1_network_hardening_memory_request" {
  title       = "Containers should have a memory request"
  description = "Containers should have memory request. If required Kubernetes will make sure your containers get the memory they requested."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.daemonset_memory_request,
    control.deployment_memory_request,
    control.job_memory_request,
    control.namespace_limit_range_default_memory_request,
    control.namespace_resource_quota_memory_request,
    control.replicaset_memory_request,
    control.replication_controller_memory_request,
  ]
}

// Network policy default deny benchmark
benchmark "nsa_cisa_v1_network_hardening_default_deny_network_policy" {
  title       = "Network policy should have a default policy to deny all ingress and egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  tags        = local.nsa_cisa_v1_common_tags
  children = [
    control.network_policy_default_deny_egress,
    control.network_policy_default_deny_ingress,
    control.network_policy_default_dont_allow_egress,
    control.network_policy_default_dont_allow_ingress,
  ]
}
