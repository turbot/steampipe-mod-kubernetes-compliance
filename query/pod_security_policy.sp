query "pod_security_policy_host_network_access_disabled" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when host_network then 'alarm'
        else 'ok'
      end as status,
      case
        when host_network then 'Pod security policy ' || name || ' pods can use the host network.'
        else 'Pod security policy ' || name || ' pods cannot use the host network.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}

query "pod_security_policy_allowed_host_path" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when allowed_host_paths is null then 'alarm'
        else 'ok'
      end as status,
      case
        when allowed_host_paths is null then 'Pod security policy ' || name || ' containers can use all host paths.'
        else 'Pod security policy ' || name || ' containers using specified host path.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}

query "pod_security_policy_container_privilege_escalation_disabled" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when not allow_privilege_escalation then 'ok'
        else 'alarm'
      end as status,
      case
        when not allow_privilege_escalation then 'Pod security policy ' || name || ' pods can not request to allow privilege escalation.'
        else 'Pod security policy ' || name || ' pods can request to allow privilege escalation.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}

query "pod_security_policy_non_root_container" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when run_as_user ->> 'rule' = 'MustRunAsNonRoot' then 'ok'
        else 'alarm'
      end as status,
      case
        when run_as_user ->> 'rule' = 'MustRunAsNonRoot' then 'Pod security policy ' || name || ' restrict containers to run as non-root user.'
        else 'Pod security policy ' || name || ' does not restrict containers to run as non-root user.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}

query "pod_security_policy_hostpid_hostipc_sharing_disabled" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when host_pid or host_ipc then 'alarm'
        else 'ok'
      end as status,
      case
        when host_pid then 'Pod security policy ' || name || ' pods can share host PID namespaces.'
        when host_ipc then 'Pod security policy ' || name || ' pods can share host IPC namespaces.'
        else 'Pod security policy ' || name || ' pods cannot share host process namespaces.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}

query "pod_security_policy_immutable_container_filesystem" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when read_only_root_filesystem then 'ok'
        else 'alarm'
      end as status,
      case
        when read_only_root_filesystem then 'Pod security policy ' || name || ' containers running with read only root file system.'
        else 'Pod security policy ' || name || ' containers not running with read only root file system.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}

query "pod_security_policy_container_privilege_disabled" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when privileged then 'alarm'
        else 'ok'
      end as status,
      case
        when privileged then 'Pod security policy ' || name || ' pods can run privileged containers.'
        else 'Pod security policy ' || name || ' pods can not run privileged containers.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}

query "pod_security_policy_hostipc_sharing_disabled" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when host_ipc then 'alarm'
        else 'ok'
      end as status,
      case
        when host_ipc then 'Pod security policy ' || name || ' pods can share host IPC namespaces.'
        else 'Pod security policy ' || name || ' pods cannot share host IPC namespaces.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}

query "pod_security_policy_hostpid_sharing_disabled" {
  sql = <<-EOQ
    select
      name as resource,
      case
        when host_pid then 'alarm'
        else 'ok'
      end as status,
      case
        when host_pid then 'Pod security policy ' || name || ' pods can share host PID namespaces.'
        else 'Pod security policy ' || name || ' pods cannot share host PID namespaces.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}

query "pod_security_policy_security_services_hardening" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when se_linux -> 'rule' = '"MustRunAs"' then 'ok'
        when annotations -> 'apparmor.security.beta.kubernetes.io/defaultProfileName' = '"runtime/default"' then 'ok'
        when annotations -> 'seccomp.security.alpha.kubernetes.io/defaultProfileName' = '"runtime/default"' then 'ok'
        else 'alarm'
      end as status,
      case
        when se_linux -> 'rule' = '"MustRunAs"' then 'Applications using SELinux security service.'
        when annotations -> 'apparmor.security.beta.kubernetes.io/defaultProfileName' = '"runtime/default"' then 'Pod security policy ' || name || ' using AppArmor security service.'
        when annotations -> 'seccomp.security.alpha.kubernetes.io/defaultProfileName' = '"runtime/default"' then 'Pod security policy ' || name || ' using Seccomp security service.'
        else 'Pod security policy ' || name || ' not using securty services.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}

query "pod_security_policy_default_seccomp_profile_enabled" {
  sql = <<-EOQ
    select
      uid as resource,
      case
        when annotations -> 'seccomp.security.alpha.kubernetes.io/defaultProfileName' = '"docker/default"' then 'ok'
        else 'alarm'
      end as status,
      case
        when annotations -> 'seccomp.security.alpha.kubernetes.io/defaultProfileName' = '"docker/default"' then name || ' seccompProfile enabled.'
        else name || ' seccompProfile disabled.'
      end as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_non_namespace_sql}
    from
      kubernetes_pod_security_policy;
  EOQ
}
