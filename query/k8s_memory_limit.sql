select
  -- Required Columns
  c ->> 'name' as resource,
  case
    when c -> 'resources' -> 'limits' ->> 'memory' is null then 'alarm'
    else 'ok'
  end as status,
  case
    when c -> 'resources' -> 'limits' ->> 'memory' is null then c ->> 'name' || ' do not have memory limit.'
    else c ->> 'name' || ' has memory limit.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  context_name
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;