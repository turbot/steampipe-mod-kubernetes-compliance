select
  -- Required Columns
  name as resource,
  case
    when annotations ->> 'container.apparmor.security.beta.kubernetes.io/?' = 'runtime/default' then 'ok'
    when security_context -> 'seLinuxOptions' ->> 'level' is not null then 'ok'
    when security_context -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then 'ok'
    else 'alarm'
  end as status,
  case
    when annotations ->> 'container.apparmor.security.beta.kubernetes.io/?' = 'runtime/default' then 'Applications using AppArmor security service.'
    when security_context -> 'seLinuxOptions' ->> 'level' is not null then 'Applications using SELinux security service.'
    when security_context -> 'seccompProfile' ->> 'type' = 'RuntimeDefault' then 'Applications using seccomp security service.'
    else 'Applications are not using any security service.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod;