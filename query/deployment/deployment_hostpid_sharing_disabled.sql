select
  -- Required Columns
  name ||  '_' || namespace as resource,
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
  context_name,
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_deployment;

