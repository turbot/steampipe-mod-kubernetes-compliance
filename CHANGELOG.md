## v0.13 [2023-09-25]

_Enhancements_

- Added 112 new controls to the `All Controls` benchmark for the following services: ([#59](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/59))
  - `CronJob`
  - `DaemonSet`
  - `Deployment`
  - `Job`
  - `Pod`
  - `ReplicaSet`
  - `ReplicationController`
  - `StatefulSet`

## v0.12 [2023-09-15]

_Enhancements_

- Added 90 new controls to the `All Controls` benchmark for the following services: ([#55](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/55))
  - `CronJob`
  - `DaemonSet`
  - `Deployment`
  - `Job`
  - `Pod`
  - `ReplicaSet`
  - `ReplicationController`
  - `StatefulSet`

_Bug fixes_

- Fixed the `role_with_wildcards_used` control to correctly return data instead of an error. ([#54](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/54))

## v0.11 [2023-09-05]

_Breaking changes_

- The `Other Compliance Checks` benchmark (`steampipe check benchmark.other_checks`) has been removed and replaced by the new `All Controls` benchmark (`steampipe check benchmark.all_controls`). This new benchmark includes 154 service-specific controls. ([#47](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/47))

_Bug fixes_

- Fixed the `namespace_*` queries to use the correct common dimensions. ([#49](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/49))

## v0.10 [2023-06-02]

_Dependencies_

- Kubernetes plugin `v0.20.0` or higher is now required. ([#41](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/41))

_What's new?_

- Added `path` and `source_type` in the common dimensions to group and filter findings. (see [var.common_dimensions](https://hub.steampipe.io/mods/turbot/kubernetes_compliance/variables)) ([#41](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/41))

_Enhancements_

- Updated the `resource` column to use `path` and `start_line` for manifest resources. ([#41](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/41))

## v0.9 [2023-05-18]

_What's new?_

- Added CIS v1.7.0 for Kubernetes v1.25 benchmark (`steampipe check benchmark.cis_v170`). ([#35](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/35))
- Added `connection_name` in the common dimensions to group and filter findings. (see [var.common_dimensions](https://hub.steampipe.io/mods/turbot/kubernetes_compliance/variables)) ([#34](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/34))
- Added `tags` as dimensions to group and filter findings. (see [var.tag_dimensions](https://hub.steampipe.io/mods/turbot/kubernetes_compliance/variables)) ([#34](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/34))

_Bug fixes_

- Fixed dashboard localhost URLs in README and index doc. ([#37](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/37))

## v0.8 [2023-04-13]

_Bug fixes_

- Fixed the structure and the order of sub-benchmarks and controls of `cis_kube_v120_v100_5` benchmark based on the CIS documentation. ([#30](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/30))

## v0.7 [2022-11-22]

_Bug fixes_

- Fixed `pod_service_account_token_disabled`, `pod_security_policy_*` and `service_account_token_disabled` queries to include the name of the relevant resource in the `Reason` column of the compliance report. ([#23](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/23))

## v0.6 [2022-05-09]

_Enhancements_

- Added `category`, `service`, and `type` tags to benchmarks and controls. ([#18](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/18))

_Breaking changes_

- Updated all CIS Kubernetes v1.20 v1.0.0 filenames, benchmarks, and controls to include the Kubernetes version for future version compatibility. ([#18](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/18))
- Fixed all typos in control and query names namesapce->namespace. ([#18](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/18))

## v0.5 [2022-01-19]

_What's new?_

- Added a new benchmark (`cis_v100_5_7_2`) to the `CIS v1.0.0 for Kubernetes v1.20` benchmark ([#13](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/13))
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
