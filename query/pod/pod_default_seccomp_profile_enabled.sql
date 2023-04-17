select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
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
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_pod;