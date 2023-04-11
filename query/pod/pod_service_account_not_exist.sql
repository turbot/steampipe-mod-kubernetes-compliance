select
  -- Required Columns
  distinct case
    when p.path is null then p.uid
    else p.path || '-' || p.start_line
  end as resource,
  case
    when service_account_name is not null and service_account_name <> '' then 'ok'
    else 'alarm'
  end as status,
  case
    when service_account_name is not null and service_account_name <> '' then p.name || ' refer to an existing service account.'
    else p.name || ' does not refer to an existing service account.'
  end as reason,
  -- Additional Dimensions
  p.namespace,
  p.context_name
from
  kubernetes_pod p 
  left join kubernetes_service_account a on p.service_account_name = a.name;