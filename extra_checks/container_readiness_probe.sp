benchmark "container_readiness_probe" {
  title       = "Containers should have readiness probe"
  description = "The readiness probe indicates whether the Container is ready to service requests. If the readiness probe fails, the endpoints controller removes the Pod’s IP address from the endpoints of all Services that match the Pod. The default state of readiness before the initial delay is Failure. If a Container does not provide a readiness probe, the default state is Success."
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