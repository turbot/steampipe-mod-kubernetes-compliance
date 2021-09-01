select
  -- Required Columns
  c ->> 'name' as resource,
  case
    when c -> 'resources' -> 'requests' ->> 'cpu' is null then 'alarm'
    else 'ok'
  end as status,
  case
    when c -> 'resources' -> 'requests' ->> 'cpu' is null then c ->> 'name' || ' do not have cpu request.'
    else c ->> 'name' || ' has cpu request of ' || (c -> 'resources' -> 'requests' ->> 'cpu') || '.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  context_name
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;