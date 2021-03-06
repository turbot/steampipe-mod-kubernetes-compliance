select
  -- Required Columns
  uid as resource,
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
  context_name
from
  kubernetes_pod;