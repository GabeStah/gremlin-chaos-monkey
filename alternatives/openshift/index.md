---
title: "Chaos Monkey Alternatives - OpenShift"
description: "Explores Chaos Monkey alternative technologies using OpenShift."
date: 2018-08-30
path: "/chaos-monkey/alternatives/openshift"
url: "https://www.gremlin.com/chaos-monkey/alternatives/openshift"
sources: "See: _docs/resources.md"
published: true
outline: "
- URL: `https://www.gremlin.com/chaos-monkey/alternatives/openshift`
- Parent: `Category Section: Infrastructure`
- Content:
  - `Overview`: _See above._
  - [`monkey-ops`](https://github.com/Produban/monkey-ops): Describe how the `monkey-ops` service can be used to perform Chaos Engineering tasks inside an [`OpenShift`](https://www.openshift.com/) container application.
- Competition:
  - https://github.com/Produban/monkey-ops
- Services (for Gremlin?):
  - https://docs.openshift.com/online/dev_guide/integrating_external_services.html
  - https://docs.openshift.com/online/architecture/core_concepts/pods_and_services.html#services
"
---

## Engineering Chaos In OpenShift with Gremlin

Gremlin's [Failure as a Service][#gremlin-failure-as-a-service] simplifies your Chaos Engineering workflow for OpenShift by making it safe and effortless to execute Chaos Experiments across all application containers.  As a distributed architecture OpenShift is particularly sensitive to instability and unexpected failures, and containers are becoming first-class citizens for many organizations.  Gremlin can perform a variety of attacks on your OpenShift nodes, including overloading CPU, memory, disk, and IO; killing pods; modifying network traffic; and much more.

Check out [this tutorial](https://help.gremlin.com/install-gremlin-centos-7/) to get started!

{% include nav-internal.md %}