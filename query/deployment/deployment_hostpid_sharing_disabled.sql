select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'Deployment pods share host PID namespaces.'
    else 'Deployment pods cannot share host PID namespaces.'
  end as reason,
  -- Additional Dimensions
  name as deployment_name,
  namespace,
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_deployment;

