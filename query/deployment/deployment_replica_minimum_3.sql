select
  -- Required Columns
  name ||  '_' || namespace as resource,
  case
    when replicas < 3 then 'alarm'
    else 'ok'
  end as status,
  name || ' has ' || replicas || ' replica.' as reason,
  -- Additional Dimensions
  namespace,
  context_name,
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_deployment;