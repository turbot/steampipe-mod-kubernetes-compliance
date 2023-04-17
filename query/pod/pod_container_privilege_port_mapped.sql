select
  -- Required Columns
  c ->> 'name' as resource,
  case
    When p ->> 'name' is null then 'skip'
    when cast(p ->> 'containerPort' as integer) <= 1024 then 'alarm'
    else 'ok'
  end as status,
  case
    When p ->> 'name' is null then 'No port mapped.'
    when cast(p ->> 'containerPort' as integer) <= 1024 then p ->> 'name'|| ' mapped with a privileged port.'
    else p ->> 'name' || ' not mapped with a privileged port.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c,
  jsonb_array_elements(c -> 'ports') as p;