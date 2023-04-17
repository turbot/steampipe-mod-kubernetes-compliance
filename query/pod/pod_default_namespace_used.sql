select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
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
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_pod;