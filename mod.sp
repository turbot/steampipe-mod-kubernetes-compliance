mod "kubernetes_compliance" {
  # hub metadata
  title         = "Kubernetes Compliance"
  description   = "Run individual controls or full compliance benchmarks for CIS, NSA CISA Kubernetes Hardening Guidance across all of your Kubernetes clusters using Steampipe."
  color         = "#0089D6"
  documentation = file("./docs/index.md")
  icon          = "/images/mods/turbot/kubernetes-compliance.svg"
  categories    = ["kubernetes", "compliance", "software development", "security"]

  opengraph {
    title       = "Steampipe Mod for Kubernetes Compliance"
    description = "Run individual controls or full compliance benchmarks for CIS, NSA CISA Kubernetes Hardening Guidance across all of your Kubernetes clusters using Steampipe."
    image       = "/images/mods/turbot/kubernetes-compliance-social-graphic.png"
  }
}
