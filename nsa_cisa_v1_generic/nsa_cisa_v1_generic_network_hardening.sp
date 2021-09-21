benchmark "nsa_cisa_v1_generic_network_hardening" {
  title = "NSA and CISA v1.0 Network Separation and Hardening"
  tags  = local.nsa_cisa_v1_generic_common_tags
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
  tags        = local.nsa_cisa_v1_generic_common_tags
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

control "daemonset_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "DaemonSet")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "DaemonSet")
  sql         = query.daemonset_cpu_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "deployment_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "Deployment")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "Deployment")
  sql         = query.deployment_cpu_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "job_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "Job")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "Job")
  sql         = query.job_cpu_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "namespace_limit_range_default_cpu_limit" {
  title       = "Namespaces should have default CPU limit in limitRange policy"
  description = "Administrators should use default limitRange policy for CPU limit for each namespaces."
  sql         = query.namespace_limit_range_default_cpu_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "namespace_resource_quota_cpu_limit" {
  title       = "Namespaces should be restricted on CPU usage with resourceQuota CPU limit"
  description = "Administrators should use resourceQuota CPU limit to restrict namespaces CPU usage."
  sql         = query.namespace_resource_quota_cpu_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "replicaset_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "ReplicaSet")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_cpu_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "replication_controller_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "ReplicationController")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_cpu_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

// CPU request benchmark
benchmark "nsa_cisa_v1_network_hardening_cpu_request" {
  title       = "Containers should have a CPU request"
  description = "Containers should have CPU request. If required Kubernetes will make sure your containers get the CPU they requested."
  tags        = local.nsa_cisa_v1_generic_common_tags
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

control "daemonset_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "DaemonSet")
  description = replace(local.desc_container_cpu_request, "__KIND__", "DaemonSet")
  sql         = query.daemonset_cpu_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "deployment_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "Deployment")
  description = replace(local.desc_container_cpu_request, "__KIND__", "Deployment")
  sql         = query.deployment_cpu_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "job_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "Job")
  description = replace(local.desc_container_cpu_request, "__KIND__", "Job")
  sql         = query.job_cpu_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "namespace_limit_range_default_cpu_request" {
  title       = "Namespaces should have default CPU request in limitRange policy"
  description = "Administrators should use default limitRange policy for CPU request for each namespaces."
  sql         = query.namespace_limit_range_default_cpu_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "namespace_resource_quota_cpu_request" {
  title       = "Namespaces should have resourceQuota CPU request"
  description = "Administrators should use resourceQuota CPU request for each namespaces."
  sql         = query.namespace_resource_quota_cpu_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "replicaset_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "ReplicaSet")
  description = replace(local.desc_container_cpu_request, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_cpu_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "replication_controller_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "ReplicationController")
  description = replace(local.desc_container_cpu_request, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_cpu_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

// Endpoint api serve on secure port benchmark
benchmark "nsa_cisa_v1_network_hardening_api_serve_on_secure_port_endpoint" {
  title       = "Kubernetes API should serve on secure port"
  description = "Kubernetes API should serve on port 443 or port 6443, protected by TLS. Once TLS is established, the HTTP request moves to the authentication step. If the request cannot be authenticated, it is rejected with HTTP status code 401."
  tags        = local.nsa_cisa_v1_generic_common_tags
  children = [
    control.endpoint_api_serve_on_secure_port,
  ]
}

control "endpoint_api_serve_on_secure_port" {
  title       = "Kubernetes API should serve on secure port"
  description = "Kubernetes API should serve on port 443 or port 6443, protected by TLS. Once TLS is established, the HTTP request moves to the authentication step. If the request cannot be authenticated, it is rejected with HTTP status code 401."
  sql         = query.endpoint_api_serve_on_secure_port.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

// Memory limit benchmark
benchmark "nsa_cisa_v1_network_hardening_memory_limit" {
  title       = "Containers should have a memory limit"
  description = "Containers should have a memory limit which restricts the container to use no more than a given amount of user or system memory."
  tags        = local.nsa_cisa_v1_generic_common_tags
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

control "daemonset_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "DaemonSet")
  description = replace(local.desc_container_memory_limit, "__KIND__", "DaemonSet")
  sql         = query.daemonset_memory_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "deployment_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "Deployment")
  description = replace(local.desc_container_memory_limit, "__KIND__", "Deployment")
  sql         = query.deployment_memory_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "job_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "Job")
  description = replace(local.desc_container_memory_limit, "__KIND__", "Job")
  sql         = query.job_memory_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "namespace_limit_range_default_memory_limit" {
  title       = "Namespaces should have default memory limit in limitRange policy"
  description = "Administrators should use default limitRange policy for memory limit for each namespaces."
  sql         = query.namespace_limit_range_default_memory_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "namespace_resource_quota_memory_limit" {
  title       = "Namespaces should be restricted on memory usage with resourceQuota memory limit"
  description = "Administrators should use resourceQuota memory limit to restrict namespaces memory usage."
  sql         = query.namespace_resource_quota_memory_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "replicaset_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "ReplicaSet")
  description = replace(local.desc_container_memory_limit, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_memory_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "replication_controller_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "ReplicationController")
  description = replace(local.desc_container_memory_limit, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_memory_limit.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

// Memory request benchmark
benchmark "nsa_cisa_v1_network_hardening_memory_request" {
  title       = "Containers should have a memory request"
  description = "Containers should have memory request. If required Kubernetes will make sure your containers get the memory they requested."
  tags        = local.nsa_cisa_v1_generic_common_tags
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

control "daemonset_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "DaemonSet")
  description = replace(local.desc_container_memory_request, "__KIND__", "DaemonSet")
  sql         = query.daemonset_memory_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "deployment_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "Deployment")
  description = replace(local.desc_container_memory_request, "__KIND__", "Deployment")
  sql         = query.deployment_memory_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "job_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "Job")
  description = replace(local.desc_container_memory_request, "__KIND__", "Job")
  sql         = query.job_memory_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "namespace_limit_range_default_memory_request" {
  title       = "Namespaces should have default memory request in limitRange policy"
  description = "Administrators should use default limitRange policy for memory request for each namespaces."
  sql         = query.namespace_limit_range_default_memory_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "namespace_resource_quota_memory_request" {
  title       = "Namespaces should have resourceQuota memory request"
  description = "Administrators should use resourceQuota memory request for each namespaces."
  sql         = query.namespace_resource_quota_memory_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "replicaset_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "ReplicaSet")
  description = replace(local.desc_container_memory_request, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_memory_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "replication_controller_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "ReplicationController")
  description = replace(local.desc_container_memory_request, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_memory_request.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

// Network policy default deny benchmark
benchmark "nsa_cisa_v1_network_hardening_default_deny_network_policy" {
  title       = "Network policy should have a default policy to deny all ingress and egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  tags        = local.nsa_cisa_v1_generic_common_tags
  children = [
    control.network_policy_default_deny_egress,
    control.network_policy_default_deny_ingress,
    control.network_policy_default_dont_allow_egress,
    control.network_policy_default_dont_allow_ingress,
  ]
}

control "network_policy_default_deny_egress" {
  title       = "Namespace should have a default network policy to deny all egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.network_policy_default_deny_egress.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "network_policy_default_deny_ingress" {
  title       = "Namespace should have a default network policy to deny all ingress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.network_policy_default_deny_ingress.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "network_policy_default_dont_allow_egress" {
  title       = "Network policy should not have a default policy to allow all egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. An 'allow all' policy would override this default and should not be used.  Instead, use specific  policies to relax these restrictions only for permissible connections. "
  sql         = query.network_policy_default_dont_allow_egress.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}

control "network_policy_default_dont_allow_ingress" {
  title       = "Network policy should not have a default policy to allow all ingress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. An 'allow all' policy would override this default and should not be used.  Instead, use specific  policies to relax these restrictions only for permissible connections. "
  sql         = query.network_policy_default_dont_allow_ingress.sql
  tags        = local.nsa_cisa_v1_generic_common_tags
}
