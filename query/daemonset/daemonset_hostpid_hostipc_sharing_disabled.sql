select
  -- Required Columns
  uid as resource,
  case when template -> 'spec' ->> 'hostPID' = 'true'
    or template -> 'spec' ->> 'hostIPC' = 'true' then
    'alarm'
  else
    'ok'
  end as status,
  case when template -> 'spec' ->> 'hostPID' = 'true' then
    'DaemonSet pods share host PID namespaces.'
  when template -> 'spec' ->> 'hostIPC' = 'true' then
    'DaemonSet pods share host IPC namespaces.'
  else
    'DaemonSet pods cannot share host process namespaces.'
  end as reason,
  -- Additional Dimensions
  name as daemonset_name,
  namespace,
  context_name
from
  kubernetes_daemonset;

