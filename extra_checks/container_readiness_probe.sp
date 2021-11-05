benchmark "container_readiness_probe" {
  title       = "Containers should have readiness probe"
  description = "Containers should have readiness probe."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_container_readiness_probe,
    control.deployment_container_readiness_probe,
    control.job_container_readiness_probe,
    control.pod_container_readiness_probe,
    control.replicaset_container_readiness_probe,
    control.replication_controller_container_readiness_probe,
  ]
}