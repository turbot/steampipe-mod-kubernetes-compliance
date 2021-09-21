select
  -- Required Columns
  name as resource,
  case
    when allowed_host_paths is null then 'alarm'
    else 'ok'
  end as status,
  case
    when allowed_host_paths is null then 'Containers can use all host paths.'
    else 'Containers using specified host path.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;