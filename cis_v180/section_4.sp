locals {
  cis_v180_4_common_tags = merge(local.cis_v180_common_tags, {
    cis_section_id = "4"
  })
}

locals {
  cis_v180_4_2_common_tags = merge(local.cis_v180_4_common_tags, {
    cis_section_id = "4.2"
  })
}

benchmark "cis_v180_4" {
  title       = "4 Worker Nodes"
  description = "This section consists of security recommendations for the components that run on Kubernetes worker nodes. Note that these components may also run on Kubernetes master nodes, so the recommendations in this section should be applied to master nodes as well as worker nodes where the master nodes make use of these components."
  children = [
    benchmark.cis_v180_4_2
  ]

  tags = merge(local.cis_v180_4_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v180_4_2" {
  title       = "4.2 Kubelet"
  description = "This section contains recommendations for kubelet configuration. Kubelet settings may be configured using arguments on the running kubelet executable, or they may be taken from a Kubelet config file. If both are specified, the executable argument takes precedence."
    documentation = file("./cis_v180/docs/cis_v180_4_2.md")
  children = [
    benchmark.cis_v180_4_2_1
  ]

  tags = merge(local.cis_v180_4_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v180_4_2_1" {
  title         = "4.2.1 Ensure that the --anonymous-auth argument is set to false "
  description   = "Disable anonymous requests to the Kubelet server.."
  documentation = file("./cis_v180/docs/cis_v180_4_2_1.md")
  children = [
    control.cronjob_container_argument_anonymous_auth_disabled,
    control.daemonset_container_argument_anonymous_auth_disabled,
    control.deployment_container_argument_anonymous_auth_disabled,
    control.job_container_argument_anonymous_auth_disabled,
    control.pod_container_argument_anonymous_auth_disabled,
    control.pod_template_container_argument_api_server_anonymous_auth_disabled,
    control.replicaset_container_argument_anonymous_auth_disabled,
    control.replication_controller_container_argument_anonymous_auth_disabled,
    control.statefulset_container_argument_anonymous_auth_disabled
  ]

  tags = merge(local.cis_v180_4_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "4.2.1"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}