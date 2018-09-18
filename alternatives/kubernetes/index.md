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

## Kube Monkey

[Kube-monkey](https://github.com/asobti/kube-monkey) is an open-source implementation of Chaos Monkey for use on Kubernetes clusters and written in Go.  Like the original Chaos Monkey, Kube-monkey performs just one task: randomly deletes Kubernetes pods within the cluster, as a means of injecting failure in the system and testing the stability of the remaining pods.  It is based on pseudo-random rules, running at a pre-defined hour on weekdays to then build a schedule of random pod targets that will be attacked and killed at a random time during that same day, though the time-range is configurable.

Kube-monkey will only terminate pods that have explicitly opted in by specifying certain Kube-monkey `metadata labels`.  The following illustrates the basic labels that can be specified to allow Kube-monkey to kill pods within this application.

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: monkey-victim
  namespace: app-namespace
  labels:
    kube-monkey/enabled: enabled
    kube-monkey/identifier: monkey-victim
    kube-monkey/mtbf: '2'
    kube-monkey/kill-mode: "fixed"
    kube-monkey/kill-value: 1
spec:
  template:
    metadata:
      labels:
        kube-monkey/enabled: enabled
        kube-monkey/identifier: monkey-victim
# ...
```

Check out the [GitHub repository](https://github.com/asobti/kube-monkey) for more information on installing and using Kube-monkey.

## Engineering Chaos In Kubernetes with Gremlin

Gremlin's [Failure as a Service][#gremlin-failure-as-a-service] simplifies your Chaos Engineering workflow for Kubernetes by making it safe and effortless to execute Chaos Experiments across all nodes.  As a distributed architecture Kubernetes is particularly sensitive to instability and unexpected failures.  Gremlin can perform a variety of attacks on your Kubernetes clusters, including overloading CPU, memory, disk, and IO; killing nodes; modifying network traffic; and much more.

Check out [this tutorial](https://www.gremlin.com/community/tutorials/how-to-install-and-use-gremlin-with-kubernetes/) over on our [community site](https://www.gremlin.com/community/) to get started!

## Kubernetes Pod Chaos Monkey

[Kubernetes Pod Chaos Monkey](https://github.com/jnewland/kubernetes-pod-chaos-monkey) is yet another Chaos Monkey-style tool for Kubernetes.  The code itself is just a local shell script that issues [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) command-line commands to occasionally retrieve and then delete Kubernetes pods.  It targets a cluster based on the configurable `NAMESPACE` and attempts to destroy a node every `DELAY` seconds (defaulting to 30).

While not the most elegant tool, as little more than a shell script [Kubernetes Pod Chaos Monkey](https://github.com/jnewland/kubernetes-pod-chaos-monkey) can be modified quite easily.

## The Chaos Toolkit

The [Chaos Toolkit](https://chaostoolkit.org/) is an open-source and extensible tool that is written in Python.  It uses platform-based drivers to connect to your Kubernetes cluster and to execute Chaos Experiments.  Every experiment performed by Chaos Toolkit is written in JSON using a [robust API](https://docs.chaostoolkit.org/reference/api/experiment/).  Every experiment is made up of a few key elements, which are executed sequentially and allow the experiment to bail out if any step in the process fails.

- **Steady State Hypothesis**: This element defines the normal or "steady" state of the system before the **Method** element is applied.  For our example we've defined a basic application with a steady state hypothesis titled "Service should have nodes."

    ```json
    {
      "version": "1.0.0",
      "title": "Gremlin EKS App",
      "description": "Gremlin EKS App",
      "tags": [
          "service",
          "kubernetes"
      ],
      "steady-state-hypothesis": {
          "title": "Service should have nodes.",
          "probes": [
              {
                  "type": "probe",
                  "name": "nodes_found",
                  "tolerance": true,
                  "provider": {
                      "type": "python",
                      "module": "chaosk8s.node.probes",
                      "func": "get_nodes",
                      "arguments": {
                          "label_selector": "eks-gremlin-chaos"
                      }
                  }
              }
          ]
      },
    }
    ```
- **Probe**: A Probe is an element that collects system information, such as checking the health status of a node.  Here we define a Probe element, which we've added to our steady state Probes list above, that calls the [`get_nodes`](https://github.com/chaostoolkit/chaostoolkit-kubernetes/blob/master/chaosk8s/node/probes.py#L12) function and retrieves the list of nodes for the specified `label-selector`.

    ```json
    {
        "type": "probe",
        "name": "nodes_found",
        "tolerance": true,
        "provider": {
            "type": "python",
            "module": "chaosk8s.node.probes",
            "func": "get_nodes",
            "arguments": {
                "label_selector": "eks-gremlin-chaos"
            }
        }
    }
    ```

- **Action**: An Action element performs an operation against the system, such as draining or deleting a node.  In the example we call the [`delete_nodes`](https://github.com/chaostoolkit/chaostoolkit-kubernetes/blob/master/chaosk8s/node/actions.py#L22) function, passing the required `label-selector` argument, and setting `all` to `true` so we delete all nodes in the cluster.

    ```json
    {
        "type": "action",
        "name": "delete_all_nodes",
        "provider": {
            "type": "python",
            "module": "chaosk8s.node.actions",
            "func": "delete_nodes",
            "arguments": {
                "all": true,
                "label-selector": "eks-gremlin-chaos"
            }
        }
    }
    ```

- **Method**: A Method element defines the series of Probe and Action elements that make up the experiment.  Here we're first using the `nodes_found` Probe to make sure nodes exist, executing the `delete_all_nodes` Action to delete all nodes in the cluster, then performing another explicit Probe to verify that no nodes remain.

    ```json
    "method": [
        {
            "ref": "nodes_found"
        },
        {
            "type": "action",
            "name": "delete_all_nodes",
            "provider": {
                "type": "python",
                "module": "chaosk8s.node.actions",
                "func": "delete_nodes",
                "arguments": {
                    "all": true,
                    "label-selector": "eks-gremlin-chaos"
                }
            }
        },
        {
            "type": "probe",
            "name": "nodes_not_found",
            "tolerance": false,
            "provider": {
                "type": "python",
                "module": "chaosk8s.node.probes",
                "func": "get_nodes",
                "arguments": {
                    "label_selector": "eks-gremlin-chaos"
                }
            }
        }
    ]
    ```

That's just the basics to getting started with experimenting using the Chaos Toolkit.  Chaos Toolkit also has a fault injection [plugin for Gremlin](https://github.com/chaostoolkit-incubator/chaostoolkit-gremlin) so you can easily perform attacks while utilizing the safety and security of the Gremlin platform.

{% include nav-internal.md %}