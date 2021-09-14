benchmark "nsa_cisa_v10_network_separation_and_hardening" {
  title = "Network Separation and Hardening"
  children = [
    control.nsa_cisa_v10_api_serve_on_secure_port,

    benchmark.nsa_cisa_v10_cpu_limit,
    benchmark.nsa_cisa_v10_cpu_request,
    benchmark.nsa_cisa_v10_memory_limit,
    benchmark.nsa_cisa_v10_memory_request,
    benchmark.nsa_cisa_v10_network_policy_default_deny

  ]
  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

########################################################
benchmark "nsa_cisa_v10_network_policy_default_deny" {
  title       = "Network policy should have a default policy to deny all ingress and egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  children = [
    control.nsa_cisa_v10_network_policy_default_deny_ingress,
    control.nsa_cisa_v10_network_policy_default_deny_egress,
    control.nsa_cisa_v10_network_policy_default_dont_allow_ingress,
    control.nsa_cisa_v10_network_policy_default_dont_allow_egress,
  ]
  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_network_policy_default_dont_allow_egress" {
  title       = "Network policy should not have a default policy to allow all egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. An 'allow all' policy would override this default and should not be used.  Instead, use specific  policies to relax these restrictions only for permissible connections. "
  sql         = query.network_policy_default_dont_allow_egress.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_network_policy_default_dont_allow_ingress" {
  title       = "Network policy should not have a default policy to allow all ingress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. An 'allow all' policy would override this default and should not be used.  Instead, use specific  policies to relax these restrictions only for permissible connections. "
  sql         = query.network_policy_default_dont_allow_ingress.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_network_policy_default_deny_ingress" {
  title       = "Namespace should have a default network policy to deny all ingress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.network_policy_default_deny_ingress.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_network_policy_default_deny_egress" {
  title       = "Namespace should have a default network policy to deny all egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.network_policy_default_deny_egress.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

########################################################
benchmark "nsa_cisa_v10_cpu_limit" {
  title       = "Containers should have a CPU limit"
  description = "Containers should have CPU limit which restricts the container to use no more than a given amount of CPU."
  children = [
    control.nsa_cisa_v10_daemonset_cpu_limit,
    control.nsa_cisa_v10_deployment_cpu_limit,
    control.nsa_cisa_v10_job_cpu_limit,
    control.nsa_cisa_v10_replicaset_cpu_limit,
    control.nsa_cisa_v10_replication_controller_cpu_limit,
  ]
  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

locals {
  title_container_cpu_limit = "__KIND__ containers should have a CPU limit"
  desc_container_cpu_limit = "Containers in a __KIND__  should have CPU limit which restricts the container to use no more than a given amount of CPU."
}

control "nsa_cisa_v10_daemonset_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "DaemonSet")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "DaemonSet")
  sql         = query.daemonset_cpu_limit.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_deployment_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "Deployment")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "Deployment")
  sql         = query.deployment_cpu_limit.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_job_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "Job")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "Job")
  sql         = query.job_cpu_limit.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_replicaset_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "ReplicaSet")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_cpu_limit.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_replication_controller_cpu_limit" {
  title       = replace(local.title_container_cpu_limit, "__KIND__", "ReplicationController")
  description = replace(local.desc_container_cpu_limit, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_cpu_limit.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

########################################################
benchmark "nsa_cisa_v10_cpu_request" {
  title       = "Containers should have a CPU request"
  description = "Containers should have CPU request. If required Kubernetes will make sure your containers get the CPU they requested."
  children = [
    control.nsa_cisa_v10_daemonset_cpu_request,
    control.nsa_cisa_v10_deployment_cpu_request,
    control.nsa_cisa_v10_job_cpu_request,
    control.nsa_cisa_v10_replicaset_cpu_request,
    control.nsa_cisa_v10_replication_controller_cpu_request,
  ]
  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

locals {
  title_container_cpu_request = "__KIND__ containers should have a CPU request"
  desc_container_cpu_request = "Containers in a __KIND__ should have CPU request. If required Kubernetes will make sure your containers get the CPU they requested."
}

control "nsa_cisa_v10_daemonset_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "DaemonSet")
  description = replace(local.desc_container_cpu_request, "__KIND__", "DaemonSet")
  sql         = query.daemonset_cpu_request.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_deployment_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "Deployment")
  description = replace(local.desc_container_cpu_request, "__KIND__", "Deployment")
  sql         = query.deployment_cpu_request.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_job_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "Job")
  description = replace(local.desc_container_cpu_request, "__KIND__", "Job")
  sql         = query.job_cpu_request.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_replicaset_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "ReplicaSet")
  description = replace(local.desc_container_cpu_request, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_cpu_request.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_replication_controller_cpu_request" {
  title       = replace(local.title_container_cpu_request, "__KIND__", "ReplicationController")
  description = replace(local.desc_container_cpu_request, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_cpu_request.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

########################################################
benchmark "nsa_cisa_v10_memory_limit" {
  title       = "Containers should have a memory limit"
  description = "Containers should have a memory limit which restricts the container to use no more than a given amount of user or system memory."
  children = [
    control.nsa_cisa_v10_daemonset_memory_limit,
    control.nsa_cisa_v10_deployment_memory_limit,
    control.nsa_cisa_v10_job_memory_limit,
    control.nsa_cisa_v10_replicaset_memory_limit,
    control.nsa_cisa_v10_replication_controller_memory_limit,
  ]
  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

locals {
  title_container_memory_limit = "__KIND__ containers should have a memory limit"
  desc_container_memory_limit = "Containers in a __KIND__ should have memory limit which restricts the container to use no more than a given amount of user or system memory."
}

control "nsa_cisa_v10_daemonset_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "DaemonSet")
  description = replace(local.desc_container_memory_limit, "__KIND__", "DaemonSet")
  sql         = query.daemonset_memory_limit.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_deployment_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "Deployment")
  description = replace(local.desc_container_memory_limit, "__KIND__", "Deployment")
  sql         = query.deployment_memory_limit.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_job_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "Job")
  description = replace(local.desc_container_memory_limit, "__KIND__", "Job")
  sql         = query.job_memory_limit.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_replicaset_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "ReplicaSet")
  description = replace(local.desc_container_memory_limit, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_memory_limit.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_replication_controller_memory_limit" {
  title       = replace(local.title_container_memory_limit, "__KIND__", "ReplicationController")
  description = replace(local.desc_container_memory_limit, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_memory_limit.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

########################################################
benchmark "nsa_cisa_v10_memory_request" {
  title       = "Containers should have a memory request"
  description = "Containers should have memory request. If required Kubernetes will make sure your containers get the memory they requested."
  children = [
    control.nsa_cisa_v10_daemonset_memory_request,
    control.nsa_cisa_v10_deployment_memory_request,
    control.nsa_cisa_v10_job_memory_request,
    control.nsa_cisa_v10_replicaset_memory_request,
    control.nsa_cisa_v10_replication_controller_memory_request,
  ]
  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

locals {
  title_container_memory_request = "__KIND__ containers should have a memory request"
  desc_container_memory_request = "Containers in a __KIND__ should have memory request. If required Kubernetes will make sure your containers get the memory they requested."
}

control "nsa_cisa_v10_daemonset_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "DaemonSet")
  description = replace(local.desc_container_memory_request, "__KIND__", "DaemonSet")
  sql         = query.daemonset_memory_request.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_deployment_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "Deployment")
  description = replace(local.desc_container_memory_request, "__KIND__", "Deployment")
  sql         = query.deployment_memory_request.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_job_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "Job")
  description = replace(local.desc_container_memory_request, "__KIND__", "Job")
  sql         = query.job_memory_request.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_replicaset_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "ReplicaSet")
  description = replace(local.desc_container_memory_request, "__KIND__", "ReplicaSet")
  sql         = query.replicaset_memory_request.sql

  tags = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

control "nsa_cisa_v10_replication_controller_memory_request" {
  title       = replace(local.title_container_memory_request, "__KIND__", "ReplicationController")
  description = replace(local.desc_container_memory_request, "__KIND__", "ReplicationController")
  sql         = query.replication_controller_memory_request.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}

########################################################
control "nsa_cisa_v10_api_serve_on_secure_port" {
  title       = "Kubernetes API should serve on secure port"
  description = "Kubernetes API should serve on port 443 or port 6443, protected by TLS. Once TLS is established, the HTTP request moves to the authentication step. If the request cannot be authenticated, it is rejected with HTTP status code 401."
  sql         = query.api_serve_on_secure_port.sql
  tags        = local.nsa_cisa_kubernetes_hardening_v10_common_tags
}
