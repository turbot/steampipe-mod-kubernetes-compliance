select
  -- Required Columns
  uid as resource,
  case when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then
    'ok'
  else
    'alarm'
  end as status,
  case when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then
    c ->> 'name' || ' not allowed root elevation.'
  else
    c ->> 'name' || ' allowed root elevation.'
  end as reason,
  -- Additional Dimensions
  name as replicaset_name,
  namespace,
  context_name
from
  kubernetes_replicaset,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

