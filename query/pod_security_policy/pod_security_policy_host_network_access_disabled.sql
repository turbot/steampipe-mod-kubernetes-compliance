select
  -- Required Columns
  name as resource,
  case when host_network then 'alarm'
  else 'ok'
  end as status,
  case when host_network then 'Pod security policy ' || name || ' pods can use the host network.'
  else 'Pod security policy ' || name || ' pods cannot use the host network.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;

