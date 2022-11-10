select
  -- Required Columns
  uid as resource,
  case when template -> 'spec' ->> 'hostNetwork' = 'true' then 'alarm'
  else 'ok'
  end as status,
  case when template -> 'spec' ->> 'hostNetwork' = 'true' then 'Job pods using host network.'
  else 'Job pods not using host network.'
  end as reason,
  -- Additional Dimensions
  name as job_name,
  namespace,
  context_name
from
  kubernetes_job;

