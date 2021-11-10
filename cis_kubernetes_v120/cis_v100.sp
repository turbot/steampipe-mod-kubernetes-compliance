locals {
  cis_kubernetes_v120_v100_common_tags = merge(local.cis_kubernetes_v120_common_tags,{
    cis_version = "v1.0.0"
  })
}

locals{
  cis_kubernetes_v120_v100_5_common_tags = merge(local.cis_kubernetes_v120_v100_common_tags, {
    cis_section_id = "5"
  })
}

benchmark "cis_v100" {
  title         = "CIS v1.0.0"
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_overview.md")
  tags          = local.cis_kubernetes_v120_v100_common_tags
  children = [
    benchmark.cis_v100_5
  ]
}

benchmark "cis_v100_5" {
  title       = "5 Policies"
  description = "This section contains recommendations for various Kubernetes policies which are important to the security of the environment."
  tags        = local.cis_kubernetes_v120_v100_5_common_tags
  children = [
    benchmark.cis_v100_5_3_2,
    benchmark.cis_v100_5_7_4,
    control.cis_v100_5_1_6,
    control.cis_v100_5_2_1,
    control.cis_v100_5_2_2,
    control.cis_v100_5_2_3,
    control.cis_v100_5_2_4,
    control.cis_v100_5_2_5,
    control.cis_v100_5_2_6,
    control.cis_v100_5_7_2
  ]
}

benchmark "cis_v100_5_3_2" {
  title         = "5.3.2 Ensure that all Namespaces have Network Policies defined"
  description   = "Administrators should use default policies to isolate traffic in your cluster network. Running different applications on the same Kubernetes cluster creates a risk of one compromised application attacking a neighboring application. Network segmentation is important to ensure that containers can communicate only with those they are supposed to. A network policy is a specification of how selections of pods are allowed to communicate with each other and other network endpoints."
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_5_3_2.md")
  children = [
    control.network_policy_default_deny_egress,
    control.network_policy_default_deny_ingress,
    control.network_policy_default_dont_allow_egress,
    control.network_policy_default_dont_allow_ingress
  ]
  tags = merge(local.cis_kubernetes_v120_v100_5_common_tags, {
    cis_level   = "2"
    cis_item_id = "5.3.2"
    cis_type    = "manual"
  })
}

benchmark "cis_v100_5_7_4" {
  title         = "5.7.4 The default namespace should not be used"
  description   = "Kubernetes provides a default namespace, where objects are placed if no namespace is specified for them. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_5_7_4.md")
  children = [
    control.daemonset_default_namesapce_used,
    control.deployment_default_namesapce_used,
    control.job_default_namesapce_used,
    control.pod_default_namesapce_used,
    control.replicaset_default_namesapce_used,
    control.replication_controller_default_namesapce_used,
    control.service_default_namesapce_used
  ]
  tags = merge(local.cis_kubernetes_v120_v100_5_common_tags, {
    cis_level   = "2"
    cis_item_id = "5.7.4"
    cis_type    = "manual"
  })
}

control "cis_v100_5_2_1" {
  title         = "5.2.1 Minimize the admission of privileged containers"
  description   = "Privileged containers have access to all Linux Kernel capabilities and devices. A container running with full privileges can do almost everything that the host can do. This flag exists to allow special use-cases, like manipulating the network stack and accessing devices. There should be at least one PodSecurityPolicy (PSP) defined which does not permit privileged containers."
  sql           = query.pod_security_policy_container_privilege_disabled.sql
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_5_2_1.md")
  tags = merge(local.cis_kubernetes_v120_v100_5_common_tags, {
    cis_level   = "1"
    cis_item_id = "5.2.1"
    cis_type    = "automated"
  })
}

