select
  -- Required Columns
  uid as resource,
  case when template -> 'spec' ->> 'hostPID' = 'true' then 'alarm'
  else 'ok'
  end as status,
  case when template -> 'spec' ->> 'hostPID' = 'true' then 'ReplicaSet pods share host PID namespaces.'
  else 'ReplicaSet pods cannot share host PID namespaces.'
  end as reason,
  -- Additional Dimensions
  name as replicaset_name,
  namespace,
  context_name
from
  kubernetes_replicaset;

