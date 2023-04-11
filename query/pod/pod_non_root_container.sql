select
  -- Required Columns
  case
    when manifest_file_path is null then uid
    else manifest_file_path || '-' || start_line
  end as resource,
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
  context_name
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;