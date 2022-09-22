select
  -- Required Columns
  uid as resource,
  case
    when "spec_renewBefore" is null then 'skip'
    when now() > creation_timestamp + (interval '1 hour' * NULLIF(left("spec_renewBefore", length("spec_renewBefore")-1), '')::int) then 'alarm'
    else
      'ok'
    end as status,
  case
    when "spec_renewBefore" is null then name || ' certificate has no expiration date.'
    when now() > creation_timestamp + (interval '1 hour' * NULLIF(left("spec_renewBefore", length("spec_renewBefore")-1), '')::int) then name || ' certificate has expired.'
  else
    name || ' certificate has not expired.'
  end as reason,
  -- Additional Dimensionss
  namespace
from
  "certificates.cert-manager.io";