select
  -- Required Columns
  uid as resource,
  case when template -> 'spec' ->> 'hostNetwork' = 'true' then 'alarm'
  else 'ok'
  end as status,
  case when template -> 'spec' ->> 'hostNetwork' = 'true' then 'Deployment pods using host network.'
  else 'Deployment pods not using host network.'
  end as reason,
  -- Additional Dimensions
  name as deployment_name,
  namespace,
  context_name
from
  kubernetes_deployment;

