select
  -- Required Columns
  uid as resource,
  case
    when host_network then 'alarm'
    else 'ok'
  end as status,
  case
    when host_network then 'Pod security policy allows pods to use the host network.'
    else name || 'Pod security policy does not allow pods to use the host network.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;