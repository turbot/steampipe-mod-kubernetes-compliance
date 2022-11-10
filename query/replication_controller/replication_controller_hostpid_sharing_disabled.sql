select
  -- Required Columns
  uid as resource,
  case when template -> 'spec' ->> 'hostPID' = 'true' then 'alarm'
  else 'ok'
  end as status,
  case when template -> 'spec' ->> 'hostPID' = 'true' then 'ReplicationController pods share host PID namespaces.'
  else 'ReplicationController pods cannot share host PID namespaces.'
  end as reason,
  -- Additional Dimensions
  name as replication_controller_name,
  namespace,
  context_name
from
  kubernetes_replication_controller;

