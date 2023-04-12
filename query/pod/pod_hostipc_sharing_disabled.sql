select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when host_ipc then 'alarm'
    else 'ok'
  end as status,
  case
    when host_ipc then name || ' can share host IPC namespaces.'
    else name || ' cannot share host IPC namespaces.'
  end as reason,
  -- Additional Dimensions
  namespace,
  context_name,
  source
from
  kubernetes_pod;