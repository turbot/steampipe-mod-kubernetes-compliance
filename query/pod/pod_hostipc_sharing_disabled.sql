select
  -- Required Columns
  case
    when manifest_file_path is null then uid
    else manifest_file_path || '-' || start_line
  end as resource,
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
  context_name
from
  kubernetes_pod;