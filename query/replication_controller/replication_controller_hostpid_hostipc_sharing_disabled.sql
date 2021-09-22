    select
  -- Required Columns
  uid as resource,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' or template -> 'spec' ->> 'hostIPC' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'ReplicationController pods share host pid namespaces.'
    when template -> 'spec' ->> 'hostIPC' = 'true' then 'ReplicationController pods share host ipc namespaces.'
    else 'ReplicationController pods cannot share host process namespaces.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_replication_controller;