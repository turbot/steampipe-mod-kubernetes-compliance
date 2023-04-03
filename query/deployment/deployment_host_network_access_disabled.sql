select
  -- Required Columns
  name ||  '_' || namespace as resource,
  case
    when template -> 'spec' ->> 'hostNetwork' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostNetwork' = 'true' then 'Deployment pods using host network.'
    else 'Deployment pods not using host network.'
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

