select
  -- Required Columns
  case
    when manifest_file_path is null then uid
    else name ||  '_' || namespace || '-' || manifest_file_path
  end as resource,
  case
    when c -> 'resources' -> 'limits' ->> 'cpu' is null then 'alarm'
    else 'ok'
  end as status,
  case
    when c -> 'resources' -> 'limits' ->> 'cpu' is null then c ->> 'name' || ' does not have a CPU limit.'
    else c ->> 'name' || ' has a CPU limit of ' || (c -> 'resources' -> 'limits' ->> 'cpu') || '.'
  end as reason,
  -- Additional Dimensions
  name as deployment_name,
  namespace,
  context_name,
  case
    when manifest_file_path is null then 'Deployed'
    else 'Manifest'
  end as source
from
  kubernetes_deployment,
  jsonb_array_elements(template -> 'spec' -> 'containers') as c;

