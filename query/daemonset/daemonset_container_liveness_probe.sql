select
  -- Required Columns
  uid as resource,
  case
    when c -> 'livenessProbe' is not null then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'livenessProbe' is not null then c ->> 'name' || ' has liveness probe.'
    else c ->> 'name' || ' does not have liveness probe.'
  end as reason,
  -- Additional Dimensionss
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_daemonset,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;