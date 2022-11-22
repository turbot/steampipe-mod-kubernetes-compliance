select
  -- Required Columns
  uid as resource,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'Job pods share host PID namespaces.'
    else 'Job pods cannot share host PID namespaces.'
  end as reason,
  -- Additional Dimensions
  name as job_name,
  namespace,
  context_name
from
  kubernetes_job;

