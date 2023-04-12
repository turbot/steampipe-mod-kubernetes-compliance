select
  -- Required Columns
  coalesce(uid, concat(path, ':', start_line)) as resource,
  case
    when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then 'ok'
    else 'alarm'
  end as status,
  case
    when c -> 'securityContext' ->> 'allowPrivilegeEscalation' = 'false' then c ->> 'name' || ' can not request to allow privilege escalation.'
    else c ->> 'name' || ' can request to allow privilege escalation.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name,
  source
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;