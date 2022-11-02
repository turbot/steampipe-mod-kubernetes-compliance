select
  -- Required Columns
  uid as resource,
  case when c -> 'resources' -> 'requests' ->> 'cpu' is null then
    'alarm'
  else
    'ok'
  end as status,
  case when c -> 'resources' -> 'requests' ->> 'cpu' is null then
    c ->> 'name' || ' does not have a CPU request.'
  else
    c ->> 'name' || ' has a CPU request of ' || (c -> 'resources' -> 'requests' ->> 'cpu') || '.'
  end as reason,
  -- Additional Dimensions
  name as replication_controller_name,
  namespace,
  context_name
from
  kubernetes_replication_controller,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

