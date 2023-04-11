select
  -- Required Columns
  case
    when path is null then uid
    else path || '-' || start_line
  end as resource,
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
  context_name
from
  kubernetes_pod;