control "network_policy_default_deny_egress" {
  title       = "Namespace should have a default network policy to deny all egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.network_policy_default_deny_egress.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "network_policy_default_deny_ingress" {
  title       = "Namespace should have a default network policy to deny all ingress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  sql         = query.network_policy_default_deny_ingress.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "network_policy_default_dont_allow_egress" {
  title       = "Network policy should not have a default policy to allow all egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. An 'allow all' policy would override this default and should not be used.  Instead, use specific  policies to relax these restrictions only for permissible connections. "
  sql         = query.network_policy_default_dont_allow_egress.sql
  tags        = local.nsa_cisa_v1_common_tags
}

control "network_policy_default_dont_allow_ingress" {
  title       = "Network policy should not have a default policy to allow all ingress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. An 'allow all' policy would override this default and should not be used.  Instead, use specific  policies to relax these restrictions only for permissible connections. "
  sql         = query.network_policy_default_dont_allow_ingress.sql
  tags        = local.nsa_cisa_v1_common_tags
}
