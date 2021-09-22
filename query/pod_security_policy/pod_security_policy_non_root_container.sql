select
  -- Required Columns
  uid as resource,
  case
    when run_as_user ->> 'rule' = 'MustRunAsNonRoot' then 'ok'
    else 'alarm'
  end as status,
  case
    when run_as_user ->> 'rule' = 'MustRunAsNonRoot' then 'Pod security policy ' || name || ' restrict containers to run as non-root user.'
    else 'Pod security policy' || name || ' does not restrict containers to run as non-root user'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_pod_security_policy;
