select
  -- Required Columns
  uid as resource,
  case when c -> 'resources' -> 'limits' ->> 'cpu' is null then 'alarm'
  else 'ok'
  end as status,
  case when c -> 'resources' -> 'limits' ->> 'cpu' is null then c ->> 'name' || ' does not have a CPU limit.'
  else c ->> 'name' || ' has a CPU limit of ' || (c -> 'resources' -> 'limits' ->> 'cpu') || '.'
  end as reason,
  -- Additional Dimensions
  name as replicaset_name,
  namespace,
  context_name
from
  kubernetes_replicaset,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

