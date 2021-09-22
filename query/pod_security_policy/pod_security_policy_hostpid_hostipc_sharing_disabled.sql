select
  -- Required Columns
  name as resource,
  case
    when host_pid or host_ipc then 'alarm'
    else 'ok'
  end as status,
  case
    when host_pid then 'Pods can share host pid namespaces.'
    when host_ipc then 'Pods can share host ipc namespaces.'
    else 'Pod cannot share host process namespaces.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;