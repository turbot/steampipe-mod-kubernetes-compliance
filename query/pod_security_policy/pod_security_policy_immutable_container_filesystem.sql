select
  -- Required Columns
  name as resource,
  case
    when read_only_root_filesystem then 'ok'
    else 'alarm'
  end as status,
  case
    when read_only_root_filesystem then 'Containers running with read only root file system.'
    else 'Containers not running with read only root file system.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;