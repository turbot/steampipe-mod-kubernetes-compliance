locals {
  extra_checks_tags = {
    extra_checks = "true"
    plugin      = "kubernetes"
  }
}

benchmark "extra_checks" {
  title         = "Extra Checks"
  documentation = file("./extra_checks/docs/extra_checks_overview.md")
  tags          = local.extra_checks_tags
  children = [
    control.pod_service_account_not_exist,
    control.service_type_forbidden
     ]
}