control "cis_v100_5_2_5" {
  title         = "5.2.5 Minimize the admission of containers with allowPrivilegeEscalation"
  description   = "A container running with the `allowPrivilegeEscalation` flag set to true may have processes that can gain more privileges than their parent. There should be at least one PodSecurityPolicy (PSP) defined which does not permit containers to allow privilege escalation. The option exists (and is defaulted to true) to permit setuid binaries to run."
  sql           = query.pod_security_policy_container_privilege_escalation_disabled.sql
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_5_2_5.md")
  tags = merge(local.cis_kubernetes_v120_v100_5_common_tags, {
    cis_level   = "1"
    cis_item_id = "5.2.5"
    cis_type    = "automated"
  })
}

control "cis_v100_5_2_4" {
  title         = "5.2.4 Minimize the admission of containers wishing to share the host network namespace"
  description   = "A container running in the host's network namespace could access the local loopback device, and could access network traffic to and from other pods. There should be at least one PodSecurityPolicy (PSP) defined which does not permit containers to share the host network namespace."
  sql           = query.pod_security_policy_host_network_access_disabled.sql
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_5_2_4.md")
  tags = merge(local.cis_kubernetes_v120_v100_5_common_tags, {
    cis_level   = "1"
    cis_item_id = "5.2.4"
    cis_type    = "automated"
  })
}

control "cis_v100_5_2_2" {
  title         = "5.2.2 Minimize the admission of containers wishing to share the host process ID namespace"
  description   = "A container running in the host's PID namespace can inspect processes running outside the container. If the container also has access to ptrace capabilities this can be used to escalate privileges outside of the container. There should be at least one PodSecurityPolicy (PSP) defined which does not permit containers to share the host PID namespace."
  sql           = query.pod_security_policy_hostpid_sharing_disabled.sql
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_5_2_2.md")
  tags = merge(local.cis_kubernetes_v120_v100_5_common_tags, {
    cis_level   = "1"
    cis_item_id = "5.2.2"
    cis_type    = "automated"
  })
}

control "cis_v100_5_2_3" {
  title         = "5.2.3 Minimize the admission of containers wishing to share the host IPC namespace"
  description   = "A container running in the host's IPC namespace can use IPC to interact with processes outside the container. There should be at least one PodSecurityPolicy (PSP) defined which does not permit containers to share the host IPC namespace."
  sql           = query.pod_security_policy_hostipc_sharing_disabled.sql
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_5_2_3.md")
  tags = merge(local.cis_kubernetes_v120_v100_5_common_tags, {
    cis_level   = "1"
    cis_item_id = "5.2.3"
    cis_type    = "automated"
  })
}

control "cis_v100_5_2_6" {
  title         = "5.2.6 Minimize the admission of root containers"
  description   = "Containers may run as any Linux user. Containers which run as the root user, whilst constrained by Container Runtime security features still have a escalated likelihood of container breakout. There should be at least one PodSecurityPolicy (PSP) defined which does not permit root users in a container."
  sql           = query.pod_security_policy_non_root_container.sql
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_5_2_6.md")
  tags = merge(local.cis_kubernetes_v120_v100_5_common_tags, {
    cis_level   = "2"
    cis_item_id = "5.2.6"
    cis_type    = "automated"
  })
}

control "cis_v100_5_1_6" {
  title         = "5.1.6 Ensure that Service Account Tokens are only mounted where necessary"
  description   = "Mounting service account tokens inside pods can provide an avenue for privilege escalation attacks where an attacker is able to compromise a single pod in the cluster. Avoiding mounting these tokens removes this attack avenue."
  sql           = query.pod_service_account_token_disabled.sql
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_5_1_6.md")
  tags = merge(local.cis_kubernetes_v120_v100_5_common_tags, {
    cis_level   = "1"
    cis_item_id = "5.1.6"
    cis_type    = "manual"
  })
}

control "cis_v100_5_7_2" {
  title         = "5.7.2 Ensure that the seccomp profile is set to docker/default in your Pod definitions"
  description   = "Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  sql           = query.pod_default_seccomp_profile_enabled.sql
  documentation = file("./cis_kubernetes_v120/docs/cis_v100_5_7_2.md")
  tags = merge(local.cis_kubernetes_v120_v100_5_common_tags, {
    cis_level   = "2"
    cis_item_id = "5.7.2"
    cis_type    = "manual"
  })
}