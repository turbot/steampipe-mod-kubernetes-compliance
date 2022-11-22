select
  -- Required Columns
  name as resource,
  case
    when automount_service_account_token then 'alarm'
    else 'ok'
  end as status,
  case
    when automount_service_account_token then name || ' service account token will be automatically mounted.'
    else name || ' service account token will not be automatically mounted.'
  end as reason,
  -- Additional Dimensions
  context_name
from
  kubernetes_service_account;

