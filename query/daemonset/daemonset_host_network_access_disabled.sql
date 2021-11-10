select
  -- Required Columns
  uid as resource,
  case
    when template -> 'spec' ->> 'hostNetwork' = 'true' then 'alarm'
    else 'ok'
  end as status,
  case
    when template -> 'spec' ->> 'hostNetwork' = 'true' then 'DaemonSet pods using host network.'
    else 'DaemonSet pods not using host network.'
  end as reason,
  -- Additional Dimensions
  name as pod_name,
  namespace,
  context_name
from
  kubernetes_daemonset;