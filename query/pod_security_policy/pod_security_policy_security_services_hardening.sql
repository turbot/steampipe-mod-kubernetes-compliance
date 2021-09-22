select
  -- Required Columns
  uid as resource,
  case
    when se_linux -> 'rule' = '"MustRunAs"' then 'ok'
    when annotations -> 'apparmor.security.beta.kubernetes.io/defaultProfileName' = '"runtime/default"' then 'ok'
    when annotations -> 'seccomp.security.alpha.kubernetes.io/defaultProfileName' = '"runtime/default"' then 'ok'
    else 'alarm'
  end as status,
  case
    when se_linux -> 'rule' = '"MustRunAs"' then 'Applications using SELinux security service.'
    when annotations -> 'apparmor.security.beta.kubernetes.io/defaultProfileName' = '"runtime/default"' then 'Pods using AppArmor security service.'
    when annotations -> 'seccomp.security.alpha.kubernetes.io/defaultProfileName' = '"runtime/default"' then 'Pods using Seccomp security service.'
    else 'Pods not using securty services.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;