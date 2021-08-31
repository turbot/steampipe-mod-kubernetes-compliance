select
  -- Required Columns
  distinct(namespace) as resource,
  case
    when name = 'kube-root-ca.crt'  then 'alarm'
    else 'ok'
  end as status,
  case
    when name = 'kube-root-ca.crt' then namespace || ' has credentials in configuration file.'
    else namespace || ' does not have credentials in configuration file.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_config_map;