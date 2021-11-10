select
  -- Required Columns
  uid as resource,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'Deployment pods share host PID namespaces.'
    else 'Deployment pods cannot share host PID namespaces.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_deployment;