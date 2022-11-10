select
  -- Required Columns
  uid as resource,
  case when c -> 'resources' -> 'requests' ->> 'memory' is null then 'alarm'
  else 'ok'
  end as status,
  case when c -> 'resources' -> 'requests' ->> 'memory' is null then c ->> 'name' || ' does not have a memory request.'
  else c ->> 'name' || ' has a memory request of ' || (c -> 'resources' -> 'requests' ->> 'memory') || '.'
  end as reason,
  -- Additional Dimensions
  name as daemonset_name,
  namespace,
  context_name
from
  kubernetes_daemonset,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

