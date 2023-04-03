select
  -- Required Columns
  name ||  '_' || namespace as resource,
  case
    when automount_service_account_token then 'alarm'
    else 'ok'
  end as status,
  case
    when automount_service_account_token then name || ' service account token will be automatically mounted.'
    else name || ' service account token will not be automatically mounted.'
  end as reason,
  -- Additional Dimensions
  context_name,
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_pod;