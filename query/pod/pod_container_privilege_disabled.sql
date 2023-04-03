select
  -- Required Columns
  name ||  '_' || namespace as resource,
  case
    when c -> 'securityContext' ->> 'privileged' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when c -> 'securityContext' ->> 'privileged' = 'true' then c ->> 'name' || ' running with privilege access.'
    else c ->> 'name' || ' not running with privilege access.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name,
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;