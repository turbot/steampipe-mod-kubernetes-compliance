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
  context_name,
  source
from
  kubernetes_pod;