select
  -- Required Columns
  name ||  '_' || namespace as resource,
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
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c;