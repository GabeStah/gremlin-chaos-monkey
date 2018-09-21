---
title: "Chaos Monkey Alternatives - VMware"
description: "Explores Chaos Monkey alternative technologies on VMware."
date: 2018-08-30
path: "/chaos-monkey/alternatives/vmware"
url: "https://www.gremlin.com/chaos-monkey/alternatives/vmware"
sources: "See: _docs/resources.md"
published: true
---

## Chaos Engineering with BOSH and Chaos Lemur

CloudFoundry's [BOSH](http://bosh.cloudfoundry.org/docs/) unifies CI/CD practices for virtualized, distributed systems like VMware vSphere and the open-source [Chaos Lemur](https://github.com/strepsirrhini-army/chaos-lemur) tool makes it relatively easy to inject failure into BOSH systems.  Chaos Lemur is a self-contained Java application that will randomly destroy virtual machines in any BOSH-managed environment.  Similar to the original Chaos Monkey, Chaos Lemur can be configured to execute on a daily schedule and target one or more VMs for destruction based on pseudo-random probabilities.  It can also be integrated with [Datadog](https://www.datadoghq.com/) to log destruction events.

Chaos Lemur is a standalone Java 8 application that requires Maven for building and deployment, but otherwise, it can be hosted anywhere.  Configuration is handled using local environment variables.

| Variable              | Description                                                                                      | Type    | Default                              |
| --------------------- | ------------------------------------------------------------------------------------------------ | ------- | ------------------------------------ |
| `DEFAULT_PROBABILITY` | Per-run probability a VM will be destroyed (0.0 to 1.0).                                         | Float   | `0.2`                                |
| `DRYRUN`              | When enabled, Chaos Lemur will perform every step of the process *except* actual VM destruction. | Boolean | `FALSE`                              |
| `SCHEDULE`            | The schedule using Spring cron syntax that indicates when to execute Chaos Lemur.                | String  | `0 0 * * * *`                        |
| `BLACKLIST`           | A comma-separated list indicating the Deployments or Jobs that *are not* eligible for deletion.  | String  | `""` (All deployments/jobs eligible) |
| `WHITELIST`           | A comma-separated list indicating the Deployments or Jobs that *are* eligible for deletion.      | String  | `""`(All deployments/jobs eligible)  |

Chaos Lemur also requires an infrastructure on which to perform attacks.  This requires specifying credential environment variables for your application infrastructure.  The full list of supported infrastructures and their respective variables can be [found here](https://github.com/strepsirrhini-army/chaos-lemur#infrastructure), but below you'll find the necessary settings for vSphere.

| Variable           | Description                           |
| ------------------ | ------------------------------------- |
| `VSPHERE_HOST`     | The vSphere host used to destroy VMs. |
| `VSPHERE_USERNAME` | Username for `VSPHERE_HOST` access.   |
| `VSPHERE_PASSWORD` | Password for `VSPHERE_HOST` access.   |

The final (optional) component for using Chaos Lemur is Redis.  If configured, Chaos Lemur will use Redis to store persistence state information.

Check out the [official repository](https://github.com/strepsirrhini-army/chaos-lemur) and [this blog post](https://content.pivotal.io/blog/chaos-lemur-testing-high-availability-on-pivotal-cloud-foundry) for more information on getting Chaos Lemur up and running within your BOSH-managed environment.

## Chaos Engineering on VMware with Gremlin

Gremlin's [Failure as a Service][#gremlin-failure-as-a-service] finds and helps you fix weaknesses in your VMware architecture before they cause problems.  Gremlin makes Chaos Engineering simple, safe, and secure, improving your system's stability and resilience against unexpected failures.  You can start running Chaos Experiments on your VMware application in just a few minutes by [signing up][#gremlin-account-signup] for an account and [installing Gremlin][#gremlin-installation].  Gremlin can perform a wide range of attacks against your infrastructure including modifying network traffic; killing off virtual machines; overloading CPU, memory, disk, and IO; and much more.

Check out [these tutorials][#gremlin-installation] to learn how to install Gremlin and start injecting failure into your VMware system today.

{% include nav-internal.md %}