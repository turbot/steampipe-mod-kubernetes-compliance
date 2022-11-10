select
  -- Required Columns
  uid as resource,
  case when c -> 'securityContext' ->> 'privileged' = 'true' then 'alarm'
  else 'ok'
  end as status,
  case when c -> 'securityContext' ->> 'privileged' = 'true' then c ->> 'name' || ' privileged container.'
  else c ->> 'name' || ' not privileged container.'
  end as reason,
  -- Additional Dimensions
  name as statefulset_name,
  namespace,
  context_name
from
  kubernetes_stateful_set,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

