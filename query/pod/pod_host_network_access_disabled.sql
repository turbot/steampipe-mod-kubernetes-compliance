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
  context_name,
  source
from
  kubernetes_pod;