locals {
  cis_v180_2_common_tags = merge(local.cis_v180_common_tags, {
    cis_section_id = "2"
  })
}

benchmark "cis_v180_2" {
  title       = "2 etcd"
  description = "This section covers recommendations for etcd configuration. This sections assumes you're running etcd in a Kubernetes pod. If you are running etcd externally the file paths, audit and remediation process my vary."
  children = [
    benchmark.cis_v180_2_1,
    benchmark.cis_v180_2_2,
    benchmark.cis_v180_2_3,
    benchmark.cis_v180_2_4,
  ]

  tags = merge(local.cis_v180_2_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v180_2_1" {
  title         = "2.1 Ensure that the --cert-file and --key-file arguments are set as appropriate"
  description   = "Configure TLS encryption for the etcd service."
  documentation = file("./cis_v180/docs/cis_v180_2_1.md")
  children = [
    control.cronjob_container_argument_etcd_certfile_and_keyfile_configured,
    control.daemonset_container_argument_etcd_certfile_and_keyfile_configured,
    control.deployment_container_argument_etcd_certfile_and_keyfile_configured,
    control.job_container_argument_etcd_certfile_and_keyfile_configured,
    control.pod_container_argument_etcd_certfile_and_keyfile_configured,
    control.pod_template_container_argument_etcd_certfile_and_keyfile_configured,
    control.replicaset_container_argument_etcd_certfile_and_keyfile_configured,
    control.replication_controller_container_argument_etcd_certfile_and_keyfile_configured,
    control.statefulset_container_argument_etcd_certfile_and_keyfile_configured,
  ]

  tags = merge(local.cis_v180_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "2.1"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_2_2" {
  title         = "2.2 Ensure that the --client-cert-auth argument is set to true "
  description   = "Enable client authentication on etcd service."
  documentation = file("./cis_v180/docs/cis_v180_2_2.md")
  children = [
    control.cronjob_container_argument_etcd_client_cert_auth_enabled,
    control.daemonset_container_argument_etcd_client_cert_auth_enabled,
    control.deployment_container_argument_etcd_client_cert_auth_enabled,
    control.job_container_argument_etcd_client_cert_auth_enabled,
    control.pod_container_argument_etcd_client_cert_auth_enabled,
    control.pod_template_container_argument_etcd_client_cert_auth_enabled,
    control.replicaset_container_argument_etcd_client_cert_auth_enabled,
    control.replication_controller_container_argument_etcd_client_cert_auth_enabled,
    control.statefulset_container_argument_etcd_client_cert_auth_enabled,
  ]

  tags = merge(local.cis_v180_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "2.2"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_2_3" {
  title         = "2.3 Ensure that the --auto-tls argument is not set to true"
  description   = "Do not use self-signed certificates for TLS."
  documentation = file("./cis_v180/docs/cis_v180_2_3.md")
  children = [
    control.cronjob_container_argument_etcd_auto_tls_disabled,
    control.daemonset_container_argument_etcd_auto_tls_disabled,
    control.deployment_container_argument_etcd_auto_tls_disabled,
    control.job_container_argument_etcd_auto_tls_disabled,
    control.pod_container_argument_etcd_auto_tls_disabled,
    control.pod_template_container_argument_etcd_auto_tls_disabled,
    control.replicaset_container_argument_etcd_auto_tls_disabled,
    control.replication_controller_container_argument_etcd_auto_tls_disabled,
    control.statefulset_container_argument_etcd_auto_tls_disabled,
  ]

  tags = merge(local.cis_v180_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "2.3"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_2_4" {
  title         = "2.4 Ensure that the --peer-cert-file and --peer-key-file arguments are set as appropriate"
  description   = "etcd should be configured to make use of TLS encryption for peer connections."
  documentation = file("./cis_v180/docs/cis_v180_2_4.md")
  children = [
    control.cronjob_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.daemonset_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.deployment_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.job_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.pod_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.pod_template_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.replicaset_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.replication_controller_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
    control.statefulset_container_argument_etcd_peer_certfile_and_peer_keyfile_configured,
  ]

  tags = merge(local.cis_v180_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "2.4"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_2_5" {
  title         = "2.5 Ensure that the --peer-client-cert-auth argument is set to true "
  description   = "etcd should be configured for peer authentication."
  documentation = file("./cis_v180/docs/cis_v180_2_5.md")
  children = [
    control.cronjob_container_arg_peer_client_cert_auth_enabled,
    control.daemonset_container_arg_peer_client_cert_auth_enabled,
    control.deployment_container_arg_peer_client_cert_auth_enabled,
    control.job_container_arg_peer_client_cert_auth_enabled,
    control.pod_container_arg_peer_client_cert_auth_enabled,
    control.replicaset_container_arg_peer_client_cert_auth_enabled,
    control.replication_controller_container_arg_peer_client_cert_auth_enabled,
    control.statefulset_container_arg_peer_client_cert_auth_enabled,
  ]

  tags = merge(local.cis_v180_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "2.5"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}


