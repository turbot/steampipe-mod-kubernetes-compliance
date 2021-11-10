with default_allows_all_egress_count as (
  select
    namespace,
    name,
    uid,
    context_name,
    -- Get the count of default allow Egress policy
    count(*) filter (where rule = '{}') as num_allow_all_rules
  from
    kubernetes_network_policy
    left join jsonb_array_elements(egress) as rule on true
  group by
    namespace,
    name,
    uid,
    context_name,
    rule,
    policy_types
)
select
  uid as resource,
  case
    when num_allow_all_rules > 0 then 'alarm'
    else 'ok'
  end as status,
  case
    when num_allow_all_rules > 0 then name || ' allows all egress'
    else name || ' does not allow all egress'
  end as reason,
  namespace,
  context_name
from
  default_allows_all_egress_count;

