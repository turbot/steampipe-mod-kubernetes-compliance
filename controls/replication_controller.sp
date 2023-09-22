locals {
  replication_controller_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/ReplicationController"
  })
}

control "replication_controller_cpu_limit" {
  title       = replace(local.container_cpu_limit_title, "__KIND__", "ReplicationController")
  description = replace(local.container_cpu_limit_desc, "__KIND__", "ReplicationController")
  query       = query.replication_controller_cpu_limit

  tags = merge(local.replication_controller_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "replication_controller_cpu_request" {
  title       = replace(local.container_cpu_request_title, "__KIND__", "ReplicationController")
  description = replace(local.container_cpu_request_desc, "__KIND__", "ReplicationController")
  query       = query.replication_controller_cpu_request

  tags = merge(local.replication_controller_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "replication_controller_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "ReplicationController")
  description = replace(local.container_memory_limit_desc, "__KIND__", "ReplicationController")
  query       = query.replication_controller_memory_limit

  tags = merge(local.replication_controller_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "replication_controller_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "ReplicationController")
  description = replace(local.container_memory_request_desc, "__KIND__", "ReplicationController")
  query       = query.replication_controller_memory_request

  tags = merge(local.replication_controller_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "replication_controller_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "ReplicationController")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "ReplicationController")
  query       = query.replication_controller_container_privilege_disabled

  tags = merge(local.replication_controller_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "replication_controller_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "ReplicationController")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "ReplicationController")
  query       = query.replication_controller_container_privilege_escalation_disabled

  tags = merge(local.replication_controller_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "replication_controller_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "ReplicationController")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "ReplicationController")
  query       = query.replication_controller_host_network_access_disabled

  tags = merge(local.replication_controller_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "replication_controller_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "ReplicationController")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "ReplicationController")
  query       = query.replication_controller_hostpid_hostipc_sharing_disabled

  tags = merge(local.replication_controller_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "replication_controller_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "ReplicationController")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "ReplicationController")
  query       = query.replication_controller_immutable_container_filesystem

  tags = merge(local.replication_controller_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "replication_controller_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "ReplicationController")
  description = replace(local.non_root_container_desc, "__KIND__", "ReplicationController")
  query       = query.replication_controller_non_root_container

  tags = merge(local.replication_controller_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "replication_controller_container_readiness_probe" {
  title       = "ReplicationController containers should have readiness probe"
  description = "Containers in ReplicationController definition should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill it’s work."
  query       = query.replication_controller_container_readiness_probe

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_liveness_probe" {
  title       = "ReplicationController containers should have liveness probe"
  description = "Containers in ReplicationController definition should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  query       = query.replication_controller_container_liveness_probe

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_privilege_port_mapped" {
  title       = "ReplicationController containers should not be mapped with privilege ports"
  description = "Privileged ports `0 to 1024` should not be mapped with ReplicationController containers. Normal users and processes are not allowed to use them for various security reasons."
  query       = query.replication_controller_container_privilege_port_mapped

  tags = local.replication_controller_common_tags
}

control "replication_controller_default_namespace_used" {
  title       = "ReplicationController definition should not use default namespace"
  description = "Default namespace should not be used by ReplicationController definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.replication_controller_default_namespace_used

  tags = merge(local.replication_controller_common_tags, {
    cis = "true"
  })
}

control "replication_controller_default_seccomp_profile_enabled" {
  title       = "Seccomp profile is set to docker/default in your Replication Controller definition"
  description = "In Replication Controller definition seccomp profile should be set to docker/default. Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  query       = query.replication_controller_default_seccomp_profile_enabled

  tags = merge(local.replication_controller_common_tags, {
    cis = "true"
  })
}

control "replication_controller_container_with_added_capabilities" {
  title       = "Replication Controller containers should minimize the admission of containers with added capability"
  description = "Container in Replication Controller should minimize the admission of containers with added capability. Adding capabilities to container increases the risk of container breakout."
  query       = query.replication_controller_container_with_added_capabilities

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_security_context_exists" {
  title       = "Replication Controller containers should have securityContext defined"
  description = "This check ensures that the container is running with a defined security context."
  query       = query.replication_controller_container_security_context_exists

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_image_tag_specified" {
  title       = "Replication Controller containers have image tag specified which should be fixed not latest or blank"
  description = "This check ensures that the container in the Replication Controller has image tag fixed not latest or blank."
  query       = query.replication_controller_container_image_tag_specified

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_image_pull_policy_always" {
  title       = "Replication Controller containers has image pull policy set to Always"
  description = "This check ensures that the container in the Replication Controller has image pull policy set to Always."
  query       = query.replication_controller_container_image_pull_policy_always

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_admission_capability_restricted" {
  title       = "Replication Controller containers should has admission capability restricted"
  description = "This check ensures that the container in the Replication Controller has admission capability restricted."
  query       = query.replication_controller_container_admission_capability_restricted

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_encryption_providers_configured" {
  title       = "Replication Controller containers should has encryption providers configured appropriately"
  description = "This check ensures that the container in the Replication Controller has encryption providers configured appropriately."
  query       = query.replication_controller_container_encryption_providers_configured

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_sys_admin_capability_disabled" {
  title       = "Replication Controller containers should not use CAP_SYS_ADMIN linux capability"
  description = "This check ensures that the container in the Replication Controller does not use CAP_SYS_ADMIN Linux capability."
  query       = query.replication_controller_container_sys_admin_capability_disabled

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_capabilities_drop_all" {
  title       = "Replication Controller containers should minimize its admission with capabilities assigned"
  description = "This check ensures that the container in the Replication Controller minimizes its admission with capabilities assigned."
  query       = query.replication_controller_container_capabilities_drop_all

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_arg_peer_client_cert_auth_enabled" {
  title       = "Replication Controller containers peer client cert auth should be enabled"
  description = "This check ensures that the container in the Replication Controller has peer client cert auth enabled."
  query       = query.replication_controller_container_arg_peer_client_cert_auth_enabled

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_rotate_certificate_enabled" {
  title       = "Replication Controller containers certificate rotation should be enabled"
  description = "This check ensures that the container in the Replication Controller has certificate rotation enabled."
  query       = query.replication_controller_container_rotate_certificate_enabled

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_event_qps_less_than_5" {
  title       = "Replication Controller containers argument event qps should be less than 5"
  description = "This check ensures that the container in the Replication Controller has argument event qps set to less than 5."
  query       = query.replication_controller_container_argument_event_qps_less_than_5

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_anonymous_auth_disabled" {
  title       = "Replication Controller containers argument anonymous auth should be disabled"
  description = "This check ensures that the container in the Replication Controller has anonymous auth disabled."
  query       = query.replication_controller_container_argument_anonymous_auth_disabled

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_audit_log_path_configured" {
  title       = "Replication Controller containers should have audit log path configured appropriately"
  description = "This check ensures that the container in the Replication Controller has audit log path configured appropriately."
  query       = query.replication_controller_container_argument_audit_log_path_configured

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_audit_log_maxage_greater_than_30" {
  title       = "Replication Controller containers should have audit log max-age set to 30 or greater"
  description = "This check ensures that the container in the Replication Controller has audit log max-age set to 30 or greater."
  query       = query.replication_controller_container_argument_audit_log_maxage_greater_than_30

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_audit_log_maxbackup_greater_than_10" {
  title       = "Replication Controller containers should have audit log max backup set to 10 or greater"
  description = "This check ensures that the container in the Replication Controller has audit log max backup set to 10 or greater."
  query       = query.replication_controller_container_argument_audit_log_maxbackup_greater_than_10

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_audit_log_maxsize_greater_than_100" {
  title       = "Replication Controller containers should have audit log max size set to 100 or greater"
  description = "This check ensures that the container in the Replication Controller has audit log max size set to 100 or greater."
  query       = query.replication_controller_container_argument_audit_log_maxsize_greater_than_100

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_no_argument_basic_auth_file" {
  title       = "Replication Controller containers argument basic auth file should not be set"
  description = "This check ensures that the container in the Replication Controller does not have an argument basic auth file set."
  query       = query.replication_controller_container_no_argument_basic_auth_file

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_etcd_cafile_configured" {
  title       = "Replication Controller containers argument etcd cafile should be set"
  description = "This check ensures that the container in the Replication Controller has argument etcd cafile set."
  query       = query.replication_controller_container_argument_etcd_cafile_configured

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_authorization_mode_node" {
  title       = "Replication Controller containers argument authorization mode should have node"
  description = "This check ensures that the container in the Replication Controller has node included in the argument authorization mode."
  query       = query.replication_controller_container_argument_authorization_mode_node

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_authorization_mode_no_always_allow" {
  title       = "Replication Controller containers argument authorization mode should not be set to 'always allow'"
  description = "This check ensures that the container in the Replication Controller has argument authorization mode not set to 'always allow'."
  query       = query.replication_controller_container_argument_authorization_mode_no_always_allow

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_authorization_mode_rbac" {
  title       = "Replication Controller containers argument authorization mode should have RBAC"
  description = "This check ensures that the container in the Replication Controller has RBAC included in the argument authorization mode."
  query       = query.replication_controller_container_argument_authorization_mode_rbac

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_no_argument_insecure_bind_address" {
  title       = "Replication Controller containers argument insecure bind address should not be set"
  description = "This check ensures that the container in the Replication Controller does not have an argument insecure bind address set."
  query       = query.replication_controller_container_no_argument_insecure_bind_address

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_kubelet_https_enabled" {
  title       = "Replication Controller containers argument kubelet HTTPS should be enabled"
  description = "This check ensures that the container in the Replication Controller has kubelet HTTPS argument enabled."
  query       = query.replication_controller_container_argument_kubelet_https_enabled

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_insecure_port_0" {
  title       = "Replication Controller containers argument insecure port should be set to 0"
  description = "This check ensures that the container in the Replication Controller has insecure port set to 0."
  query       = query.replication_controller_container_argument_insecure_port_0

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_kubelet_client_certificate_and_key_configured" {
  title       = "Replication Controller containers argument kubelet client certificate and key should be configured"
  description = "This check ensures that the container in the Replication Controller has kubelet client certificate and key argument configured."
  query       = query.replication_controller_container_argument_kubelet_client_certificate_and_key_configured

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_argument_etcd_certfile_and_keyfile_configured" {
  title       = "Replication Controller containers argument etcd certfile and keyfile should be configured"
  description = "This check ensures that the container in the Replication Controller has etcd certfile and keyfile argument configured."
  query       = query.replication_controller_container_argument_etcd_certfile_and_keyfile_configured

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_admission_control_plugin_always_pull_images" {
  title       = "Replication Controller containers admission control plugin should be set to 'always pull images'"
  description = "This check ensures that the container in the Replication Controller has 'always pull images' configured for admission control plugin."
  query       = query.replication_controller_container_admission_control_plugin_always_pull_images

  tags = local.replication_controller_common_tags
}

control "replication_controller_container_admission_control_plugin_no_always_admit" {
  title       = "Replication Controlle containers admission control plugin should not be set to 'always admit'"
  description = "This check ensures that the container in the Replication Controlle has an admission control plugin not set to 'always admit'."
  query       = query.replication_controller_container_admission_control_plugin_no_always_admit

  tags = local.replication_controller_common_tags
}
