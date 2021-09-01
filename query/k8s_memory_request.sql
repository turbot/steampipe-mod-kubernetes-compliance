select
  -- Required Columns
  c ->> 'name' as resource,
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
  context_name
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;