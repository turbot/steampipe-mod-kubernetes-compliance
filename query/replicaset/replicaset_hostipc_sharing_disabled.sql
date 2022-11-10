select
  -- Required Columns
  uid as resource,
  case
    when template -> 'spec' ->> 'hostIPC' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostIPC' = 'true' then 'ReplicaSet pods share host IPC namespaces.'
    else 'ReplicaSet pods cannot share host IPC namespaces.'
  end as reason,
  -- Additional Dimensions
  name as replicaset_name,
  namespace,
  context_name
from
  kubernetes_replicaset;

