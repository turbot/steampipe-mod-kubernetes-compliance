benchmark "default_namespace_not_used" {
  title       = "default namespace should not be used"
  description = "Kubernetes provides a default namespace, where objects are placed if no namespace is specified for them. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  tags        = local.extra_checks_tags
  children = [
    control.daemonset_default_namesapce_used,
    control.deployment_default_namesapce_used,
    control.job_default_namesapce_used,
    control.pod_default_namesapce_used,
    control.replicaset_default_namesapce_used,
    control.replication_controller_default_namesapce_used,
    control.service_default_namesapce_used,
  ]
}