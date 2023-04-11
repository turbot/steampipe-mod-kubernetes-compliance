select
  -- Required Columns
  case
    when path is null then uid
    else path || '-' || start_line
  end as resource,
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
  context_name
from
  kubernetes_pod;