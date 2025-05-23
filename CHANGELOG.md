## v1.0.2 [2025-04-15]

_Bug fixes_

- Fixed the `pod_host_network_access_disabled` query to include the `Kubernetes/Pod` service tag. ([#94](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/94))

## v1.0.1 [2024-10-24]

_Bug fixes_

- Renamed `steampipe.spvars.example` files to `powerpipe.ppvars.example` and updated documentation. ([#92](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/92))

## v1.0.0 [2024-10-22]

This mod now requires [Powerpipe](https://powerpipe.io). [Steampipe](https://steampipe.io) users should check the [migration guide](https://powerpipe.io/blog/migrating-from-steampipe).

## v0.18 [2024-03-06]

_Powerpipe_

[Powerpipe](https://powerpipe.io) is now the preferred way to run this mod!  [Migrating from Steampipe →](https://powerpipe.io/blog/migrating-from-steampipe)

All v0.x versions of this mod will work in both Steampipe and Powerpipe, but v1.0.0 onwards will be in Powerpipe format only.

_Enhancements_

- Focus documentation on Powerpipe commands.
- Show how to combine Powerpipe mods with Steampipe plugins.

## v0.17 [2023-11-03]

_Breaking changes_

- Updated the plugin dependency section of the mod to use `min_version` instead of `version`. ([#82](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/82))

_Bug fixes_

- Updated the docs to include the correct links for the `nsa_cisa_v1` benchmark. ([#80](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/80)) (Thanks [@aniketh-varma](https://github.com/aniketh-varma) for the contribution!)
- Fixed the following queries to cast the data to boolean format. ([#79](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/79))
  - `cronjob_container_privilege_disabled`
  - `cronjob_host_network_access_disabled`
  - `cronjob_hostpid_hostipc_sharing_disabled`
  - `cronjob_immutable_container_filesystem`
  - `cronjob_non_root_container`
  - `daemonset_container_privilege_disabled`
  - `daemonset_host_network_access_disabled`
  - `daemonset_hostpid_hostipc_sharing_disabled`
  - `daemonset_immutable_container_filesystem`
  - `daemonset_non_root_container`
  - `deployment_container_privilege_disabled`
  - `deployment_host_network_access_disabled`
  - `deployment_hostpid_hostipc_sharing_disabled`
  - `deployment_immutable_container_filesystem`
  - `deployment_non_root_container`
  - `job_container_privilege_disabled`
  - `job_host_network_access_disabled`
  - `job_hostpid_hostipc_sharing_disabled`
  - `job_immutable_container_filesystem`
  - `job_non_root_container`
  - `pod_container_privilege_disabled`
  - `pod_immutable_container_filesystem`
  - `pod_non_root_container`
  - `pod_service_account_token_enabled`
  - `pod_template_container_privilege_disabled`
  - `pod_template_immutable_container_filesystem`
  - `replicaset_container_privilege_disabled`
  - `replicaset_host_network_access_disabled`
  - `replicaset_hostpid_hostipc_sharing_disabled`
  - `replicaset_immutable_container_filesystem`
  - `replicaset_non_root_container`
  - `replication_controller_container_privilege_disabled`
  - `replication_controller_host_network_access_disabled`
  - `replication_controller_hostpid_hostipc_sharing_disabled`
  - `replication_controller_immutable_container_filesystem`
  - `replication_controller_non_root_container`
  - `statefulset_container_privilege_disabled`
  - `statefulset_host_network_access_disabled`
  - `statefulset_hostpid_hostipc_sharing_disabled`
  - `statefulset_immutable_container_filesystem`
  - `statefulset_non_root_container`

## v0.16 [2023-10-04]

_Bug fixes_

- Fixed queries to correctly return data for `connection_name` and `tags` dimensions instead of an error. ([#73](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/73))

## v0.15 [2023-10-03]

_What's new?_

- Added 39 new controls for the `ClusterRoleBinding`, `CronJob`, `DaemonSet`, `Ingress`, `Job`, `Pod` resource types to the `all_controls` benchmark. ([#68](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/68))

## v0.14 [2023-09-29]

_What's new?_

- Added 350+ new controls across all resource types to the `all_controls` benchmark. ([#64](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/64))

_Enhancements_

- Added `path` to default set of `common_dimensions`, so now any file paths will appear by default in the additional dimensions in control results. ([#63](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/63))
- Added `iac` category to mod definition.

_Dependencies_

- Kubernetes plugin `v0.23.0` or higher is now required.

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

- Added 90 new controls to the `All Controls` benchmark for the following services: ([#56](https://github.com/turbot/steampipe-mod-kubernetes-compliance/pull/56))
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
