select
  -- Required Columns
  name ||  '_' || namespace as resource,
  case
    when c -> 'resources' -> 'limits' ->> 'memory' is null then 'alarm'
    else 'ok'
  end as status,
  case
    when c -> 'resources' -> 'limits' ->> 'memory' is null then c ->> 'name' || ' does not have a memory limit.'
    else c ->> 'name' || ' has a memory limit of ' || (c -> 'resources' -> 'limits' ->> 'memory') || '.'
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

