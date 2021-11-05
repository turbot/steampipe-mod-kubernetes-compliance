select
  -- Required Columns
  uid as resource,
  case
    when c -> 'livenessProbe' is not null then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'livenessProbe' is not null then c ->> 'name' || ' have liveness probe.'
    else c ->> 'name' || ' does not have liveness probe.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;