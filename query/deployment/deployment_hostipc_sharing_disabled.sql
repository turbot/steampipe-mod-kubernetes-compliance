select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
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
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_deployment;

