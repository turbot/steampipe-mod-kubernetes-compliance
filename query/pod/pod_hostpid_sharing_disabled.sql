select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when host_pid then 'alarm'
    else 'ok'
  end as status,
  case
    when host_pid then name || ' can share host PID namespaces.'
    else name || ' cannot share host PID namespaces.'
  end as reason,
  -- Additional Dimensions
  namespace,
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_pod;