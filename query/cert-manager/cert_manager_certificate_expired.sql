select
  -- Required Columns
  uid as resource,
  case when "spec_renewBefore" is not null and now() > creation_timestamp + (interval '1 hour' * NULLIF(left("spec_renewBefore", length("spec_renewBefore")-2), '')::int) then
    'alarm'
  else
    'ok'
  end as status,
  case when "spec_renewBefore" is not null and now() > creation_timestamp + (interval '1 hour' * NULLIF(left("spec_renewBefore", length("spec_renewBefore")-2), '')::int) then
    name || ' certificate is expired.'
  else
    name || ' certificate is not expired.'
  end as reason,
  -- Additional Dimensionss
  namespace
from
  "certificates.cert-manager.io";