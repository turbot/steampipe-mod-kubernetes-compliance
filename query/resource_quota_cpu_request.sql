select
  -- Required Columns
  distinct(n.uid) as resource,
  case
    when q.spec_hard -> 'requests.cpu' is null and q.spec_hard -> 'cpu' is null then 'alarm'
    else 'ok'
  end as status,
  case
    when q.spec_hard -> 'requests.cpu' is null and q.spec_hard -> 'cpu' is null then n.name || ' dont have resource quota CPU request.'
    else n.name || ' have resource quota CPU request.'
  end as reason,
  -- Additional Dimensions
  n.context_name
from
  kubernetes_namespace n
  left join kubernetes_resource_quota q
  on n.name = q.namespace;