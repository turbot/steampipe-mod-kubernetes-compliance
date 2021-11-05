select
  -- Required Columns
  uid as resource,
  case
    when c -> 'readinessProbe' is not null then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'readinessProbe' is not null then c ->> 'name' || ' have readiness probe.'
    else c ->> 'name' || ' does not have readiness probe.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_replication_controller,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;