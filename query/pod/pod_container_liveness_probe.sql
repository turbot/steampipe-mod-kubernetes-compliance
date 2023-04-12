select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when c -> 'livenessProbe' is not null then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'livenessProbe' is not null then c ->> 'name' || ' has liveness probe.'
    else c ->> 'name' || ' does not have liveness probe.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name,
  source
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;