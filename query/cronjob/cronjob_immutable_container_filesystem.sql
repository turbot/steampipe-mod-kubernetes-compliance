select
  -- Required Columns
  uid as resource,
  case
    when c -> 'securityContext' ->> 'readOnlyRootFilesystem' = 'true' then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'securityContext' ->> 'readOnlyRootFilesystem' = 'true' then c ->> 'name' || ' running with read only root file system.'
    else c ->> 'name' || ' not running with read only root file system.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_cronjob,
  jsonb_array_elements(job_template -> 'spec' -> 'template' -> 'spec' -> 'containers') as c;