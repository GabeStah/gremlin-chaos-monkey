---
title: "Chaos Monkey Alternatives - Kubernetes"
description: "Explores Chaos Monkey alternative technologies using Kubernetes."
date: 2018-08-30
path: "/chaos-monkey/alternatives/kubernetes"
url: "https://www.gremlin.com/chaos-monkey/alternatives/kubernetes"
sources: "See: _docs/resources.md"
published: true
outline: "
- URL: `https://www.gremlin.com/chaos-monkey/alternatives/kubernetes`
- Parent: `Category Section: Infrastructure`
- Content:
  - `Overview`: _See above._
  - [`kube-monkey`](https://github.com/asobti/kube-monkey): Detail the `kube-monkey` tool, which is an implementation of Chaos Monkey for Kubernetes clusters.
  - [`Exploring Attack Resiliency via Node Maintenance`](https://medium.com/chaosiq/exploring-multi-level-weaknesses-using-automated-chaos-experiments-aa30f0605ce): Overview of how to use the open source [`Chaos Toolkit`](https://chaostoolkit.org/) to inject Chaos experiments into Kubernetes clusters.
  - [`Database Termination Experiment with Kubernetes and PostgreSQL`](https://medium.com/chaosiq/improve-your-cloud-native-devops-flow-with-chaos-engineering-dc32836c2d9a): Tutorial for how to test the loss of the master database and its impact on the overall application.
  - [`pod-reaper`](https://github.com/target/pod-reaper): A rule-based pod killing container for Kubernetes.
  - [`powerfulseal`](https://github.com/bloomberg/powerfulseal): Adds Chaos experiments to Kubernetes via targeted pod killing and starting/stopping VMs.
- Competition 
  - https://github.com/asobti/kube-monkey
  - https://stackoverflow.com/questions/45020970/chaos-monkey-operability-with-kubernetes
  - https://github.com/bloomberg/powerfulseal
  - https://medium.com/@andrewsrobertamary/chaos-testing-date-with-kube-monkey-dbffd86a6202
"
---

## Engineering Chaos In Kubernetes

Gremlin's [Failure as a Service][#gremlin-failure-as-a-service] simplifies your Chaos Engineering workflow for Kubernetes by making it safe and effortless to execute Chaos Experiments across all nodes.  As a distributed architecture Kubernetes is particularly sensitive to instability and unexpected failures.  Gremlin can perform a variety of attacks on your Kubernetes clusters, including overloading CPU, memory, disk, and IO; killing nodes; modifying network traffic; and much more.

Check out [this tutorial](https://www.gremlin.com/community/tutorials/how-to-install-and-use-gremlin-with-kubernetes/) over on our [community site](https://www.gremlin.com/community/) to get started!

{% include nav-internal.md %}