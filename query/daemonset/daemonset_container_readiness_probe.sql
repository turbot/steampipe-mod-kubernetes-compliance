select
  -- Required Columns
  uid as resource,
  case when c -> 'readinessProbe' is not null then
    'ok'
  else
    'alarm'
  end as status,
  case when c -> 'readinessProbe' is not null then
    c ->> 'name' || ' has readiness probe.'
  else
    c ->> 'name' || ' does not have readiness probe.'
  end as reason,
  -- Additional Dimensionss
  name as daemonset_name,
  namespace,
  context_name
from
  kubernetes_daemonset,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

