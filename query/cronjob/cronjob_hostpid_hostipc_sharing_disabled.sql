select
  -- Required Columns
  uid as resource,
  case
    when job_template -> 'spec' -> 'template' -> 'spec' ->> 'hostPID' = 'true' 
    or job_template -> 'spec' -> 'template' -> 'spec' ->> 'hostIPC' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when job_template -> 'spec' -> 'template' -> 'spec' ->> 'hostPID' = 'true' then 'CronJob pods share host pid namespaces.'
    when job_template -> 'spec' -> 'template' -> 'spec' ->> 'hostIPC' = 'true' then 'CronJob pods share host ipc namespaces.'
    else 'CronJob pods cannot share host process namespaces.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_cronjob;