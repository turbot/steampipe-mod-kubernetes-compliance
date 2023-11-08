To get the latest version of the official guide, please visit [here](https://media.defense.gov/2022/Aug/29/2003066362/-1/-1/0/CTR_KUBERNETES_HARDENING_GUIDANCE_1.2_20220829.PDF).

## Overview

Kubernetes is an open-source system that automates the deployment, scaling, and management of applications run in containers, and is often hosted in a cloud environment. The hardening guidance detailed in this report is designed to help organizations handle associated risks and enjoy the benefits of using this technology.

## Control Categories

These are the available categories for Kubernetes Compliance controls. The category for a control reflects the security function that the control applies to.

### Kubernetes Pod Security

A Pod Security Policy is a cluster-level resource that controls security sensitive aspects of the pod specification. The PodSecurityPolicy objects define a set of conditions that a pod must run with in order to be accepted into the system, as well as defaults for the related fields.

### Network Separation and Hardening

Cluster networking is a central concept of Kubernetes. Communication between containers, Pods, services, and external services must be taken into consideration. By default, there are few network policies in place to separate resources and prevent lateral movement or escalation if a cluster is compromised. Resource separation and encryption can be an effective way to limit a cyber actor’s movement and escalation within a cluster.
