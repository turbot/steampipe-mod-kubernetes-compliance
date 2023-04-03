select
  -- Required Columns
  name ||  '_' || namespace as resource,
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
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_pod;