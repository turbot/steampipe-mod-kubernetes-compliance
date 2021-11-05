benchmark "container_liveness_probe" {
  title       = "Containers should have liveness probe"
  description = "The liveness probe indicates whether the container is running. If the liveness probe fails, the kubelet kills the container, and the container is subjected to its restart policy. If a container does not provide a liveness probe, the default state is `Success`."
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