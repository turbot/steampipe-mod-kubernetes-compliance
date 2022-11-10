select
  -- Required Columns
  uid as resource,
  case when template -> 'spec' ->> 'hostIPC' = 'true' then 'alarm'
  else 'ok'
  end as status,
  case when template -> 'spec' ->> 'hostIPC' = 'true' then 'ReplicationController pods share host IPC namespaces.'
  else 'ReplicationController pods cannot share host IPC namespaces.'
  end as reason,
  -- Additional Dimensions
  name as replication_controller_name,
  namespace,
  context_name
from
  kubernetes_replication_controller;

