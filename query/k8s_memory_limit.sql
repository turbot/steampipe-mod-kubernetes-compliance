select
  -- Required Columns
  uid as resource,
  case
    when c -> 'resources' -> 'limits' ->> 'memory' is null then 'alarm'
    else 'ok'
  end as status,
  case
    when c -> 'resources' -> 'limits' ->> 'memory' is null then c ->> 'name' || ' do not have memory limit.'
    else c ->> 'name' || ' has memory limit of ' || (c -> 'resources' -> 'limits' ->> 'memory') || '.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_deployment,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;