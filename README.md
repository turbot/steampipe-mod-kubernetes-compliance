# Kubernetes Compliance Scanning Tool

Run individual controls or full compliance benchmarks for NSA CISA Kubernetes Hardening Guidance across all of your Kubernetes clusters using Steampipe.

![image](https://raw.githubusercontent.com/turbot/steampipe-mod-kubernetes-compliance/main/docs/kubernetes-compliance-mod-console.png)

Includes support for:

- [v1.0 NSA and CISA Cybersecurity Technical Report](https://media.defense.gov/2021/Aug/03/2002820425/-1/-1/1/CTR_KUBERNETES%20HARDENING%20GUIDANCE.PDF)

## Quick start

1. Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```shell
brew tap turbot/tap
brew install steampipe

steampipe -v
steampipe version 0.8.2
```

2. Install the Kubernetes plugin

```shell
steampipe plugin install kubernetes
```

3. Clone this repo

```sh
git clone https://github.com/turbot/steampipe-mod-kubernetes-compliance.git
cd steampipe-mod-kubernetes-compliance
```

4. Run all benchmarks:

```shell
steampipe check all
```

### Other things to checkout

Run an individual benchmark:

```shell
steampipe check benchmark.nsa_cisa_v1_network_hardening_cpu_limit
```

Use Steampipe introspection to view all current controls:

```
steampipe query "select resource_name from steampipe_control;"
```

Run a specific control:

```shell
steampipe check control.daemonset_cpu_limit
```

## Contributing

If you have an idea for additional compliance controls, or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing. (Even if you just want to help with the docs.)

- **[Join our Slack community →](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g)** and hang out with other Mod developers.
- **[Mod developer guide →](https://steampipe.io/docs/using-steampipe/writing-controls)**

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-kubernetes-compliance/blob/main/LICENSE).

`help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [Kubernetes Compliance Mod](https://github.com/turbot/steampipe-mod-kubernetes-compliance/labels/help%20wanted)
