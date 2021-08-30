select
  -- Required Columns
  c ->> 'name' as resource,
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
  context_name
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;