select
  -- Required Columns
  name as resource,
  case
    when host_pid or host_ipc then 'alarm'
    else 'ok'
  end as status,
  case
    when host_pid then name || ' can share host pid namespaces.'
    when host_ipc then name || ' can share host ipc namespaces.'
    else 'Pod can not share host process namespaces.'
  end as reason,
  -- Additional Dimensions
  namespace,
  context_name
from
  kubernetes_pod;