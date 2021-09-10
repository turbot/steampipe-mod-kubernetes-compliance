select
  -- Required Columns
  uid as resource,
  case
    when allowed_host_paths is null then 'alarm'
    else 'ok'
  end as status,
  case
    when allowed_host_paths is null then 'Pod security policy allows containers to use hostPath mounts.'
    else 'Pod security policy restricts containers to only specific hostPath mounts.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;