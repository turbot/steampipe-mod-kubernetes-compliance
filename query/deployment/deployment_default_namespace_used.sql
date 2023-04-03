select
  -- Required Columns
  name ||  '_' || namespace as resource,
  case
    when namespace = 'default' then 'alarm'
    else 'ok'
  end as status,
  case
    when namespace = 'default' then name || ' uses default namespace.'
    else name || ' not using the default namespace.'
  end as reason,
  -- Additional Dimensions
  namespace,
  context_name,
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_deployment;