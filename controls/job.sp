locals {
  job_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Job"
  })
}

control "job_cpu_limit" {
  title       = replace(local.container_cpu_limit_title, "__KIND__", "Job")
  description = replace(local.container_cpu_limit_desc, "__KIND__", "Job")
  query       = query.job_cpu_limit

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_cpu_request" {
  title       = replace(local.container_cpu_request_title, "__KIND__", "Job")
  description = replace(local.container_cpu_request_desc, "__KIND__", "Job")
  query       = query.job_cpu_request

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_memory_limit" {
  title       = replace(local.container_memory_limit_title, "__KIND__", "Job")
  description = replace(local.container_memory_limit_desc, "__KIND__", "Job")
  query       = query.job_memory_limit

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_memory_request" {
  title       = replace(local.container_memory_request_title, "__KIND__", "Job")
  description = replace(local.container_memory_request_desc, "__KIND__", "Job")
  query       = query.job_memory_request

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_container_privilege_disabled" {
  title       = replace(local.container_privilege_disabled_title, "__KIND__", "Job")
  description = replace(local.container_privilege_disabled_desc, "__KIND__", "Job")
  query       = query.job_container_privilege_disabled

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_container_privilege_escalation_disabled" {
  title       = replace(local.container_privilege_escalation_disabled_title, "__KIND__", "Job")
  description = replace(local.container_privilege_escalation_disabled_desc, "__KIND__", "Job")
  query       = query.job_container_privilege_escalation_disabled

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_host_network_access_disabled" {
  title       = replace(local.host_network_access_disabled_title, "__KIND__", "Job")
  description = replace(local.host_network_access_disabled_desc, "__KIND__", "Job")
  query       = query.job_host_network_access_disabled

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_hostpid_hostipc_sharing_disabled" {
  title       = replace(local.hostpid_hostipc_sharing_disabled_title, "__KIND__", "Job")
  description = replace(local.hostpid_hostipc_sharing_disabled_desc, "__KIND__", "Job")
  query       = query.job_hostpid_hostipc_sharing_disabled

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_immutable_container_filesystem" {
  title       = replace(local.immutable_container_filesystem_title, "__KIND__", "Job")
  description = replace(local.immutable_container_filesystem_desc, "__KIND__", "Job")
  query       = query.job_immutable_container_filesystem

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_non_root_container" {
  title       = replace(local.non_root_container_title, "__KIND__", "Job")
  description = replace(local.non_root_container_desc, "__KIND__", "Job")
  query       = query.job_non_root_container

  tags = merge(local.job_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "job_container_readiness_probe" {
  title       = "Job containers should have readiness probe"
  description = "Containers in Job definition should have readiness probe. The readiness probes in turn also check dependencies like database connections or other services your container is depending on to fulfill it’s work."
  query       = query.job_container_readiness_probe

  tags = local.job_common_tags
}

control "job_container_liveness_probe" {
  title       = "Job containers should have liveness probe"
  description = "Containers in Job definition should have liveness probe. The liveness probes are to check if the container is started and alive. If this isn’t the case, kubernetes will eventually restart the container."
  query       = query.job_container_liveness_probe

  tags = local.job_common_tags
}

control "job_container_privilege_port_mapped" {
  title       = "Job containers should not be mapped with privilege ports"
  description = "Privileged ports `0 to 1024` should not be mapped with Job containers. Normal users and processes are not allowed to use them for various security reasons."
  query       = query.job_container_privilege_port_mapped

  tags = local.job_common_tags
}

control "job_default_namespace_used" {
  title       = "Job definition should not use default namespace"
  description = "Default namespace should not be used by Job definition. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.job_default_namespace_used

  tags = merge(local.job_common_tags, {
    cis = "true"
  })
}

control "job_default_seccomp_profile_enabled" {
  title       = "Seccomp profile is set to docker/default in Job definition"
  description = "In Job definition seccomp profile should be set to docker/default. Seccomp (secure computing mode) is used to restrict the set of system calls applications can make, allowing cluster administrators greater control over the security of workloads running in the cluster. Kubernetes disables seccomp profiles by default for historical reasons. It should be enabled to ensure that the workloads have restricted actions available within the container."
  query       = query.job_default_seccomp_profile_enabled

  tags = merge(local.job_common_tags, {
    cis = "true"
  })
}

control "job_container_with_added_capabilities" {
  title       = "Job containers should minimize the admission of containers with added capability"
  description = "Containers in Job should minimize the admission of containers with added capability. Adding capabilities to container increases the risk of container breakout."
  query       = query.job_container_with_added_capabilities

  tags = local.job_common_tags
}

control "job_container_security_context_exists" {
  title       = "Job containers should has security context defined"
  description = "This check ensures that the Stateful container is running with a defined security context."
  query       = query.job_container_security_context_exists

  tags = local.job_common_tags
}

control "job_container_image_tag_specified" {
  title       = "Job containers have image tag specified which should be fixed not latest or blank"
  description = "This check ensures that the container in the Job has image tag fixed not latest or blank."
  query       = query.job_container_image_tag_specified

  tags = local.job_common_tags
}

control "job_container_image_pull_policy_always" {
  title       = "Job containers has image pull policy set to Always"
  description = "This check ensures that the container in the Job has image pull policy set to Always."
  query       = query.job_container_image_pull_policy_always

  tags = local.job_common_tags
}

control "job_container_admission_capability_restricted" {
  title       = "Job containers should has admission capability restricted"
  description = "This check ensures that the container in the Job has admission capability restricted."
  query       = query.job_container_admission_capability_restricted

  tags = local.job_common_tags
}

control "job_container_encryption_providers_configured" {
  title       = "Job containers should has encryption providers configured appropriately"
  description = "This check ensures that the container in the Job has encryption providers configured appropriately."
  query       = query.job_container_encryption_providers_configured

  tags = local.job_common_tags
}

control "job_container_sys_admin_capability_disabled" {
  title       = "Job containers should not use CAP_SYS_ADMIN linux capability"
  description = "This check ensures that the container in the Job does not use CAP_SYS_ADMIN Linux capability."
  query       = query.job_container_sys_admin_capability_disabled

  tags = local.job_common_tags
}

control "job_container_capabilities_drop_all" {
  title       = "Job containers should minimize its admission with capabilities assigned"
  description = "This check ensures that the container in the Job minimizes its admission with capabilities assigned."
  query       = query.job_container_capabilities_drop_all

  tags = local.job_common_tags
}

control "job_container_arg_peer_client_cert_auth_enabled" {
  title       = "Job containers peer client cert auth should be enabled"
  description = "This check ensures that the Job container peer client cert auth is enabled."
  query       = query.job_container_arg_peer_client_cert_auth_enabled

  tags = local.job_common_tags
}

control "job_container_rotate_certificate_enabled" {
  title       = "Job containers certificate rotation should be enabled"
  description = "This check ensures that the container in the Job has peer client cert auth enabled."
  query       = query.job_container_rotate_certificate_enabled

  tags = local.job_common_tags
}

control "job_container_argument_event_qps_less_than_5" {
  title       = "Job containers argument event qps should be less than 5"
  description = "This check ensures that the container in the Job has argument event qps set to less than 5."
  query       = query.job_container_argument_event_qps_less_than_5

  tags = local.job_common_tags
}

control "job_container_argument_anonymous_auth_disabled" {
  title       = "Job containers argument anonymous auth should be disabled"
  description = "This check ensures that the container in the Job has anonymous auth disabled."
  query       = query.job_container_argument_anonymous_auth_disabled

  tags = local.job_common_tags
}

control "job_container_argument_audit_log_path_configured" {
  title       = "Job containers should have audit log path configured appropriately"
  description = "This check ensures that the container in the Job has audit log path configured  appropriately."
  query       = query.job_container_argument_audit_log_path_configured

  tags = local.job_common_tags
}

control "job_container_argument_audit_log_maxage_greater_than_30" {
  title       = "Job containers should have audit log maxage set to 30 or greater"
  description = "This check ensures that the container in the Job has audit log maxage set to 30 or greater."
  query       = query.job_container_argument_audit_log_maxage_greater_than_30

  tags = local.job_common_tags
}

control "job_container_argument_audit_log_maxbackup_greater_than_10" {
  title       = "Job containers should have audit log maxbackup set to 10 or greater"
  description = "This check ensures that the container in the Job has audit log maxbackup set to 10 or greater."
  query       = query.job_container_argument_audit_log_maxbackup_greater_than_10

  tags = local.job_common_tags
}

control "job_container_argument_audit_log_maxsize_greater_than_100" {
  title       = "Job containers should have audit log maxsize set to 100 or greater"
  description = "This check ensures that the container in the Job has audit log maxsize set to 100 or greater."
  query       = query.job_container_argument_audit_log_maxsize_greater_than_100

  tags = local.job_common_tags
}

control "job_container_no_argument_basic_auth_file" {
  title       = "Job containers argument basic auth file should not be set"
  description = "This check ensures that the container in the Job has argument basic auth file not set."
  query       = query.job_container_no_argument_basic_auth_file

  tags = local.job_common_tags
}

control "job_container_argument_etcd_cafile_configured" {
  title       = "Job containers argument etcd cafile should be set"
  description = "This check ensures that the container in the Job has argument etcd cafile set."
  query       = query.job_container_argument_etcd_cafile_configured

  tags = local.job_common_tags
}

control "job_container_argument_authorization_mode_node" {
  title       = "Job containers argument authorization mode should have node"
  description = "This check ensures that the container in the Job has node included in the argument authorization mode."
  query       = query.job_container_argument_authorization_mode_node

  tags = local.job_common_tags
}

control "job_container_argument_authorization_mode_no_always_allow" {
  title       = "Job containers argument authorization mode should not be set to always allow"
  description = "This check ensures that the container in the Job has argument authorization mode not set to always allow."
  query       = query.job_container_argument_authorization_mode_no_always_allow

  tags = local.job_common_tags
}

control "job_container_argument_authorization_mode_rbac" {
  title       = "Job containers argument authorization mode should have RBAC"
  description = "This check ensures that the container in the Job has RBAC included in the argument authorization mode."
  query       = query.job_container_argument_authorization_mode_rbac

  tags = local.job_common_tags
}

control "job_container_no_argument_insecure_bind_address" {
  title       = "Job containers argument insecure bind address should not be set"
  description = "This check ensures that the container in the Job has argument insecure bind address not set."
  query       = query.job_container_no_argument_insecure_bind_address

  tags = local.job_common_tags
}

control "job_container_argument_kubelet_https_enabled" {
  title       = "Job containers argument kubelet HTTPS should be enabled"
  description = "This check ensures that the container in the Job has kubelet HTTPS argument enabled."
  query       = query.job_container_argument_kubelet_https_enabled

  tags = local.job_common_tags
}

control "job_container_argument_insecure_port_0" {
  title       = "Job containers argument insecure port should be set to 0"
  description = "This check ensures that the container in the Job has insecure port set to 0."
  query       = query.job_container_argument_insecure_port_0

  tags = local.job_common_tags
}

control "job_container_argument_kubelet_client_certificate_and_key_configured" {
  title       = "Job containers argument kubelet client certificate and key should be configured"
  description = "This check ensures that the container in the Job has kubelet client certificate and key argument configured."
  query       = query.job_container_argument_kubelet_client_certificate_and_key_configured

  tags = local.job_common_tags
}

control "job_container_argument_etcd_certfile_and_keyfile_configured" {
  title       = "Job containers argument etcd certfile and keyfile should be configured"
  description = "This check ensures that the container in the Job has etcd certfile and keyfile argument configured."
  query       = query.job_container_argument_etcd_certfile_and_keyfile_configured

  tags = local.job_common_tags
}

control "job_container_admission_control_plugin_always_pull_images" {
  title       = "Job containers admission control plugin should be set to  always pull images"
  description = "This check ensures that the container in the Job has always pull images configured foradmission control plugin."
  query       = query.job_container_admission_control_plugin_always_pull_images

  tags = local.job_common_tags
}
