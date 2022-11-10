select
  -- Required Columns
  uid as resource,
  case
    when c -> 'securityContext' ->> 'runAsNonRoot' = 'true' then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'securityContext' ->> 'runAsNonRoot' = 'true' then c ->> 'name' || ' not running with root privilege.'
    else c ->> 'name' || ' running with root privilege.'
  end as reason,
  -- Additional Dimensions
  name as cronjob_name,
  namespace,
  context_name
from
  kubernetes_cronjob,
  jsonb_array_elements(job_template -> 'spec' -> 'template' -> 'spec' -> 'containers') as c;

