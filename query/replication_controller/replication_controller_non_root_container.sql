select
  -- Required Columns
  uid as resource,
  case
    when c -> 'securityContext' ->> 'runAsNonRoot' = 'true' then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'securityContext' ->> 'runAsNonRoot' = 'true' then c ->> 'name' || ' not running with root privilege.'
    else c ->> 'name' || ' running with root privilege.'
  end as reason,
  -- Additional Dimensions
  name as replication_controller_name,
  namespace,
  context_name
from
  kubernetes_replication_controller,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

