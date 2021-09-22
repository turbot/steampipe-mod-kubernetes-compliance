    select
  -- Required Columns
  uid as resource,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' or template -> 'spec' ->> 'hostIPC' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'DaemonSet pods share host pid namespaces.'
    when template -> 'spec' ->> 'hostIPC' = 'true' then 'DaemonSet pods share host ipc namespaces.'
    else 'DaemonSet pods cannot share host process namespaces.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_daemonset;