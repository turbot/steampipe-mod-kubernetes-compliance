benchmark "container_privilege_port_mapped" {
  title       = "Privileged ports should not mapped with containers"
  description = "The TCP/IP port numbers `O to 1024` are considered privileged ports and should not be mapped with container for security reasons."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_container_privilege_port_mapped,
    control.deployment_container_privilege_port_mapped,
    control.job_container_privilege_port_mapped,
    control.pod_container_privilege_port_mapped,
    control.replicaset_container_privilege_port_mapped,
    control.replication_controller_container_privilege_port_mapped,
  ]
}