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
  title         = "4.2 Kubelet"
  description   = "This section contains recommendations for kubelet configuration. Kubelet settings may be configured using arguments on the running kubelet executable, or they may be taken from a Kubelet config file. If both are specified, the executable argument takes precedence."
  documentation = file("./cis_v180/docs/cis_v180_4_2.md")
  children = [
    benchmark.cis_v180_4_2_1,
    benchmark.cis_v180_4_2_2,
    benchmark.cis_v180_4_2_3,
    benchmark.cis_v180_4_2_4,
    benchmark.cis_v180_4_2_5,
    benchmark.cis_v180_4_2_6,
    benchmark.cis_v180_4_2_7,
    benchmark.cis_v180_4_2_9
  ]

  tags = merge(local.cis_v180_4_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v180_4_2_1" {
  title         = "4.2.1 Ensure that the --anonymous-auth argument is set to false"
  description   = "Disable anonymous requests to the Kubelet server."
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

benchmark "cis_v180_4_2_2" {
  title         = "4.2.2 Ensure that the --authorization-mode argument is not set to AlwaysAllow"
  description   = "Do not allow all requests. Enable explicit authorization."
  documentation = file("./cis_v180/docs/cis_v180_4_2_2.md")
  children = [
    control.cronjob_container_argument_kubelet_authorization_mode_no_always_allow,
    control.daemonset_container_argument_kubelet_authorization_mode_no_always_allow,
    control.deployment_container_argument_kubelet_authorization_mode_no_always_allow,
    control.job_container_argument_kubelet_authorization_mode_no_always_allow,
    control.pod_container_argument_kubelet_authorization_mode_no_always_allow,
    control.pod_template_container_argument_kubelet_authorization_mode_no_always_allow,
    control.replicaset_container_argument_kubelet_authorization_mode_no_always_allow,
    control.replication_controller_container_argument_kubelet_authorization_mode_no_always_allow,
    control.statefulset_container_argument_kubelet_authorization_mode_no_always_allow
  ]

  tags = merge(local.cis_v180_4_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "4.2.2"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_4_2_3" {
  title         = "4.2.3 Ensure that the --client-ca-file argument is set as appropriate"
  description   = "Enable Kubelet authentication using certificates."
  documentation = file("./cis_v180/docs/cis_v180_4_2_3.md")
  children = [
    control.cronjob_container_argument_kubelet_client_ca_file_configured,
    control.daemonset_container_argument_kubelet_client_ca_file_configured,
    control.deployment_container_argument_kubelet_client_ca_file_configured,
    control.job_container_argument_kubelet_client_ca_file_configured,
    control.pod_container_argument_kubelet_client_ca_file_configured,
    control.pod_template_container_argument_kubelet_client_ca_file_configured,
    control.replicaset_container_argument_kubelet_client_ca_file_configured,
    control.replication_controller_container_argument_kubelet_client_ca_file_configured,
    control.statefulset_container_argument_kubelet_client_ca_file_configured
  ]

  tags = merge(local.cis_v180_4_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "4.2.3"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_4_2_4" {
  title         = "4.2.4 Verify that the --read-only-port argument is set to 0"
  description   = "Disable the read-only port."
  documentation = file("./cis_v180/docs/cis_v180_4_2_4.md")
  children = [
    control.cronjob_container_argument_kubelet_read_only_port_0,
    control.daemonset_container_argument_kubelet_read_only_port_0,
    control.deployment_container_argument_kubelet_read_only_port_0,
    control.job_container_argument_kubelet_read_only_port_0,
    control.pod_container_argument_kubelet_read_only_port_0,
    control.pod_template_container_argument_kubelet_read_only_port_0,
    control.replicaset_container_argument_kubelet_read_only_port_0,
    control.replication_controller_container_argument_kubelet_read_only_port_0,
    control.statefulset_container_argument_kubelet_read_only_port_0
  ]

  tags = merge(local.cis_v180_4_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "4.2.4"
    cis_type    = "manual"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_4_2_5" {
  title         = "4.2.5 Ensure that the --streaming-connection-idle-timeout argument is not set to 0"
  description   = "Do not disable timeouts on streaming connections."
  documentation = file("./cis_v180/docs/cis_v180_4_2_5.md")
  children = [
    control.cronjob_container_streaming_connection_idle_timeout_not_zero,
    control.daemonset_container_streaming_connection_idle_timeout_not_zero,
    control.deployment_container_streaming_connection_idle_timeout_not_zero,
    control.job_container_streaming_connection_idle_timeout_not_zero,
    control.pod_container_streaming_connection_idle_timeout_not_zero,
    control.replicaset_container_streaming_connection_idle_timeout_not_zero,
    control.replication_controller_container_streaming_connection_idle_timeout_not_zero,
    control.statefulset_container_streaming_connection_idle_timeout_not_zero
  ]

  tags = merge(local.cis_v180_4_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "4.2.5"
    cis_type    = "manual"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_4_2_6" {
  title         = "4.2.6 Ensure that the --make-iptables-util-chains argument is set to true"
  description   = "Allow Kubelet to manage iptables."
  documentation = file("./cis_v180/docs/cis_v180_4_2_6.md")
  children = [
    control.cronjob_container_argument_make_iptables_util_chains_enabled,
    control.daemonset_container_argument_make_iptables_util_chains_enabled,
    control.deployment_container_argument_make_iptables_util_chains_enabled,
    control.job_container_argument_make_iptables_util_chains_enabled,
    control.pod_container_argument_make_iptables_util_chains_enabled,
    control.pod_template_container_argument_make_iptables_util_chains_enabled,
    control.replicaset_container_argument_make_iptables_util_chains_enabled,
    control.replication_controller_container_argument_make_iptables_util_chains_enabled,
    control.statefulset_container_argument_make_iptables_util_chains_enabled
  ]

  tags = merge(local.cis_v180_4_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "4.2.6"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_4_2_7" {
  title         = "4.2.7 Ensure that the --hostname-override argument is not set "
  description   = "Do not override node hostnames."
  documentation = file("./cis_v180/docs/cis_v180_4_2_7.md")
  children = [
    control.cronjob_container_no_argument_hostname_override_configured,
    control.daemonset_container_no_argument_hostname_override_configured,
    control.deployment_container_no_argument_hostname_override_configured,
    control.job_container_no_argument_hostname_override_configured,
    control.pod_container_no_argument_hostname_override_configured,
    control.pod_template_container_no_argument_hostname_override_configured,
    control.replicaset_container_no_argument_hostname_override_configured,
    control.replication_controller_container_no_argument_hostname_override_configured,
    control.statefulset_container_no_argument_hostname_override_configured
  ]

  tags = merge(local.cis_v180_4_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "4.2.7"
    cis_type    = "manual"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_4_2_9" {
  title         = "4.2.9 Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate"
  description   = "Setup TLS connection on the Kubelets."
  documentation = file("./cis_v180/docs/cis_v180_4_2_9.md")
  children = [
    control.cronjob_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured,
    control.daemonset_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured,
    control.deployment_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured,
    control.job_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured,
    control.pod_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured,
    control.replicaset_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured,
    control.replication_controller_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured,
    control.statefulset_container_argument_kubelet_tls_cert_file_and_tls_private_key_file_configured
  ]

  tags = merge(local.cis_v180_4_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "4.2.9"
    cis_type    = "manual"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_4_2_10" {
  title         = "4.2.10 Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate"
  description   = "Setup TLS connection on the Kubelets."
  documentation = file("./cis_v180/docs/cis_v180_4_2_10.md")
  children = [
    control.cronjob_container_rotate_certificate_enabled,
    control.daemonset_container_rotate_certificate_enabled,
    control.deployment_container_rotate_certificate_enabled,
    control.job_container_rotate_certificate_enabled,
    control.pod_container_rotate_certificate_enabled,
    control.pod_template_container_rotate_certificate_enabled,
    control.replicaset_container_rotate_certificate_enabled,
    control.replication_controller_container_rotate_certificate_enabled,
    control.statefulset_container_rotate_certificate_enabled
  ]

  tags = merge(local.cis_v180_4_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "4.2.10"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}
