locals {
  cis_v180_1_common_tags = merge(local.cis_v180_common_tags, {
    cis_section_id = "1"
  })
}

locals {
  cis_v180_1_2_common_tags = merge(local.cis_v180_1_common_tags, {
    cis_section_id = "1.2"
  })

  cis_v180_1_3_common_tags = merge(local.cis_v180_1_common_tags, {
    cis_section_id = "1.3"
  })

  cis_v180_1_4_common_tags = merge(local.cis_v180_1_common_tags, {
    cis_section_id = "1.4"
  })
}

benchmark "cis_v180_1" {
  title       = "1 Control Plane Components"
  description = "This section consists of security recommendations for the direct configuration of Kubernetes control plane processes. These recommendations may not be directly applicable for cluster operators in environments where these components are managed by a 3rd party"
  children = [
    benchmark.cis_v180_1_2,
    benchmark.cis_v180_1_3,
    benchmark.cis_v180_1_4
  ]

  tags = merge(local.cis_v180_1_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v180_1_2" {
  title         = "1.2 API Server"
  description   = "This section contains recommendations relating to API server configuration flags."
  documentation = file("./cis_v180/docs/cis_v180_1_2.md")
  children = [
    benchmark.cis_v180_1_2_1,
    benchmark.cis_v180_1_2_2,
    benchmark.cis_v180_1_2_4,
    benchmark.cis_v180_1_2_5,
    benchmark.cis_v180_1_2_6,
    benchmark.cis_v180_1_2_7,
    benchmark.cis_v180_1_2_8,
    benchmark.cis_v180_1_2_10,
    benchmark.cis_v180_1_2_11,
    benchmark.cis_v180_1_2_13,
    benchmark.cis_v180_1_2_14,
    benchmark.cis_v180_1_2_15,
    benchmark.cis_v180_1_2_16,
    benchmark.cis_v180_1_2_17,
    benchmark.cis_v180_1_2_18,
    benchmark.cis_v180_1_2_19,
    benchmark.cis_v180_1_2_20,
    benchmark.cis_v180_1_2_21,
    benchmark.cis_v180_1_2_22,
    benchmark.cis_v180_1_2_23,
    benchmark.cis_v180_1_2_24,
    benchmark.cis_v180_1_2_25,
    benchmark.cis_v180_1_2_27,
    benchmark.cis_v180_1_2_28,
    benchmark.cis_v180_1_2_30
  ]

  tags = merge(local.cis_v180_1_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v180_1_2_1" {
  title         = "1.2.1 Ensure that the --anonymous-auth argument is set to false"
  description   = "Disable anonymous requests to the API server."
  documentation = file("./cis_v180/docs/cis_v180_1_2_1.md")
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

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.1"
    cis_type    = "manual"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_2" {
  title         = "1.2.2 Ensure that the --token-auth-file parameter is not set"
  description   = "Do not use token based authentication."
  documentation = file("./cis_v180/docs/cis_v180_1_2_2.md")
  children = [
    control.cronjob_container_token_auth_file_not_configured,
    control.daemonset_container_token_auth_file_not_configured,
    control.deployment_container_token_auth_file_not_configured,
    control.job_container_token_auth_file_not_configured,
    control.pod_template_container_token_auth_file_not_configured,
    control.pod_container_token_auth_file_not_configured,
    control.replicaset_container_token_auth_file_not_configured,
    control.replication_controller_container_token_auth_file_not_configured,
    control.statefulset_container_token_auth_file_not_configured
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.2"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_4" {
  title         = "1.2.4 Ensure that the --kubelet-client-certificate and --kubeletclient-key arguments are set as appropriate"
  description   = "Enable certificate based kubelet authentication."
  documentation = file("./cis_v180/docs/cis_v180_1_2_4.md")
  children = [
    control.cronjob_container_argument_kubelet_client_certificate_and_key_configured,
    control.daemonset_container_argument_kubelet_client_certificate_and_key_configured,
    control.deployment_container_argument_kubelet_client_certificate_and_key_configured,
    control.job_container_argument_kubelet_client_certificate_and_key_configured,
    control.pod_template_container_argument_kubelet_client_certificate_and_key_configured,
    control.pod_container_argument_kubelet_client_certificate_and_key_configured,
    control.replicaset_container_argument_kubelet_client_certificate_and_key_configured,
    control.replication_controller_container_argument_kubelet_client_certificate_and_key_configured,
    control.statefulset_container_argument_kubelet_client_certificate_and_key_configured
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.4"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_5" {
  title         = "1.2.5 Ensure that the --kubelet-certificate-authority argument is set as appropriate"
  description   = "Verify kubelet's certificate before establishing connection."
  documentation = file("./cis_v180/docs/cis_v180_1_2_5.md")
  children = [
    control.cronjob_container_kubelet_certificate_authority_configured,
    control.daemonset_container_kubelet_certificate_authority_configured,
    control.deployment_container_kubelet_certificate_authority_configured,
    control.job_container_kubelet_certificate_authority_configured,
    control.pod_template_container_kubelet_certificate_authority_configured,
    control.pod_container_kubelet_certificate_authority_configured,
    control.replicaset_container_kubelet_certificate_authority_configured,
    control.replication_controller_container_kubelet_certificate_authority_configured,
    control.statefulset_container_kubelet_certificate_authority_configured
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.5"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_6" {
  title         = "1.2.6 Ensure that the --authorization-mode argument is not set to AlwaysAllow"
  description   = "Do not always authorize all requests."
  documentation = file("./cis_v180/docs/cis_v180_1_2_6.md")
  children = [
    control.cronjob_container_argument_authorization_mode_no_always_allow,
    control.daemonset_container_argument_authorization_mode_no_always_allow,
    control.deployment_container_argument_authorization_mode_no_always_allow,
    control.job_container_argument_authorization_mode_no_always_allow,
    control.pod_template_container_argument_authorization_mode_no_always_allow,
    control.pod_container_argument_authorization_mode_no_always_allow,
    control.replicaset_container_argument_authorization_mode_no_always_allow,
    control.replication_controller_container_argument_authorization_mode_no_always_allow,
    control.statefulset_container_argument_authorization_mode_no_always_allow
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.5"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_7" {
  title         = "1.2.7 Ensure that the --authorization-mode argument includes Node"
  description   = "Restrict kubelet nodes to reading only objects associated with them."
  documentation = file("./cis_v180/docs/cis_v180_1_2_7.md")
  children = [
    control.cronjob_container_argument_authorization_mode_node,
    control.daemonset_container_argument_authorization_mode_node,
    control.deployment_container_argument_authorization_mode_node,
    control.job_container_argument_authorization_mode_node,
    control.pod_template_container_argument_authorization_mode_node,
    control.pod_container_argument_authorization_mode_node,
    control.replicaset_container_argument_authorization_mode_node,
    control.replication_controller_container_argument_authorization_mode_node,
    control.statefulset_container_argument_authorization_mode_node
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.7"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_8" {
  title         = "1.2.8 Ensure that the --authorization-mode argument includes RBAC"
  description   = "Turn on Role Based Access Control."
  documentation = file("./cis_v180/docs/cis_v180_1_2_8.md")
  children = [
    control.cronjob_container_argument_authorization_mode_rbac,
    control.daemonset_container_argument_authorization_mode_rbac,
    control.deployment_container_argument_authorization_mode_rbac,
    control.job_container_argument_authorization_mode_rbac,
    control.pod_template_container_argument_authorization_mode_rbac,
    control.pod_container_argument_authorization_mode_rbac,
    control.replicaset_container_argument_authorization_mode_rbac,
    control.replication_controller_container_argument_authorization_mode_rbac,
    control.statefulset_container_argument_authorization_mode_rbac
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.8"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_10" {
  title         = "1.2.10 Ensure that the admission control plugin AlwaysAdmit is not set"
  description   = "Do not allow all requests."
  documentation = file("./cis_v180/docs/cis_v180_1_2_10.md")
  children = [
    control.cronjob_container_admission_control_plugin_no_always_admit,
    control.daemonset_container_admission_control_plugin_no_always_admit,
    control.deployment_container_admission_control_plugin_no_always_admit,
    control.job_container_admission_control_plugin_no_always_admit,
    control.pod_template_container_admission_control_plugin_no_always_admit,
    control.pod_container_admission_control_plugin_no_always_admit,
    control.replicaset_container_admission_control_plugin_no_always_admit,
    control.replication_controller_container_admission_control_plugin_no_always_admit,
    control.statefulset_container_admission_control_plugin_no_always_admit
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.10"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_11" {
  title         = "1.2.11 Ensure that the admission control plugin AlwaysPullImages is set"
  description   = "Always pull images."
  documentation = file("./cis_v180/docs/cis_v180_1_2_11.md")
  children = [
    control.cronjob_container_admission_control_plugin_always_pull_images,
    control.daemonset_container_admission_control_plugin_always_pull_images,
    control.deployment_container_admission_control_plugin_always_pull_images,
    control.job_container_admission_control_plugin_always_pull_images,
    control.pod_template_container_admission_control_plugin_always_pull_images,
    control.pod_container_admission_control_plugin_always_pull_images,
    control.replicaset_container_admission_control_plugin_always_pull_images,
    control.replication_controller_container_admission_control_plugin_always_pull_images,
    control.statefulset_container_admission_control_plugin_always_pull_images
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.11"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_13" {
  title         = "1.2.13 Ensure that the admission control plugin ServiceAccount is set"
  description   = "Automate service accounts management."
  documentation = file("./cis_v180/docs/cis_v180_1_2_13.md")
  children = [
    control.cronjob_container_argument_service_account_enabled,
    control.daemonset_container_argument_service_account_enabled,
    control.deployment_container_argument_service_account_enabled,
    control.job_container_argument_service_account_enabled,
    control.pod_template_container_argument_service_account_enabled,
    control.pod_container_argument_service_account_enabled,
    control.replicaset_container_argument_service_account_enabled,
    control.replication_controller_container_argument_service_account_enabled,
    control.statefulset_container_argument_service_account_enabled
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "2"
    cis_item_id = "1.2.13"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_14" {
  title         = "1.2.14 Ensure that the admission control plugin NamespaceLifecycle is set"
  description   = "Reject creating objects in a namespace that is undergoing termination"
  documentation = file("./cis_v180/docs/cis_v180_1_2_14.md")
  children = [
    control.cronjob_container_argument_namespace_lifecycle_enabled,
    control.daemonset_container_argument_namespace_lifecycle_enabled,
    control.deployment_container_argument_namespace_lifecycle_enabled,
    control.job_container_argument_namespace_lifecycle_enabled,
    control.pod_template_container_argument_namespace_lifecycle_enabled,
    control.pod_container_argument_namespace_lifecycle_enabled,
    control.replicaset_container_argument_namespace_lifecycle_enabled,
    control.replication_controller_container_argument_namespace_lifecycle_enabled,
    control.statefulset_container_argument_namespace_lifecycle_enabled
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "2"
    cis_item_id = "1.2.14"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_15" {
  title         = "1.2.15 Ensure that the admission control plugin NodeRestriction is set"
  description   = "Limit the Node and Pod objects that a kubelet could modify."
  documentation = file("./cis_v180/docs/cis_v180_1_2_15.md")
  children = [
    control.cronjob_container_argument_node_restriction_enabled,
    control.daemonset_container_argument_node_restriction_enabled,
    control.deployment_container_argument_node_restriction_enabled,
    control.job_container_argument_node_restriction_enabled,
    control.pod_template_container_argument_node_restriction_enabled,
    control.pod_container_argument_node_restriction_enabled,
    control.replicaset_container_argument_node_restriction_enabled,
    control.replication_controller_container_argument_node_restriction_enabled,
    control.statefulset_container_argument_node_restriction_enabled
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "2"
    cis_item_id = "1.2.15"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_16" {
  title         = "1.2.16 Ensure that the --profiling argument is set to false "
  description   = "Disable profiling, if not needed."
  documentation = file("./cis_v180/docs/cis_v180_1_2_16.md")
  children = [
    control.cronjob_container_argument_kube_apiserver_profiling_disabled,
    control.daemonset_container_argument_kube_apiserver_profiling_disabled,
    control.deployment_container_argument_kube_apiserver_profiling_disabled,
    control.job_container_argument_kube_apiserver_profiling_disabled,
    control.pod_template_container_argument_kube_apiserver_profiling_disabled,
    control.pod_container_argument_kube_apiserver_profiling_disabled,
    control.replicaset_container_argument_kube_apiserver_profiling_disabled,
    control.replication_controller_container_argument_kube_apiserver_profiling_disabled,
    control.statefulset_container_argument_kube_apiserver_profiling_disabled
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.16"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_17" {
  title         = "1.2.17 Ensure that the --audit-log-path argument is set"
  description   = "Enable auditing on the Kubernetes API Server and set the desired audit log path."
  documentation = file("./cis_v180/docs/cis_v180_1_2_17.md")
  children = [
    control.cronjob_container_argument_audit_log_path_configured,
    control.daemonset_container_argument_audit_log_path_configured,
    control.deployment_container_argument_audit_log_path_configured,
    control.job_container_argument_audit_log_path_configured,
    control.pod_template_container_argument_audit_log_path_configured,
    control.pod_container_argument_audit_log_path_configured,
    control.replicaset_container_argument_audit_log_path_configured,
    control.replication_controller_container_argument_audit_log_path_configured,
    control.statefulset_container_argument_audit_log_path_configured
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.17"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_18" {
  title         = "1.2.18 Ensure that the --audit-log-maxage argument is set to 30 or as appropriate"
  description   = "Retain the logs for at least 30 days or as appropriate."
  documentation = file("./cis_v180/docs/cis_v180_1_2_18.md")
  children = [
    control.cronjob_container_argument_audit_log_maxage_greater_than_30,
    control.daemonset_container_argument_audit_log_maxage_greater_than_30,
    control.deployment_container_argument_audit_log_maxage_greater_than_30,
    control.job_container_argument_audit_log_maxage_greater_than_30,
    control.pod_template_container_argument_audit_log_maxage_greater_than_30,
    control.pod_container_argument_audit_log_maxage_greater_than_30,
    control.replicaset_container_argument_audit_log_maxage_greater_than_30,
    control.replication_controller_container_argument_audit_log_maxage_greater_than_30,
    control.statefulset_container_argument_audit_log_maxage_greater_than_30
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.18"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_19" {
  title         = "1.2.19 Ensure that the --audit-log-maxbackup argument is set to 10 or as appropriate "
  description   = "Retain 10 or an appropriate number of old log files."
  documentation = file("./cis_v180/docs/cis_v180_1_2_19.md")
  children = [
    control.cronjob_container_argument_audit_log_maxbackup_greater_than_10,
    control.daemonset_container_argument_audit_log_maxbackup_greater_than_10,
    control.deployment_container_argument_audit_log_maxbackup_greater_than_10,
    control.job_container_argument_audit_log_maxbackup_greater_than_10,
    control.pod_template_container_argument_audit_log_maxbackup_greater_than_10,
    control.pod_container_argument_audit_log_maxbackup_greater_than_10,
    control.replicaset_container_argument_audit_log_maxbackup_greater_than_10,
    control.replication_controller_container_argument_audit_log_maxbackup_greater_than_10,
    control.statefulset_container_argument_audit_log_maxbackup_greater_than_10
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.19"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_20" {
  title         = "1.2.20 Ensure that the --audit-log-maxsize argument is set to 100 or as appropriate"
  description   = "Rotate log files on reaching 100 MB or as appropriate."
  documentation = file("./cis_v180/docs/cis_v180_1_2_20.md")
  children = [
    control.cronjob_container_argument_audit_log_maxsize_greater_than_100,
    control.daemonset_container_argument_audit_log_maxsize_greater_than_100,
    control.deployment_container_argument_audit_log_maxsize_greater_than_100,
    control.job_container_argument_audit_log_maxsize_greater_than_100,
    control.pod_template_container_argument_audit_log_maxsize_greater_than_100,
    control.pod_container_argument_audit_log_maxsize_greater_than_100,
    control.replicaset_container_argument_audit_log_maxsize_greater_than_100,
    control.replication_controller_container_argument_audit_log_maxsize_greater_than_100,
    control.statefulset_container_argument_audit_log_maxsize_greater_than_100
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.20"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_21" {
  title         = "1.2.21 Ensure that the --request-timeout argument is set as appropriate"
  description   = "Set global request timeout for API server requests as appropriate."
  documentation = file("./cis_v180/docs/cis_v180_1_2_21.md")
  children = [
    control.cronjob_container_argument_request_timeout_appropriate,
    control.daemonset_container_argument_request_timeout_appropriate,
    control.deployment_container_argument_request_timeout_appropriate,
    control.job_container_argument_request_timeout_appropriate,
    control.pod_template_container_argument_request_timeout_appropriate,
    control.pod_container_argument_request_timeout_appropriate,
    control.replicaset_container_argument_request_timeout_appropriate,
    control.replication_controller_container_argument_request_timeout_appropriate,
    control.statefulset_container_argument_request_timeout_appropriate
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.21"
    cis_type    = "manual"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_22" {
  title         = "1.2.22 Ensure that the --service-account-lookup argument is set to true"
  description   = "Validate service account before validating token."
  documentation = file("./cis_v180/docs/cis_v180_1_2_22.md")
  children = [
    control.cronjob_container_argument_service_account_lookup_enabled,
    control.daemonset_container_argument_service_account_lookup_enabled,
    control.deployment_container_argument_service_account_lookup_enabled,
    control.job_container_argument_service_account_lookup_enabled,
    control.pod_template_container_argument_service_account_lookup_enabled,
    control.pod_container_argument_service_account_lookup_enabled,
    control.replicaset_container_argument_service_account_lookup_enabled,
    control.replication_controller_container_argument_service_account_lookup_enabled,
    control.statefulset_container_argument_service_account_lookup_enabled
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.22"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_23" {
  title         = "1.2.23 Ensure that the --service-account-key-file argument is set as appropriate"
  description   = "Explicitly set a service account public key file for service accounts on the apiserver."
  documentation = file("./cis_v180/docs/cis_v180_1_2_23.md")
  children = [
    control.cronjob_container_argument_service_account_key_file_appropriate,
    control.daemonset_container_argument_service_account_key_file_appropriate,
    control.deployment_container_argument_service_account_key_file_appropriate,
    control.job_container_argument_service_account_key_file_appropriate,
    control.pod_template_container_argument_service_account_key_file_appropriate,
    control.pod_container_argument_service_account_key_file_appropriate,
    control.replicaset_container_argument_service_account_key_file_appropriate,
    control.replication_controller_container_argument_service_account_key_file_appropriate,
    control.statefulset_container_argument_service_account_key_file_appropriate
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.23"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_24" {
  title         = "1.2.24 Ensure that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate"
  description   = "etcd should be configured to make use of TLS encryption for client connections."
  documentation = file("./cis_v180/docs/cis_v180_1_2_24.md")
  children = [
    control.cronjob_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.daemonset_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.deployment_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.job_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.pod_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.replicaset_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.replication_controller_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured,
    control.statefulset_container_argument_kube_apiserver_etcd_certfile_and_keyfile_configured
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.24"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_25" {
  title         = "1.2.25 Ensure that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate"
  description   = "Setup TLS connection on the API server."
  documentation = file("./cis_v180/docs/cis_v180_1_2_25.md")
  children = [
    control.cronjob_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured,
    control.daemonset_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured,
    control.deployment_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured,
    control.job_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured,
    control.pod_template_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured,
    control.pod_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured,
    control.replicaset_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured,
    control.replication_controller_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured,
    control.statefulset_container_argument_kube_apiserver_tls_cert_file_and_tls_private_key_file_configured,
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.25"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_27" {
  title         = "1.2.27 Ensure that the --etcd-cafile argument is set as appropriate"
  description   = "etcd should be configured to make use of TLS encryption for client connections."
  documentation = file("./cis_v180/docs/cis_v180_1_2_27.md")
  children = [
    control.cronjob_container_argument_etcd_cafile_configured,
    control.daemonset_container_argument_etcd_cafile_configured,
    control.deployment_container_argument_etcd_cafile_configured,
    control.job_container_argument_etcd_cafile_configured,
    control.pod_template_container_argument_etcd_cafile_configured,
    control.pod_container_argument_etcd_cafile_configured,
    control.replicaset_container_argument_etcd_cafile_configured,
    control.replication_controller_container_argument_etcd_cafile_configured,
    control.statefulset_container_argument_etcd_cafile_configured,
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.27"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_28" {
  title         = "1.2.28 Ensure that the --encryption-provider-config argument is set as appropriate "
  description   = "Encrypt etcd key-value store."
  documentation = file("./cis_v180/docs/cis_v180_1_2_28.md")
  children = [
    control.cronjob_container_encryption_providers_configured,
    control.daemonset_container_encryption_providers_configured,
    control.deployment_container_encryption_providers_configured,
    control.job_container_encryption_providers_configured,
    control.pod_template_container_encryption_providers_configured,
    control.pod_container_encryption_providers_configured,
    control.replicaset_container_encryption_providers_configured,
    control.replication_controller_container_encryption_providers_configured,
    control.statefulset_container_encryption_providers_configured,
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.28"
    cis_type    = "manual"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_2_30" {
  title         = "1.2.30 Ensure that the API Server only makes use of Strong Cryptographic Ciphers"
  description   = "Ensure that the API server is configured to only use strong cryptographic ciphers."
  documentation = file("./cis_v180/docs/cis_v180_1_2_30.md")
  children = [
    control.cronjob_container_strong_kube_apiserver_cryptographic_ciphers,
    control.daemonset_container_strong_kube_apiserver_cryptographic_ciphers,
    control.deployment_container_strong_kube_apiserver_cryptographic_ciphers,
    control.job_container_strong_kube_apiserver_cryptographic_ciphers,
    control.pod_template_container_strong_kube_apiserver_cryptographic_ciphers,
    control.pod_container_strong_kube_apiserver_cryptographic_ciphers,
    control.replicaset_container_strong_kube_apiserver_cryptographic_ciphers,
    control.replication_controller_container_strong_kube_apiserver_cryptographic_ciphers,
    control.statefulset_container_strong_kube_apiserver_cryptographic_ciphers,
  ]

  tags = merge(local.cis_v180_1_2_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.2.30"
    cis_type    = "manual"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_3" {
  title         = "1.3 Controller Manager"
  description   = "This section contains recommendations relating to Controller Manager configuration flags."
  documentation = file("./cis_v180/docs/cis_v180_1_3.md")
  children = [
    benchmark.cis_v180_1_3_2,
    benchmark.cis_v180_1_3_3,
    benchmark.cis_v180_1_3_4,
    benchmark.cis_v180_1_3_5,
    benchmark.cis_v180_1_3_6,
    benchmark.cis_v180_1_3_7
  ]

  tags = merge(local.cis_v180_1_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v180_1_3_2" {
  title         = "1.3.2 Ensure that the --profiling argument is set to false"
  description   = "Disable profiling, if not needed."
  documentation = file("./cis_v180/docs/cis_v180_1_3_2.md")
  children = [
    control.cronjob_container_argument_kube_controller_manager_profiling_disabled,
    control.daemonset_container_argument_kube_controller_manager_profiling_disabled,
    control.deployment_container_argument_kube_controller_manager_profiling_disabled,
    control.job_container_argument_kube_controller_manager_profiling_disabled,
    control.pod_template_container_argument_kube_controller_manager_profiling_disabled,
    control.pod_container_argument_kube_controller_manager_profiling_disabled,
    control.replicaset_container_argument_kube_controller_manager_profiling_disabled,
    control.replication_controller_container_argument_kube_controller_manager_profiling_disabled,
    control.statefulset_container_argument_kube_controller_manager_profiling_disabled,
  ]

  tags = merge(local.cis_v180_1_3_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.3.2"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_3_3" {
  title         = "1.3.3 Ensure that the --use-service-account-credentials argument is set to true"
  description   = "Use individual service account credentials for each controller."
  documentation = file("./cis_v180/docs/cis_v180_1_3_3.md")
  children = [
    control.cronjob_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.daemonset_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.deployment_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.job_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.pod_template_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.pod_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.replicaset_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.replication_controller_container_argument_kube_controller_manager_service_account_credentials_enabled,
    control.statefulset_container_argument_kube_controller_manager_service_account_credentials_enabled,
  ]

  tags = merge(local.cis_v180_1_3_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.3.4"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_3_4" {
  title         = "1.3.4 Ensure that the --service-account-private-key-file argument is set as appropriate "
  description   = "Explicitly set a service account private key file for service accounts on the controller manager."
  documentation = file("./cis_v180/docs/cis_v180_1_3_4.md")
  children = [
    control.cronjob_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.daemonset_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.deployment_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.job_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.pod_template_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.pod_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.replicaset_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.replication_controller_container_argument_kube_controller_manager_service_account_private_key_file_configured,
    control.statefulset_container_argument_kube_controller_manager_service_account_private_key_file_configured,
  ]

  tags = merge(local.cis_v180_1_3_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.3.4"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_3_5" {
  title         = "1.3.5 Ensure that the --root-ca-file argument is set as appropriate"
  description   = "Allow pods to verify the API server's serving certificate before establishing connections."
  documentation = file("./cis_v180/docs/cis_v180_1_3_5.md")
  children = [
    control.cronjob_container_argument_kube_controller_manager_root_ca_file_configured,
    control.daemonset_container_argument_kube_controller_manager_root_ca_file_configured,
    control.deployment_container_argument_kube_controller_manager_root_ca_file_configured,
    control.job_container_argument_kube_controller_manager_root_ca_file_configured,
    control.pod_template_container_argument_kube_controller_manager_root_ca_file_configured,
    control.pod_container_argument_kube_controller_manager_root_ca_file_configured,
    control.replicaset_container_argument_kube_controller_manager_root_ca_file_configured,
    control.replication_controller_container_argument_kube_controller_manager_root_ca_file_configured,
    control.statefulset_container_argument_kube_controller_manager_root_ca_file_configured,
  ]

  tags = merge(local.cis_v180_1_3_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.3.5"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_3_6" {
  title         = "1.3.6 Ensure that the RotateKubeletServerCertificate argument is set to true"
  description   = "Enable kubelet server certificate rotation on controller-manager."
  documentation = file("./cis_v180/docs/cis_v180_1_3_6.md")
  children = [
    control.cronjob_container_argument_rotate_kubelet_server_certificate_enabled,
    control.daemonset_container_argument_rotate_kubelet_server_certificate_enabled,
    control.deployment_container_argument_rotate_kubelet_server_certificate_enabled,
    control.job_container_argument_rotate_kubelet_server_certificate_enabled,
    control.pod_template_container_argument_rotate_kubelet_server_certificate_enabled,
    control.pod_container_argument_rotate_kubelet_server_certificate_enabled,
    control.replicaset_container_argument_rotate_kubelet_server_certificate_enabled,
    control.replication_controller_container_argument_rotate_kubelet_server_certificate_enabled,
    control.statefulset_container_argument_rotate_kubelet_server_certificate_enabled,
  ]

  tags = merge(local.cis_v180_1_3_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.3.6"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_3_7" {
  title         = "1.3.7 Ensure that the --bind-address argument is set to 127.0.0.1 "
  description   = "Do not bind the Controller Manager service to non-loopback insecure addresses."
  documentation = file("./cis_v180/docs/cis_v180_1_3_7.md")
  children = [
    control.cronjob_container_argument_kube_controller_manager_bind_address_127_0_0_1,
    control.daemonset_container_argument_kube_controller_manager_bind_address_127_0_0_1,
    control.deployment_container_argument_kube_controller_manager_bind_address_127_0_0_1,
    control.job_container_argument_kube_controller_manager_bind_address_127_0_0_1,
    control.pod_template_container_argument_kube_controller_manager_bind_address_127_0_0_1,
    control.pod_container_argument_kube_controller_manager_bind_address_127_0_0_1,
    control.replicaset_container_argument_kube_controller_manager_bind_address_127_0_0_1,
    control.replication_controller_container_argument_kube_controller_manager_bind_address_127_0_0_1,
    control.statefulset_container_argument_kube_controller_manager_bind_address_127_0_0_1,
  ]

  tags = merge(local.cis_v180_1_3_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.3.7"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}

benchmark "cis_v180_1_4" {
  title         = "1.4 Scheduler"
  description   = "This section contains recommendations relating to Scheduler configuration flags."
  documentation = file("./cis_v180/docs/cis_v180_1_4.md")
  children = [
    benchmark.cis_v180_1_4_1
  ]

  tags = merge(local.cis_v180_1_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cis_v180_1_4_1" {
  title         = "1.4.1 Ensure that the --profiling argument is set to false"
  description   = "Disable profiling, if not needed."
  documentation = file("./cis_v180/docs/cis_v180_1_4_1.md")
  children = [
    control.cronjob_container_argument_kube_scheduler_profiling_disabled,
    control.daemonset_container_argument_kube_scheduler_profiling_disabled,
    control.deployment_container_argument_kube_scheduler_profiling_disabled,
    control.job_container_argument_kube_scheduler_profiling_disabled,
    control.pod_template_container_argument_kube_scheduler_profiling_disabled,
    control.pod_container_argument_kube_scheduler_profiling_disabled,
    control.replicaset_container_argument_kube_scheduler_profiling_disabled,
    control.replication_controller_container_argument_kube_scheduler_profiling_disabled,
    control.statefulset_container_argument_kube_scheduler_profiling_disabled,
  ]

  tags = merge(local.cis_v180_1_4_common_tags, {
    cis_level   = "1"
    cis_item_id = "1.4.1"
    cis_type    = "automated"
    type        = "Benchmark"
  })
}