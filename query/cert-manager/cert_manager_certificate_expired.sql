select
  -- Required Columns
  uid as resource,
  case when "spec_renewBefore" is not null and replace("spec_renewBefore",'h','')::INTEGER <= 0 then
    'alarm'
  else
    'ok'
  end as status,
  case when "spec_renewBefore" is not null and replace("spec_renewBefore",'h','')::INTEGER <= 0 then
    name || ' certificate is expired.'
  else
    name || ' certificate is not expired.'
  end as reason,
  -- Additional Dimensionss
  namespace
from
  "certificates.cert-manager.io";