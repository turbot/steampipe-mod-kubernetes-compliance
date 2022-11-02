select
  -- Required Columns
  uid as resource,
  case when c -> 'livenessProbe' is not null then
    'ok'
  else
    'alarm'
  end as status,
  case when c -> 'livenessProbe' is not null then
    c ->> 'name' || ' has liveness probe.'
  else
    c ->> 'name' || ' does not have liveness probe.'
  end as reason,
  -- Additional Dimensions
  name as replication_controller_name,
  namespace,
  context_name
from
  kubernetes_replication_controller,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

