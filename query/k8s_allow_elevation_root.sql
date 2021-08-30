select
  -- Required Columns
  c ->> 'name' as resource,
  case
    when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false'  then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then c ->> 'name' || ' not allowed elevation to root.'
    else c ->> 'name' || 'allowed elevation to root.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  context_name
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;