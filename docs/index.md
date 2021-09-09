---
repository: "https://github.com/turbot/steampipe-mod-kubernetes-compliance.git"
---

# Kubernetes Compliance Mod

Run individual configuration, compliance and security controls or full compliance benchmarks for Kubernetes across all providers.

## References

[Kubernetes](https://kubernetes.io/) also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications.

[NSA & CISA Cybersecurity Technical Report](https://media.defense.gov/2021/Aug/03/2002820425/-1/-1/1/CTR_KUBERNETES%20HARDENING%20GUIDANCE.PDF) describes the complexities of securely managing Kubernetes an open-source, container-orchestration system used to automate deploying, scaling, and managing containerized applications.

[Steampipe](https://steampipe.io) is an open source CLI to instantly query cloud APIs using SQL.

[Steampipe Mods](https://steampipe.io/docs/reference/mod-resources#mod) are collections of `named queries`, and codified `controls` that can be used to test current configuration of your cloud resources against a desired configuration.

## Documentation

- **[Benchmarks and controls →](https://hub.steampipe.io/mods/turbot/kubernetes-compliance/controls)**
- **[Named queries →](https://hub.steampipe.io/mods/turbot/kubernetes-compliance/queries)**

## Get started

Install the Kubernetes plugin with [Steampipe](https://steampipe.io):

```shell
steampipe plugin install kubernetes
```

Clone:

```sh
git clone https://github.com/turbot/steampipe-mod-kubernetes-compliance.git
cd steampipe-kubernetes-compliance
```

Run all benchmarks:

```shell
steampipe check all
```

Run a single benchmark:

```shell
steampipe check benchmark.nsa_cisa_kubernetes_hardening_v10
```

Run a specific control:

```shell
steampipe check control.k8s_non_root_container
```

### Credentials

This mod uses the credentials configured in the [Steampipe Kubernetes plugin](https://hub.steampipe.io/plugins/turbot/kubernetes).

### Configuration

No extra configuration is required.

## Get involved

- Contribute: [GitHub Repo](https://github.com/turbot/steampipe-mod-kubernetes-compliance)
- Community: [Slack Channel](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g)
