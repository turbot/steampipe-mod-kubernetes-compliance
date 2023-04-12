select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when replicas < 3 then 'alarm'
    else 'ok'
  end as status,
  name || ' has ' || replicas || ' replica.' as reason,
  -- Additional Dimensions
  namespace,
  context_name,
  source
from
  kubernetes_deployment;