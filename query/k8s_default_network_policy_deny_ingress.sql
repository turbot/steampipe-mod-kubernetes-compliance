select
  -- Required Columns
  name as resource,
  case
    when policy_types @> '["Ingress"]' and pod_selector = '{}' and ingress is null then 'ok'
    else 'alarm'
  end as status,
  case
    when policy_types @> '["Ingress"]' and pod_selector = '{}' and ingress is null then name ||' default policy available to deny all ingress traffic.'
    else name || ' default policy not available to deny all ingress traffic.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_network_policy;