---
title: "Chaos Monkey Alternatives - Google Cloud Platform"
description: "Explores Chaos Monkey alternative technologies using Google Cloud Platform."
path: "/chaos-monkey/alternatives/google-cloud-platform"
url: "https://www.gremlin.com/chaos-monkey/alternatives/google-cloud-platform"
sources: "See: _docs/resources.md"
published: true
outline: "
  - URL: `https://www.gremlin.com/chaos-monkey/alternatives/google-cloud-platform`
  - Parent: `Category Section: Infrastructure`
  - Content:
    - `Overview`: _See above._
    - [`Engineering Chaos Experiments with TensorFlow`](https://www.gremlin.com/community/tutorials/how-to-install-distributed-tensorflow-on-gcp-and-perform-chaos-engineering-experiments/): Overview of using Gremlin and distributed TensorFlow cluster on `Google Cloud Platform` to perform Chaos experiments.
    - [`Deploying Chaos Monkey on Google Compute Engine`](https://blog.spinnaker.io/running-chaos-monkey-on-spinnaker-google-compute-engine-gce-155dc52f20ef): Tutorial for integrating Chaos Monkey within `Google Compute Engine` using `Spinnaker` and `Golang`.
    - https://github.com/chaostoolkit-incubator/chaostoolkit-google-cloud
- https://blog.spinnaker.io/running-chaos-monkey-on-spinnaker-google-compute-engine-gce-155dc52f20ef
"
---

## Google Cloud Chaos Monkey

[Google Cloud Chaos Monkey](https://github.com/dkholod/GoogleCloudChaosMonkey) is an open-source tool written in F# that performs a few basic Chaos Experiments on Google Cloud instances.  Instance target selection is pseudo-randomized and based on probabilities.

- [Reset](https://github.com/dkholod/GoogleCloudChaosMonkey/blob/master/GoogleCloudChaosMonkey/GoogleCloud.fs#L27-L32): Resets the targeted instance.
- [Stop and Start](https://github.com/dkholod/GoogleCloudChaosMonkey/blob/master/GoogleCloudChaosMonkey/GoogleCloud.fs#L34-L44): Stops the instance and then restarts it after `3` seconds.

## Engineering Chaos Experiments with TensorFlow

It's safe and easy to perform Chaos Experiments on Google Cloud Platform services like TensorFlow with Gremlin's [Failure as a Service][#gremlin-failure-as-a-service].  As a clustered configuration TensorFlow is ideal for running Chaos Experiments to test the fault tolerance and stability of each clustered node.  Gremlin can execute a wide range of attacks on your TensorFlow cluster, including overloading CPU, memory, disk, and IO; killing processes; altering system time; modifying network traffic; and more.

Check out the [full tutorial](https://www.gremlin.com/community/tutorials/how-to-install-distributed-tensorflow-on-gcp-and-perform-chaos-engineering-experiments/#introduction-d4bc1640-1f87-4750-8cda-ed5448a6a120) over on our [community site](https://www.gremlin.com/community/).

## Swapping Kubernetes Nodes in GKE

If you're looking to get into Chaos Engineering with Kubernetes check out our [How to Deploy Spinnaker on Kubernetes][#spinnaker-kubernetes] tutorial to get started with Amazon EKS.  On the other hand, to induce Chaos on Google Cloud Kubernetes Engine clusters you can use the [Chaos Toolkit Google Cloud driver](https://github.com/chaostoolkit-incubator/chaostoolkit-google-cloud).  A relatively simple failure injection involves attacking a node pool with an HTTP load balancing library like [Vegeta](https://github.com/tsenart/vegeta), calling the [`swap_nodepool`](https://docs.chaostoolkit.org/drivers/gce/#swap_nodepool) function to create a new node pool and drain the old pool.  This forces pods to be moved to the new pool.

Check out [this tutorial](https://medium.com/chaosiq/observing-the-impact-of-swapping-nodes-in-gke-with-chaos-engineering-ce5cf9b5fbc6) for more information.

{% include nav-internal.md %}