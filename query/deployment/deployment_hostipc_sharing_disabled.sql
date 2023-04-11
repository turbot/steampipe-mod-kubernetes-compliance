select
  -- Required Columns
  case
    when path is null then uid
    else path || '-' || start_line
  end as resource,
  case
    when template -> 'spec' ->> 'hostIPC' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostIPC' = 'true' then 'Deployment pods share host IPC namespaces.'
    else 'Deployment pods cannot share host IPC namespaces.'
  end as reason,
  -- Additional Dimensions
  name as deployment_name,
  namespace,
  context_name
from
  kubernetes_deployment;

