select
  -- Required Columns
  split_part(context_name,'_',4) as resource,
  case
    when p ->> 'name' = 'https' and (p ->> 'port' = '443' or p ->> 'port' = '6443') then 'ok'
    else 'alarm'
  end as status,
  case
    when p ->> 'name' = 'https' and (p ->> 'port' = '443' or p ->> 'port' = '6443') then name || ' Kubernetes API serving on secure port.'
    else name || ' Kubernetes API not serving on secure port.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_endpoint,
  jsonb_array_elements(subsets) as s,
  jsonb_array_elements(s -> 'ports') as p
  where name = 'kubernetes';