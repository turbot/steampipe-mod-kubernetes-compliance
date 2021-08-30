mod "kubernetes_compliance" {
  # hub metadata
  title         = "Kubernetes Compliance"
  description  = "Run individual configuration, compliance and security controls across all your Kubernetes accounts using Steampipe."
  color         = "#0089D6"
  documentation = file("./docs/index.md")
  #icon          = "/images/mods/turbot/kubernetes-compliance.svg"
  categories    = ["kubernetes", "compliance", "public cloud", "security"]

  opengraph {
    title       = "Steampipe Mod for Kubernetes Compliance"
    description = "Run individual configuration, compliance and security controls or full compliance benchmarks for CIS, HIPAA HITRUST across all your Azure subscriptions using Steampipe."
    #image       = "/images/mods/turbot/kubernetes-compliance-social-graphic.png"
  }
}
