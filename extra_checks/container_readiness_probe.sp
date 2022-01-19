benchmark "container_readiness_probe" {
  title       = "Containers should have readiness probe"
  description = "The kubelet uses readiness probes to know when a container is ready to start accepting traffic. A Pod is considered ready when all of its containers are ready. One use of this signal is to control which Pods are used as backends for services. When a Pod is not ready, it is removed from service load balancers."
  tags        = local.extra_checks_tags
  children = [
    control.cronjob_container_readiness_probe,
    control.daemonset_container_readiness_probe,
    control.deployment_container_readiness_probe,
    control.job_container_readiness_probe,
    control.pod_container_readiness_probe,
    control.replicaset_container_readiness_probe,
    control.replication_controller_container_readiness_probe,
    control.statefulset_container_readiness_probe
  ]
}