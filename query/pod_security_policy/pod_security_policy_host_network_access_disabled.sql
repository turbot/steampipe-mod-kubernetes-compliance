select
  -- Required Columns
  name as resource,
  case
    when host_network then 'alarm'
    else 'ok'
  end as status,
  case
    when host_network then 'Pods can use the host network.'
    else name || 'Pods cannot use the host network.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;