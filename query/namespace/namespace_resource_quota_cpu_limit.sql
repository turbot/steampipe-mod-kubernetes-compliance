select
  -- Required Columns
  distinct(n.uid) as resource,
  case
    when q.spec_hard -> 'limits.cpu' is null then 'alarm'
    else 'ok'
  end as status,
  case
    when q.spec_hard -> 'limits.cpu' is null then n.name || ' do not have ResourceQuota for CPU limit.'
    else n.name || ' have ResourceQuota for CPU limit.'
  end as reason,
  -- Additional Dimensions
  n.context_name
from
  kubernetes_namespace n
  left join kubernetes_resource_quota q
  on n.name = q.namespace;