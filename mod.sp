// Benchmarks and controls for specific services should override the "service" tag
locals {
  kubernetes_compliance_common_tags = {
    category = "Compliance"
    plugin   = "kubernetes"
    service  = "Kubernetes"
  }
}

variable "common_dimensions" {
  type        = list(string)
  description = "A list of common dimensions to add to each control."
  # Define which common dimensions should be added to each control.
  # - connection_name (_ctx ->> 'connection_name')
  # - context_name
  # - namespace
  # - path
  # - source_type
  default = ["context_name", "namespace", "source_type", "path"]
}

variable "tag_dimensions" {
  type        = list(string)
  description = "A list of tags to add as dimensions to each control."
  # A list of tag names to include as dimensions for resources that support
  # tags (e.g. "Owner", "Environment"). Default to empty since tag names are
  # a personal choice - for commonly used tag names see
  # https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/
  default = []
}

locals {

  # Local internal variable to build the SQL select clause for common
  # dimensions using a table name qualifier if required. Do not edit directly.
  common_dimensions_qualifier_sql = <<-EOQ
  %{~if contains(var.common_dimensions, "connection_name")}, __QUALIFIER___ctx ->> 'connection_name' as connection_name%{endif~}
  %{~if contains(var.common_dimensions, "context_name")}, coalesce(__QUALIFIER__context_name, '') as context_name%{endif~}
  %{~if contains(var.common_dimensions, "namespace")}, __QUALIFIER__namespace%{endif~}
  %{~if contains(var.common_dimensions, "source_type")}, __QUALIFIER__source_type%{endif~}
  %{~if contains(var.common_dimensions, "path")}, coalesce(__QUALIFIER__path || ':' || __QUALIFIER__start_line || '-' || __QUALIFIER__end_line, '') as path%{endif~}
  EOQ

  common_dimensions_qualifier_namespace_sql = <<-EOQ
  %{~if contains(var.common_dimensions, "connection_name")}, __QUALIFIER___ctx ->> 'connection_name' as connection_name%{endif~}
  %{~if contains(var.common_dimensions, "context_name")}, coalesce(__QUALIFIER__context_name, '') as context_name%{endif~}
  %{~if contains(var.common_dimensions, "namespace")}, __QUALIFIER__name%{endif~}
  %{~if contains(var.common_dimensions, "source_type")}, __QUALIFIER__source_type%{endif~}
  %{~if contains(var.common_dimensions, "path")}, coalesce(__QUALIFIER__path || ':' || __QUALIFIER__start_line || '-' || __QUALIFIER__end_line, '') as path%{endif~}
  EOQ

  common_dimensions_non_namespace_qualifier_sql = <<-EOQ
  %{~if contains(var.common_dimensions, "connection_name")}, __QUALIFIER___ctx ->> 'connection_name' as connection_name%{endif~}
  %{~if contains(var.common_dimensions, "context_name")}, coalesce(__QUALIFIER__context_name, '') as context_name%{endif~}
  %{~if contains(var.common_dimensions, "source_type")}, __QUALIFIER__source_type%{endif~}
  %{~if contains(var.common_dimensions, "path")}, coalesce(__QUALIFIER__path || ':' || __QUALIFIER__start_line || '-' || __QUALIFIER__end_line, '') as path%{endif~}
  EOQ

  # Local internal variable to build the SQL select clause for tag
  # dimensions. Do not edit directly.
  tag_dimensions_qualifier_sql = <<-EOQ
  %{~for dim in var.tag_dimensions},  __QUALIFIER__tags ->> '${dim}' as "${replace(dim, "\"", "\"\"")}"%{endfor~}
  EOQ
}

locals {

  # Local internal variable with the full SQL select clause for common
  # dimensions. Do not edit directly.
  common_dimensions_sql               = replace(local.common_dimensions_qualifier_sql, "__QUALIFIER__", "")
  common_dimensions_namespace_sql     = replace(local.common_dimensions_qualifier_namespace_sql, "__QUALIFIER__", "")
  common_dimensions_non_namespace_sql = replace(local.common_dimensions_non_namespace_qualifier_sql, "__QUALIFIER__", "")
  tag_dimensions_sql                  = replace(local.tag_dimensions_qualifier_sql, "__QUALIFIER__", "")
}

mod "kubernetes_compliance" {
  # hub metadata
  title         = "Kubernetes Compliance"
  description   = "Run individual controls or full compliance benchmarks for CIS, NSA CISA Kubernetes Hardening Guidance across all of your Kubernetes clusters using Steampipe."
  color         = "#0089D6"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/kubernetes-compliance.svg"
  categories    = ["kubernetes", "compliance", "iac", "software development", "security"]

  opengraph {
    title       = "Steampipe Mod for Kubernetes Compliance"
    description = "Run individual controls or full compliance benchmarks for CIS, NSA CISA Kubernetes Hardening Guidance across all of your Kubernetes clusters using Steampipe."
    image       = "/images/mods/turbot/kubernetes-compliance-social-graphic.png"
  }
  requires {
    plugin "kubernetes" {
      version = "0.20.0"
    }
  }
}
