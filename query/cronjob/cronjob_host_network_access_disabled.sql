select
  -- Required Columns
  uid as resource,
  case when job_template -> 'spec' -> 'template' -> 'spec' ->> 'hostNetwork' = 'true' then 'alarm'
  else 'ok'
  end as status,
  case when job_template -> 'spec' -> 'template' -> 'spec' ->> 'hostNetwork' = 'true' then 'CronJob pods using host network.'
  else 'CronJob pods not using host network.'
  end as reason,
  -- Additional Dimensions
  name as cronjob_name,
  namespace,
  context_name
from
  kubernetes_cronjob;

