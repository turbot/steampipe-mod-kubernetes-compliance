select
  -- Required Columns
  uid as resource,
  case
    when host_pid or host_ipc then 'alarm'
    else 'ok'
  end as status,
  case
    when host_pid then 'Pod security policy allows pods to share host pid namespaces.'
    when host_ipc then 'Pod security policy allows pods to share host ipc namespaces.'
    else 'Pod security policy does not allow pods to share host pid or ipc namespaces.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;