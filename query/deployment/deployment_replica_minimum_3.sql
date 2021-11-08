select
  -- Required Columns
  uid as resource,
  case
    when replicas < 3 then 'alarm'
    else 'ok'
  end as status,
  case
    when replicas < 3 then name || ' has ' || replicas || ' replicas.'
    else name || ' has ' || replicas || ' replicas.'
  end as reason,
  -- Additional Dimensions
  namespace,
  context_name
from
  kubernetes_deployment;