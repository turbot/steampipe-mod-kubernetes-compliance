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
  name as deployment_name,
  namespace,
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_deployment,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

