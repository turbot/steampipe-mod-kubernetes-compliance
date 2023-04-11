select
  -- Required Columns
  case
    when manifest_file_path is null then uid
    else manifest_file_path || '-' || start_line
  end as resource,
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
  kubernetes_pod;