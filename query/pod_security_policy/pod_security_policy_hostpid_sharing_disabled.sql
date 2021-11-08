select
  -- Required Columns
  name as resource,
  case
    when host_pid then 'alarm'
    else 'ok'
  end as status,
  case
    when host_pid then 'Pods can share host PID namespaces.'
    else 'Pod cannot share host PID namespaces.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;