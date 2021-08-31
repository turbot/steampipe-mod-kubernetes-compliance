select
  -- Required Columns
  c ->> 'name' as resource,
  case
    when c -> 'resources' -> 'limits' ->> 'cpu' is null  then 'alarm'
    else 'ok'
  end as status,
  case
    when c -> 'resources' -> 'limits' ->> 'cpu' is null then c ->> 'name' || ' do not have cpu limit.'
    else c ->> 'name' || ' has cpu limit.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  context_name
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;