select
  -- Required Columns
  uid as resource,
  case
    when rule ->> 'apiGroups' like '%*%'
      or rule ->> 'resources' like '%*%'
      or rule ->> 'verbs' like '%*%' then 'alarm'
    else 'ok'
  end as status,
  case
    when rule ->> 'apiGroups' like '%*%' then 'api groups uses wildcard.'
    when rule ->> 'resources' like '%*%' then 'resources uses wildcard.'
    when rule ->> 'verbs' like '%*%' then 'actions uses wildcard.'
    else 'no wildcard used.'
  end as reason,
  -- Additional Dimensions
  name as role_name,
  context_name
from
  kubernetes_cluster_role,
  jsonb_array_elements(rules) rule
where
  name not like '%system%'
group by
  uid,
  status,
  reason,
  role_name,
  context_name;