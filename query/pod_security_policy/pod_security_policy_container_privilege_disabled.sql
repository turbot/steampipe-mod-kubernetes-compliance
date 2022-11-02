select
  -- Required Columns
  name as resource,
  case when privileged then
    'alarm'
  else
    'ok'
  end as status,
  case when privileged then
    'Pod security policy ' || name || ' pods can run privileged containers.'
  else
    'Pod security policy ' || name || ' pods can not run privileged containers.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;

