select
  -- Required Columns
  name ||  '_' || namespace as resource,
  case
    when security_context -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then 'ok'
    else 'alarm'
  end as status,
  case
    when security_context -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then name || ' seccompProfile enabled.'
    else name || ' seccompProfile disabled.'
  end as reason,
  -- Additional Dimensions
  namespace,
  context_name,
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_pod;