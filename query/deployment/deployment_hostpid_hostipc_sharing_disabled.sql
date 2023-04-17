select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' or template -> 'spec' ->> 'hostIPC' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostPID' = 'true' then 'Deployment pods share host pid namespaces.'
    when template -> 'spec' ->> 'hostIPC' = 'true' then 'Deployment pods share host ipc namespaces.'
    else 'Deployment pods cannot share host process namespaces.'
  end as reason,
  -- Additional Dimensions
  name as deployment_name,
  namespace,
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_deployment;

