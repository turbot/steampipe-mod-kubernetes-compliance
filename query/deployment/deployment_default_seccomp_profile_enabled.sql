select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when c -> 'securityContext' -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'securityContext' -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then name || ' seccompProfile enabled.'
    else name || ' seccompProfile disabled.'
  end as reason,
  -- Additional Dimensions
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_deployment,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;