mod "kubernetes_compliance" {
  # hub metadata
  title         = "Kubernetes Compliance"
  description  = "The National Security Agency (NSA) and CISA Kubernetes Hardening Guidance, describes the security challenges associated with setting up and securing a Kubernetes cluster, and presents hardening strategies to guide system administrators in avoiding common misconfigurations."
  color         = "#0089D6"
  documentation = file("./docs/index.md")
  #icon          = "/images/mods/turbot/kubernetes-compliance.svg"
  categories    = ["kubernetes", "compliance", "public cloud", "security"]

  opengraph {
    title       = "Steampipe Mod for Kubernetes Compliance"
    description = "Run individual configuration, compliance and security controls across all your Kubernetes accounts using Steampipe."
    #image       = "/images/mods/turbot/kubernetes-compliance-social-graphic.png"
  }
}
