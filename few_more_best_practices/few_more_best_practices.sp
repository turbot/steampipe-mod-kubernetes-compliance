locals {
  best_practices_tags = {
    best_practices = "true"
    plugin      = "kubernetes"
  }
}

benchmark "few_more_kubernetes_best_practices" {
  title         = "Few more Best Practices"
  tags          = local.best_practices_tags
  children = [
    control.service_type_forbidden 
     ]
}