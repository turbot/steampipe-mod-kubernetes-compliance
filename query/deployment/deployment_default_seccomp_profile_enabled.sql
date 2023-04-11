select
  -- Required Columns
  case
    when path is null then uid
    else path || '-' || start_line
  end as resource,
  case
    when c -> 'securityContext' -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'securityContext' -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then name || ' seccompProfile enabled.'
    else name || ' seccompProfile disabled.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_deployment,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;