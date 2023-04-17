select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then c ->> 'name' || ' not allowed root elevation.'
    else c ->> 'name' || ' allowed root elevation.'
  end as reason,
  -- Additional Dimensions
  name as deployment_name,
  namespace,
  coalesce(context_name, '') as context_name,
  source_type
from
  kubernetes_deployment,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

