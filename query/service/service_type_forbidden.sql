select
  -- Required Columns
  name as resource,
  case
    when type in ('NodePort','LoadBalancer') then 'alarm'
    else 'ok'
  end as status,
  case
    when type in ('NodePort','LoadBalancer') then 'Containers using ' || name || ' service exposed through ' || type || ' service type.'
    else 'Containers using ' || name || ' service not exposed through a forbidden service type.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_service;