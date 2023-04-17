select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when host_network then 'alarm'
    else 'ok'
  end as status,
  case
    when host_network then name || ' can use the host network.'
    else name || ' cannot use the host network.'
  end as reason,
  -- Additional Dimensions
  namespace,
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_pod;