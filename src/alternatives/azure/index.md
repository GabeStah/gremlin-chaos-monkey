---
title: "Chaos Monkey Alternatives - Azure"
description: "Explores Chaos Monkey alternative technologies using Azure."
path: "/chaos-monkey/alternatives/azure"
url: "https://www.gremlin.com/chaos-monkey/alternatives/azure"
sources: "See: _docs/resources.md"
published: true
---

## Search Chaos Monkey

Inspired by Chaos Monkey, the [Azure Search](https://azure.microsoft.com/en-us/services/search/) team [developed](https://azure.microsoft.com/en-gb/blog/inside-azure-search-chaos-engineering/) an alternative tool they call **Search Chaos Monkey**.  Search Chaos Monkey is initially used to attack a test environment that contains a randomly and continuously changing search service.  Test environment experiments allow the team to catch bugs before they reach production.

Once it's in production, Search Chaos Monkey's destructive power is managed through its configurable *chaos level*.

- **Low chaos** failures are recovered from gracefully with little to no interruption in service.  Alerts raised in **low** mode are considered bugs.
- **Medium chaos** failures are also gracefully recovered from, but they may degrade service performance or stability.  Low-priority alerts are sent along to engineers on call.
- **High chaos** failures are those that definitively interrupt service and trigger high-priority alerts for on-call engineers.

These levels offer a modicum of control over experiments, but not much in the way of granularity.  The Azure Search team also designates an **extreme chaos** level to any failure that incurs data loss, causes ungraceful degradation, or fails silently.  To maintain experimental control, Search Chaos Monkey is not permitted to induce **extreme** failures on a continuous basis.

## Causing Chaos on Azure with Gremlin

Performing Chaos Experiments on your Azure applications is simple, safe, and secure using Gremlin's [Failure as a Service][#gremlin-failure-as-a-service].  Azure's distributed computing architecture all but requires proper failure injection testing with tools like Gremlin, which can execute a variety of attacks including straining CPU, memory, disk, and IO; terminating instances; altering instance system time; manipulating network traffic; and more.

Check out the [official documentation](https://help.gremlin.com/install-gremlin-azure/) or look through our in-depth [community site](https://www.gremlin.com/community/tutorials/how-to-install-and-use-gremlin-on-microsoft-azure/) for more information.

## WazMonkey

[WazMonkey](https://github.com/smarx/WazMonkey) is an open-source tool that selects a random Azure role instance and reboots it.  Written in C# and executed on the command-line, WazMonkey is simple and straightforward to use.

```bash
Usage: WazMonkey -p foo.publishSettings -n myservice -s production

  -p, --publishSettings    .publishSettings file - specify either this or a .pfx file

  --pfx                    .pfx certificate file - specify either this or a .publishSettings file

  --subscriptionId         subscriptionId to use, defaults to first subscription found in the .publishSettings file

  -n, --serviceName        Required. Name of the cloud service

  -s, --slot               Required. The slot ("production" or "staging")

  --reimage                Reimage the instance (instead of reboot, the default)

  --help                   Display this help screen.
```

## Fault Analysis Service

Azure's [Fault Analysis Service](https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-testability-overview) is a service that injects failure and runs test scenarios against applications built on [Microsoft Azure Service Fabric](https://azure.microsoft.com/en-us/services/service-fabric/).  The Fault Analysis Service executes **actions**, which are individual faults that target a system.  Developers can combine multiple actions to perform complex tasks and Chaos Experiments, such as:

- Restarting nodes
- Simulating load balancing or application upgrades
- Inducing data or memory loss
- Removing or restarting a replica

Developers can [induce](https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-controlled-chaos) controlled Chaos to simulate both graceful and ungraceful faults within Service Fabric clusters.  An ungraceful fault is anything that terminates a process, such as restarting a node or application.

During execution, Fault Analysis Service frequently snapshots the current "run state" and adds them to named `Event` types.  Event types like `ExecutingFaultsEvent` and `ValidationFailedEvent` can then be retrieved via the [API](https://docs.microsoft.com/en-us/rest/api/servicefabric/).

{% include nav-internal.md %}