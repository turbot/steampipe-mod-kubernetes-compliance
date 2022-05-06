locals {
  container_liveness_probe_mapped_common_tags = merge(local.extra_checks_tags, {
  })
}

benchmark "container_liveness_probe" {
  title       = "Containers should have liveness probe"
  description = "The kubelet uses liveness probes to know when to restart a container. For example, liveness probes could catch a deadlock, where an application is running, but unable to make progress. Restarting a container in such a state can help to make the application more available despite bugs."
  children = [
    control.cronjob_container_liveness_probe,
    control.daemonset_container_liveness_probe,
    control.deployment_container_liveness_probe,
    control.job_container_liveness_probe,
    control.pod_container_liveness_probe,
    control.replicaset_container_liveness_probe,
    control.replication_controller_container_liveness_probe,
    control.statefulset_container_liveness_probe
  ]

  tags = merge(local.container_liveness_probe_mapped_common_tags, {
    type = "Benchmark"
  })
}
