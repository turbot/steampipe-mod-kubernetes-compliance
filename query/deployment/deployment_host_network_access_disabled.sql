select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
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
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_deployment;

