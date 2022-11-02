select
  -- Required Columns
  uid as resource,
  case when template -> 'spec' ->> 'hostNetwork' = 'true' then
    'alarm'
  else
    'ok'
  end as status,
  case when template -> 'spec' ->> 'hostNetwork' = 'true' then
    'StatefulSet pods using host network.'
  else
    'StatefulSet pods not using host network.'
  end as reason,
  -- Additional Dimensions
  name as statefulset_name,
  namespace,
  context_name
from
  kubernetes_stateful_set;

