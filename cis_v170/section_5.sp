locals {
  cis_v170_5_common_tags = merge(local.cis_v170_common_tags, {
    cis_section_id = "5"
  })
}

locals {
  cis_v170_5_1_common_tags = merge(local.cis_v170_5_common_tags, {
    cis_section_id = "5.1"
  })

  cis_v170_5_3_common_tags = merge(local.cis_v170_5_common_tags, {
    cis_section_id = "5.3"
  })

  cis_v170_5_7_common_tags = merge(local.cis_v170_5_common_tags, {
    cis_section_id = "5.7"
  })
}

benchmark "cis_v170_5" {
  title       = "5 Policies"
  description = "This section contains recommendations for various Kubernetes policies which are important to the security of the environment."
  children = [
    benchmark.cis_v170_5_1,
    benchmark.cis_v170_5_3,
    benchmark.cis_v170_5_7
  ]

  tags = merge(local.cis_v170_5_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v170_5_1" {
  title = "5.1 RBAC and Service Accounts"
  children = [
    control.cis_v170_5_1_3,
    control.cis_v170_5_1_6
  ]

  tags = merge(local.cis_v170_5_1_common_tags, {
    type = "Benchmark"
  })
}

control "cis_v170_5_1_3" {
  title         = "5.1.3 Minimize wildcard use in Roles and ClusterRoles"
  description   = "The principle of least privilege recommends that users are provided only the access required for their role and nothing more. The use of wildcard rights grants is likely to provide excessive rights to the Kubernetes API."
  query         = query.role_wildcards_used
  documentation = file("./cis_v170/docs/cis_v170_5_1_3.md")

  tags = merge(local.cis_v170_5_1_common_tags, {
    cis_level   = "1"
    cis_item_id = "5.1.3"
    cis_type    = "manual"
    service     = "Kubernetes/Role"
  })
}

control "cis_v170_5_1_6" {
  title         = "5.1.6 Ensure that Service Account Tokens are only mounted where necessary"
  description   = "Mounting service account tokens inside pods can provide an avenue for privilege escalation attacks where an attacker is able to compromise a single pod in the cluster. Avoiding mounting these tokens removes this attack avenue."
  query         = query.pod_service_account_token_disabled
  documentation = file("./cis_v170/docs/cis_v170_5_1_6.md")

  tags = merge(local.cis_v170_5_1_common_tags, {
    cis_level   = "1"
    cis_item_id = "5.1.6"
    cis_type    = "manual"
    service     = "Kubernetes/Pod"
  })
}

benchmark "cis_v170_5_3" {
  title = "5.3 Network Policies and CNI"
  children = [
    benchmark.cis_v170_5_3_2
  ]

  tags = merge(local.cis_v170_5_3_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v170_5_3_2" {
  title         = "5.3.2 Ensure that all Namespaces have Network Policies defined"
  description   = "Administrators should use default policies to isolate traffic in your cluster network. Running different applications on the same Kubernetes cluster creates a risk of one compromised application attacking a neighboring application. Network segmentation is important to ensure that containers can communicate only with those they are supposed to. A network policy is a specification of how selections of pods are allowed to communicate with each other and other network endpoints."
  documentation = file("./cis_v170/docs/cis_v170_5_3_2.md")
  children = [
    control.network_policy_default_deny_egress,
    control.network_policy_default_deny_ingress,
    control.network_policy_default_dont_allow_egress,
    control.network_policy_default_dont_allow_ingress
  ]

  tags = merge(local.cis_v170_5_3_common_tags, {
    cis_level   = "2"
    cis_item_id = "5.3.2"
    cis_type    = "manual"
    type        = "Benchmark"
  })
}

benchmark "cis_v170_5_7" {
  title       = "5.7 General Policies"
  description = "These policies relate to general cluster management topics, like namespace best practices and policies applied to pod objects in the cluster."
  children = [
    benchmark.cis_v170_5_7_2,
    benchmark.cis_v170_5_7_4
  ]

  tags = merge(local.cis_v170_5_7_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v170_5_7_2" {
  title         = "5.7.2 Ensure that the seccomp profile is set to docker/default in your Pod definitions"
  description   = "Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  documentation = file("./cis_v170/docs/cis_v170_5_7_2.md")
  children = [
    control.cronjob_default_seccomp_profile_enabled,
    control.daemonset_default_seccomp_profile_enabled,
    control.deployment_default_seccomp_profile_enabled,
    control.job_default_seccomp_profile_enabled,
    control.pod_default_seccomp_profile_enabled,
    control.replicaset_default_seccomp_profile_enabled,
    control.replication_controller_default_seccomp_profile_enabled,
    control.statefulset_default_seccomp_profile_enabled
  ]

  tags = merge(local.cis_v170_5_7_common_tags, {
    cis_level   = "2"
    cis_item_id = "5.7.2"
    cis_type    = "manual"
  })
}

benchmark "cis_v170_5_7_4" {
  title         = "5.7.4 The default namespace should not be used"
  description   = "Kubernetes provides a default namespace, where objects are placed if no namespace is specified for them. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  documentation = file("./cis_v170/docs/cis_v170_5_7_4.md")
  children = [
    control.config_map_default_namespace_used,
    control.cronjob_default_namespace_used,
    control.daemonset_default_namespace_used,
    control.deployment_default_namespace_used,
    control.ingress_default_namespace_used,
    control.job_default_namespace_used,
    control.pod_default_namespace_used,
    control.replicaset_default_namespace_used,
    control.replication_controller_default_namespace_used,
    control.role_binding_default_namespace_used,
    control.role_default_namespace_used,
    control.secret_default_namespace_used,
    control.service_account_default_namespace_used,
    control.service_default_namespace_used,
    control.statefulset_default_namespace_used
  ]

  tags = merge(local.cis_v170_5_7_common_tags, {
    cis_level   = "2"
    cis_item_id = "5.7.4"
    cis_type    = "manual"
    type        = "Benchmark"
  })
}
