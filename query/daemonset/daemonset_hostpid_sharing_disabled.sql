select
  -- Required Columns
  uid as resource,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'DaemonSet pods share host PID namespaces.'
    else 'DaemonSet pods cannot share host PID namespaces.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_daemonset;