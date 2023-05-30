# Kubernetes Compliance Mod for Steampipe

Multiple checks covering industry defined security best practices for Kubernetes. The mod supports parsing and analyzing Kubernetes manifest files, allowing you to assess compliance directly on your configuration files before deployment. Includes support for CIS, National Security Agency (NSA) and Cybersecurity and Infrastructure Security Agency (CISA) Cybersecurity technical report for Kubernetes hardening.

Run checks in a dashboard:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-kubernetes-compliance/main/docs/kubernetes_nsa_csa_v1.png)

Or in a terminal:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-kubernetes-compliance/main/docs/kubernetes-compliance-mod-console-output.png)

Includes support for:

* [v1.0 NSA and CISA Cybersecurity Technical Report](https://media.defense.gov/2021/Aug/03/2002820425/-1/-1/1/CTR_KUBERNETES%20HARDENING%20GUIDANCE.PDF)
* [CIS Kubernetes v1.20](https://hub.steampipe.io/mods/turbot/kubernetes_compliance/controls/benchmark.cis_kube_v120)
* [CIS v1.7.0](https://hub.steampipe.io/mods/turbot/kubernetes_compliance/controls/benchmark.cis_v170) 🚀 New!

## Getting started

### Installation

Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```sh
brew tap turbot/tap
brew install steampipe
```

Install the Kubernetes plugin with [Steampipe](https://steampipe.io):

```sh
steampipe plugin install kubernetes
```

Clone:

```sh
git clone https://github.com/turbot/steampipe-mod-kubernetes-compliance.git
cd steampipe-mod-kubernetes-compliance
```

### Usage

Start your dashboard server to get started:

```sh
steampipe dashboard
```

By default, the dashboard interface will then be launched in a new browser
window at http://localhost:9194. From here, you can run benchmarks by
selecting one or searching for a specific one.

Instead of running benchmarks in a dashboard, you can also run them within your
terminal with the `steampipe check` command:

Run all benchmarks:

```sh
steampipe check all
```

Run a single benchmark::

```sh
steampipe check benchmark.nsa_cisa_v1_network_hardening_cpu_limit
```

Run a specific control:

```sh
steampipe check control.daemonset_cpu_limit
```

Different output formats are also available, for more information please see
[Output Formats](https://steampipe.io/docs/reference/cli/check#output-formats).

### Credentials

This mod uses the credentials configured in the [Steampipe Kubernetes plugin](https://hub.steampipe.io/plugins/turbot/kubernetes).

### Configuration

No extra configuration is required.

### Common and Tag Dimensions

The benchmark queries use common properties (like `connection_name`, `context_name`, `namespace` and `source_type`) and tags are defined in the form of a default list of strings in the `mod.sp` file. These properties can be overwritten in several ways:

- Copy and rename the `steampipe.spvars.example` file to `steampipe.spvars`, and then modify the variable values inside that file

- Pass in a value on the command line:

  ```shell
  steampipe check benchmark.cis_kube_v120 --var 'common_dimensions=["connection_name", "context_name", "namespace", "source_type"]'
  ```

  ```shell
  steampipe check benchmark.cis_kube_v120 --var 'tag_dimensions=["Environment", "Owner"]'
  ```

- Set an environment variable:

  ```shell
  SP_VAR_common_dimensions='["connection_name", "context_name", "namespace", "source_type"]' steampipe check control.cis_kube_v120_v100_5_2_1
  ```

  ```shell
  SP_VAR_tag_dimensions='["Environment", "Owner"]' steampipe check control.cis_kube_v120_v100_5_2_1
  ```

## Contributing

If you have an idea for additional controls or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing.

- **[Join our Slack community →](https://steampipe.io/community/join)** and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-kubernetes-compliance/blob/main/LICENSE).

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [Kubernetes Compliance Mod](https://github.com/turbot/steampipe-mod-kubernetes-compliance/labels/help%20wanted)
