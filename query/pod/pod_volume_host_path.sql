select
  -- Required Columns
  distinct(name) as resource,
  case
    when v -> 'hostPath' -> 'path' is null then 'ok'
    else 'alarm'
  end as status,
  case
    when v -> 'hostPath' -> 'path' is null then 'No host path volume mounted.'
    else 'Host path volume mounted for ' || (v ->> 'name') || '.'
  end as reason,
  -- Additional Dimensions
  namespace,
  context_name,
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_pod,
  jsonb_array_elements(volumes) as v;