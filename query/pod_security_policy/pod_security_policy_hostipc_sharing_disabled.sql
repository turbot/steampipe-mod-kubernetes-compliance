select
  -- Required Columns
  name as resource,
  case
    when host_ipc then 'alarm'
    else 'ok'
  end as status,
  case
    when host_ipc then 'Pods can share host IPC namespaces.'
    else 'Pod cannot share host IPC namespaces.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;