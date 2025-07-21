mod "kubernetes_compliance" {
  # Hub metadata
  title         = "Kubernetes Compliance"
  description   = "Run individual controls or full compliance benchmarks for CIS, NSA CISA Kubernetes Hardening Guidance across all of your Kubernetes clusters using Powerpipe and Steampipe."
  color         = "#0089D6"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/kubernetes-compliance.svg"
  categories    = ["kubernetes", "compliance", "cis", "iac", "software development", "security"]

  opengraph {
    title       = "Powerpipe Mod for Kubernetes Compliance"
    description = "Run individual controls or full compliance benchmarks for CIS, NSA CISA Kubernetes Hardening Guidance across all of your Kubernetes clusters using Powerpipe and Steampipe."
    image       = "/images/mods/turbot/kubernetes-compliance-social-graphic.png"
  }
  requires {
    plugin "kubernetes" {
      min_version = "0.23.0"
    }
  }
}
