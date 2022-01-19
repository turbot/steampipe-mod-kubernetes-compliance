## v0.5 [2022-01-19]

_What's new?_

- Added a new benchmark (`cis_v100_5_7_2`) to the `CIS v1.0.0 for Kubernetes v1.20` benchmark
- Added new controls for `CronJob`, `ConfigMap`, `Ingress`, `Role`, `RoleBinding`, `Secret` and `StatefulSet` resource types to `CIS v1.0.0 for Kubernetes v1.20`, `Extra Checks` and `NSA CISA Kubernetes Hardening Guidance v1` benchmarks ([#13](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/13))

## v0.4 [2021-11-12]

_Enhancements_

- `docs/index.md` file now includes the console output image

## v0.3 [2021-11-10]

_What's new?_

- Added: CIS v1.0.0 for Kubernetes v1.20 benchmark (`steampipe check kubernetes_compliance.benchmark.cis_kubernetes_v120`)
- Added: Extra Checks benchmark (`steampipe check kubernetes_compliance.benchmark.extra_checks`) to provide additional information around other Kubernetes compliance best practices

## v0.2 [2021-09-22]

_Bug fixes_

- Fixed: Broken links in docs/index.md to mod controls and queries

## v0.1 [2021-09-22]

_What's new?_

- Added: NSA CISA Kubernetes Hardening Guidance v1 benchmark (`steampipe check benchmark.nsa_cisa_v1`)
