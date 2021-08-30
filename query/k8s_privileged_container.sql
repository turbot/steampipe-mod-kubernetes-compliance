select
  -- Required Columns
  c ->> 'name' as resource,
  case
    when c -> 'securityContext' ->> 'privileged' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when c -> 'securityContext' ->> 'privileged' = 'true' then c ->> 'name' || ' privileged container.'
    else c ->> 'name' || ' not privileged container.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  context_name
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;