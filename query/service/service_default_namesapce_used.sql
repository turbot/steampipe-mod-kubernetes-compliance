select
  -- Required Columns
  uid as resource,
  case
    when namespace = 'default' then 'alarm'
    else 'ok'
  end as status,
  case
    when namespace = 'default' then name || ' using default namespace.'
    else name || ' not using default namespace.'
  end as reason,
  -- Additional Dimensionss
  namespace,
  context_name
from
  kubernetes_service;