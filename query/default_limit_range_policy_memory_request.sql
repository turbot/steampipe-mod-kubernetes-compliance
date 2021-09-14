with default_limit_range as (
  select
    namespace,
    l -> 'default' as default_limit,
    l -> 'defaultRequest' as default_request
    from
    kubernetes_limit_range,
    jsonb_array_elements(spec_limits) as l
)

select
  -- Required Columns
  n.uid as resource,
  case
    when default_request ->> 'memory' is null then 'alarm'
    else 'ok'
  end as status,
  case
    when default_request ->> 'memory' is null then n.name || ' dont have default limit range policy memory request.'
    else n.name || ' has default limit range policy memory request.'
  end as reason,
  -- Additional Dimensions
  n.context_name
from
  kubernetes_namespace n
  left join default_limit_range r
  on n.name = r.namespace;