select
  -- Required Columns
  uid as resource,
  case when "spec_renewBefore" is null then
    'alarm'
  else
    'ok'
  end as status,
  case when "spec_renewBefore" is null then
    name || ' has no expiration date.'
  else
    name || ' has expiration date.'
  end as reason,
  -- Additional Dimensionss
  namespace
from
  "certificates.cert-manager.io";

