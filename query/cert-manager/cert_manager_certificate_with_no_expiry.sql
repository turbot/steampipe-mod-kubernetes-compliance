select
  -- Required Columns
  uid as resource,
  case when "spec_renewBefore" is null then
    'alarm'
  else
    'ok'
  end as status,
  case when "spec_renewBefore" is null then
    name || ' with no expiry.'
  else
    name || ' has expiry time.'
  end as reason,
  -- Additional Dimensionss
  namespace
from
  "certificates.cert-manager.io";

