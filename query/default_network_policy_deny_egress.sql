select
  -- Required Columns
  namespace as resource,
  case
    when policy_types @> '["Egress"]' and pod_selector = '{}' and egress is null then 'ok'
    else 'alarm'
  end as status,
  case
    when policy_types @> '["Egress"]' and pod_selector = '{}' and egress is null then name || ' default policy available to deny all egress traffic.'
    else name || ' default policy not available to deny all egress traffic.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_network_policy;