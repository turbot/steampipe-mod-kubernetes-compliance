select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
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
  source
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;