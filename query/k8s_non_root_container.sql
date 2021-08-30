select
  -- Required Columns
  name as resource,
  case
    when run_as_user -> 'rule' = '"MustRunAsNonRoot"' then 'ok'
    else 'alarm'
  end as status,
  case
    when run_as_user -> 'rule' = '"MustRunAsNonRoot"' then 'Container applications not running with root privileges.'
    else 'Container applications running with root privileges.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;