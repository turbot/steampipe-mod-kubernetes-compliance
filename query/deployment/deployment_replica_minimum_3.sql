select
  -- Required Columns
  uid as resource,
  case
    when replicas < 3 then 'alarm'
    else 'ok'
  end as status,
  name || ' has ' || replicas || ' replica.' as reason,
  -- Additional Dimensions
  namespace,
  context_name
from
  kubernetes_deployment;