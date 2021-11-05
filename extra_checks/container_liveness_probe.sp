benchmark "container_liveness_probe" {
  title       = "Containers should have liveness probe"
  description = "Containers should have liveness probe."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_container_liveness_probe,
    control.deployment_container_liveness_probe,
    control.job_container_liveness_probe,
    control.pod_container_liveness_probe,
    control.replicaset_container_liveness_probe,
    control.replication_controller_container_liveness_probe,
  ]
}