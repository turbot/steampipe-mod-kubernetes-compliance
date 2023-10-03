locals {
  service_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Service"
  })
}

control "service_type_forbidden" {
  title       = "Containers should not be exposed through a forbidden service type"
  description = local.service_type_forbidden_desc
  query       = query.service_type_forbidden

  tags = merge(local.service_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "service_default_namespace_used" {
  title       = "Services should not use default namespace"
  description = "Default namespace should not be used by services. Placing objects in this namespace makes application of RBAC and other controls more difficult."
  query       = query.service_default_namespace_used

  tags = merge(local.service_common_tags, {
    cis = "true"
  })
}

control "service_no_tiller_service" {
  title       = "Services should not have tiller service"
  description = "Services should avoid using Tiller service as it is not recommended due to security concerns."
  query       = query.service_no_tiller_service

  tags = local.service_common_tags
}

control "service_no_tiller_deployed" {
  title       = "Services should not have tiller (helm v2) deployed"
  description = "Services should not deploy tiller (helm v2) as it is not recommended due to security concerns."
  query       = query.service_no_tiller_deployed

  tags = local.service_common_tags
}

