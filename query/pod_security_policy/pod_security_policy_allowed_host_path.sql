select
  -- Required Columns
  name as resource,
  case when allowed_host_paths is null then
    'alarm'
  else
    'ok'
  end as status,
  case when allowed_host_paths is null then
    'Pod security policy ' || name || ' containers can use all host paths.'
  else
    'Pod security policy ' || name || ' containers using specified host path.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;

