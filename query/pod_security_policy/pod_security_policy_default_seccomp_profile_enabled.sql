select
  -- Required Columns
  uid as resource,
  case
    when annotations -> 'seccomp.security.alpha.kubernetes.io/defaultProfileName' = '"docker/default"' then 'ok'
    else 'alarm'
  end as status,
  case
    when annotations -> 'seccomp.security.alpha.kubernetes.io/defaultProfileName' = '"docker/default"' then name || ' seccompProfile enabled.'
    else name || ' seccompProfile not enabled.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;