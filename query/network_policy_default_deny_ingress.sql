
with default_deny_ingress_count as (
  select 
    ns.uid,
    ns.name as namespace,
    ns.context_name,
    count(pol.*) as num_netpol,
    COUNT(*) FILTER (where policy_types @> '["Ingress"]' and pod_selector = '{}' and ingress is null) AS num_default_deny
  from kubernetes_namespace as ns
  left join kubernetes_network_policy as pol on pol.namespace = ns.name
  group by
    ns.name, 
    ns.uid,
    ns.context_name
)
select
  -- Required Columns
  uid as resource,
  case
    when num_default_deny > 0  then 'ok'
    else 'alarm'
  end as status,
  namespace || ' has ' || num_default_deny || ' default deny ingress policies.' as reason,
  -- Additional Dimensions
  namespace,
  context_name
from
  default_deny_ingress_count;