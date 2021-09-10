with pod_host_path_vols as (
  select
    uid,
    name,
    count(*) as num_mounts,
    count(*) filter (where v -> 'hostPath' -> 'path' is not null)  as num_hostpath_mounts,
    namespace,
    context_name
  from
    kubernetes_pod,
    jsonb_array_elements(volumes) as v
  group by
    uid,
    name,
    namespace,
    context_name
)

select
  -- Required Columns
  uid as resource,
  case
    when num_hostpath_mounts = 0  then 'ok'
    else 'alarm'
  end as status,
  name || ' has ' || num_hostpath_mounts || ' hostPath volumes.' as reason,
  -- Additional Dimensions
  namespace,
  context_name
from
  pod_host_path_vols;