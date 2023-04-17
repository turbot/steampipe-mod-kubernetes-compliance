select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when c -> 'securityContext' ->> 'runAsNonRoot' = 'true' then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'securityContext' ->> 'runAsNonRoot' = 'true' then c ->> 'name' || ' not running with root privilege.'
    else c ->> 'name' || ' running with root privilege.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;