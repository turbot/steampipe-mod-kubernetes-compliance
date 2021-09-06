select
  -- Required Columns
  uid as resource,
  case
    when c -> 'resources' -> 'requests' ->> 'memory' is null then 'alarm'
    else 'ok'
  end as status,
  case
    when c -> 'resources' -> 'requests' ->> 'memory' is null then c ->> 'name' || ' do not have memory request.'
    else c ->> 'name' || ' has memory request of ' || (c -> 'resources' -> 'requests' ->> 'memory') || '.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_deployment,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;