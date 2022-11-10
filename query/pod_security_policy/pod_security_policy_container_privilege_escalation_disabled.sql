select
  -- Required Columns
  name as resource,
  case
    when not allow_privilege_escalation then 'ok'
    else 'alarm'
  end as status,
  case
    when not allow_privilege_escalation then 'Pod security policy ' || name || ' pods can not request to allow privilege escalation.'
    else 'Pod security policy ' || name || ' pods can request to allow privilege escalation.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;

