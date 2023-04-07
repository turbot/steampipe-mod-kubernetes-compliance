select
  -- Required Columns
  case
    when manifest_file_path is null then uid
    else name ||  '_' || namespace || '-' || manifest_file_path
  end as resource,
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
  context_name,
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_deployment;

