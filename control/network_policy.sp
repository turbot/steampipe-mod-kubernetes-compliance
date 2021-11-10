locals {
  network_policy_common_tags = {
    plugin = "kubernetes"
  }
}

control "network_policy_default_deny_egress" {
  title       = "Namespaces should have a default network policy to deny all egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.network_policy_default_deny_egress.sql
  tags = merge(local.network_policy_common_tags, {
    cis         = "true"
    nsa_cisa_v1 = "true"
  })
}

control "network_policy_default_deny_ingress" {
  title       = "Namespaces should have a default network policy to deny all ingress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.network_policy_default_deny_ingress.sql
  tags = merge(local.network_policy_common_tags, {
    cis         = "true"
    nsa_cisa_v1 = "true"
  })
}

control "network_policy_default_dont_allow_egress" {
  title       = "Network policies should not have a default policy to allow all egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. An 'allow all' policy would override this default and should not be used.  Instead, use specific  policies to relax these restrictions only for permissible connections. "
  sql         = query.network_policy_default_dont_allow_egress.sql
  tags = merge(local.network_policy_common_tags, {
    cis         = "true"
    nsa_cisa_v1 = "true"
  })
}

control "network_policy_default_dont_allow_ingress" {
  title       = "Network policies should not have a default policy to allow all ingress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. An 'allow all' policy would override this default and should not be used.  Instead, use specific  policies to relax these restrictions only for permissible connections. "
  sql         = query.network_policy_default_dont_allow_ingress.sql
  tags = merge(local.network_policy_common_tags, {
    cis         = "true"
    nsa_cisa_v1 = "true"
  })
}
