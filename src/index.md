---
title: "Chaos Monkey Guide for Engineers - Tips, Tutorials, and Training"
description: "A summary of the full Chaos Monkey Guide for Engineers."
path: "/chaos-monkey"
url: "https://www.gremlin.com/chaos-monkey"
published: true
sources: "See: _docs/resources.md"
---

In 2010 [Netflix](https://www.netflix.com) announced the existence and success of their custom [resiliency tool](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c) called *Chaos Monkey*.

## What Is Chaos Monkey?

Netflix designed Chaos Monkey to test system stability by enforcing failures via the pseudo-random termination of instances and services within Netflix's architecture. Following their migration to the cloud,  Netflix's service was newly reliant upon Amazon Web Services and needed a technology that could show them how their system responded when critical components of their production service infrastructure were taken down.  Intentionally causing this single failure would suss out any weaknesses in their systems and guide them towards automated solutions that gracefully handle future failures of this sort.

Chaos Monkey helped jumpstart [**Chaos Engineering** as a new engineering practice](https://www.gremlin.com/community/tutorials/chaos-engineering-the-history-principles-and-practice/).  Chaos Engineering is "the discipline of experimenting on a distributed system in order to build confidence in the system's capability to withstand turbulent conditions in production."  By proactively testing how a system responds under stress, you can identify and fix failures before they become public facing outages. Chaos Engineering lets you compare what you think will happen with what is actually happening in your systems.  By performing the smallest possible experiments you can measure, you're able to "break things on purpose" in order to learn how to build more resilient systems.

In 2011, [Netflix announced](https://medium.com/netflix-techblog/the-netflix-simian-army-16e57fbab116) the evolution of Chaos Monkey with a series of additional tools known as [_The Simian Army_][/simian-army].  Inspired by the success of their original Chaos Monkey tool aimed at randomly disabling production instances and services, the engineering team developed additional "simians" built to cause other types of failure and induce abnormal system conditions.  For example, the *Latency Monkey* tool introduces artificial delays in RESTful client-server communication, allowing the team at Netflix to simulate service unavailability without actually taking down said service.  This guide will cover all the details of these tools in [The Simian Army][/simian-army] chapter.

## What Is This Guide?

The [*Chaos Monkey Guide for Engineers*][/] is a full how-to of Chaos Monkey, including what it is, its [origin story][/origin-netflix], its [pros](#pros-of-chaos-monkey) and [cons](#cons-of-chaos-monkey), its relation to the broader topic of Chaos Engineering, and much more.  We've also included [step-by-step technical tutorials][/developer-tutorial] for getting started with Chaos Monkey, along with [advanced engineering tips and guides][/advanced-tips] for those looking to go beyond the basics.  [The Simian Army][/simian-army] section explores all the additional tools created after Chaos Monkey.

This guide also includes [resources, tutorials, and downloads][/downloads-resources] for engineers seeking to improve their own Chaos Engineering practices.  In fact, our [alternative technologies][/alternatives] chapter goes above and beyond by examining a curated list of the best alternatives to Chaos Monkey -- we dig into everything from [Azure][/alternatives/azure] and [Docker][/alternatives/docker] to [Kubernetes][/alternatives/kubernetes] and [VMware][/alternatives/vmware]!

## Who Is This Guide For?

We've created this guide primarily for engineers and other enterprise technologists who are looking for the ultimate resource on Chaos Monkey, as a way to get started with Chaos Engineering.  We want to help readers see how Chaos Monkey fits into the whole realm of Chaos Engineering practices.

## Why Did We Create This Guide?

Our goal here at Gremlin is to empower engineering teams to build more resilient systems through thoughtful Chaos Engineering.  We're on a constant quest to promote the [Chaos Community](https://www.gremlin.com/community/) through frequent [conferences & meetups](https://meetup.com/pro/chaos), in-depth [talks](https://www.gremlin.com/community/#talks), detailed [tutorials](https://www.gremlin.com/community/tutorials/), and the ever-growing list of [Chaos Engineering Slack channels](https://www.gremlin.com/slack).

While Chaos Engineering extends well beyond the scope of one single technique or idea, Chaos Monkey is the most well-known tool for running Chaos Experiments and is a common starting place for engineers getting started with the discipline.

## The Pros and Cons of Chaos Monkey

Chaos Monkey is designed to induce one specific type of failure.  It randomly shuts down instances in order to simulate random infrastructure failure.

### Pros of Chaos Monkey

- **Prepares You for Random Failures**: Chaos Monkey allows for planned instance failures when you and your team are best-prepared to handle them.  You can [schedule terminations][#chaos-monkey-schedule-terminations] so they occur based on a configurable *mean* number of days and during a given *time period* each day.
- **Encourages Distribution**: As [Netflix learned][#netflix-history] all too well in 2008 prior to developing Chaos Monkey, a vertically-stacked architecture is dangerous and prone to single points of failure.  Conversely, a distributed architecture that Chaos Engineering practices and tools like Chaos Monkey encourage is inherently more resilient, so long as you proactively "break things on purpose" in an effort to learn.
- **Encourages Redundancy**: Part and parcel of a distributed architecture, redundancy is another major benefit to smart Chaos Engineering practices.  If a single service or instance is brought down unexpectedly, a redundant backup may save the day.
- **Discourages Wasteful Dependencies**: Chaos Engineering best practices emphasize the importance of separating the wheat from the chaff by eliminating all unnecessary dependencies and allowing the system to remain functional with the absolute minimal components and services.
- **Discovering Improvements**: Performing Chaos Experiments can often shed light on previously unknown improvements and workarounds.  ("Turns out, even with our core XYZ service offline, we're still going.  Awesome!")
- **Built Into Spinnaker**: If your architecture already relies on Spinnaker, getting Chaos Monkey up and running is a breeze.

### Cons of Chaos Monkey

- **Requires Spinnaker**: As discussed in [The Origin of Chaos Monkey][#spinnaker-strictly], Chaos Monkey **does not** support deployments that are managed by anything other than Spinnaker.
- **Limited Failure Mode**: Chaos Monkey's limited scope means it injects one type of failure – causing pseudo-random instance failure. Thoughtful Chaos Engineering is about looking at an application's future, toward unknowable and unpredictable failures, beyond those of a single AWS instance. Chaos Monkey only handles a tiny subset of the "long tail" failures that software will experience during its life cycle.  Check out the [Chaos Monkey Alternatives][/alternatives] chapter for more information.
- **Lack of Coordination**: While Chaos Monkey can terminate instances and cause failures, it lacks much semblance of coordination.  Since Chaos Monkey is an open-source tool that was built by and for Netflix, it's left to you as the end-user to inject your own system-specific logic.  Bringing down an instance is great and all, but knowing how to coordinate and act on that information is critical.

    ![now-what](images/now-what.gif 'Finding Nemo - Now What?')

- **No Recovery Capabilities**: A big reason why Chaos Engineering encourages performing the smallest possible experiments is so any repercussions are somewhat contained.  Unlike some other [tools and services][/alternatives], Chaos Monkey doesn't provide any safety net features, such as a Halt All button.  If something goes wrong, it's entirely up to you and your team to recognize and resolve it.
- **No User Interface**: As with most open source projects, Chaos Monkey is entirely executed through the command line, scripts, and configuration files. If your team wants an interface, it's up to you to build it.
- **Limited Auditing Tools**: By itself, Chaos Monkey doesn't provide much auditing information.  Spinnaker supports a framework for creating your own Chaos Monkey auditing through its [Echo](https://github.com/spinnaker/echo) events microservice, but you'll generally be required to create your own [custom auditing tools](https://netflix.github.io/chaosmonkey/Tracker/) to get much info out of Chaos Monkey.

## Guide Chapters

### The Origin of Chaos Monkey - Why Netflix Needed to Create Failure

In [The Origin of Chaos Monkey][/origin-netflix] chapter, we examine why Chaos Monkey became the most prolific and well-known technology in Chaos Engineering.  We also dive further into why Netflix created Chaos Monkey after their dramatic database failure in mid-2008 forced them to devise a solution for random service failure.  We also explore the [future of Chaos Monkey][#chaos-monkey-today], Chaos Monkey's [reliance on Spinnaker][#spinnaker-strictly], and the introduction of [Netflix's Failure Injection Testing][#netflix-fit].

### Chaos Monkey Tutorial - A Step-by-Step Guide to Creating Failure on AWS

In the [Chaos Monkey Developer Tutorial][/developer-tutorial] we provide in-depth, step-by-step technical guides for [getting Chaos Monkey up and running][#chaos-monkey-install] on AWS.  We also explore a handful of scenarios in which Chaos Monkey is the right tool, as well as its limitations.

### Taking Chaos Monkey to the Next Level - Advanced Developer Guide

Our [Advanced Developer Guide][/advanced-tips] gets into the nitty-gritty of using Chaos Monkey with walkthroughs for manually deploying Spinnaker stacks [locally][#spinnaker-manual], on a [virtual machine][#spinnaker-manual], or [with Kubernetes][#spinnaker-stack-with-kubernetes].  From there, we've also included instructions for [deploying Spinnaker][#spinnaker-install] itself, so you can begin your Chaos Experiments.

### The Simian Army - Overview and Resources

In [The Simian Army - Overview and Resources][/simian-army] we explore the origins of Netflix's Simian Army toolset, including what it is, why it was created, the software [tools][#simian-members] that make it up, the [strategies][#simian-chaos-strategies] used to perform various Chaos Experiments, and a [tutorial][#simian-use] to help you install and begin using the Simian Army right away.

### Chaos Monkey Resources, Guides, and Downloads for Engineers

The [Chaos Monkey Resources, Guides, and Downloads for Engineers][/downloads-resources] chapter contains **over 100** researched and highly-curated resources to help you learn about every aspect of Chaos Engineering.  We dive into Chaos Engineering's [origins and principles][/downloads-resources#practices-principles], provide a plethora of [in-depth tutorials][/downloads-resources#tutorials] to get experimenting right away, list a handful of critical Chaos Engineering [blogs][/downloads-resources#blogs], explore the many Chaos Engineering [tools][/downloads-resources#tools] available, and much more.

### Chaos Monkey Alternatives - Tools for Creating Chaos Outside of AWS

In [Chaos Monkey Alternatives - Tools for Creating Chaos Outside of AWS][/alternatives] we have laid out **dozens** of alternative tools and techniques for thoughtfully injecting failure into your own applications, *regardless* of the technology, platform, or architecture you may be using.  You'll find alternative solutions for every major technology including [Azure][/alternatives/azure], [Docker][/alternatives/docker], [Google Cloud Platform][/alternatives/google-cloud-platform], [Kubernetes][/alternatives/kubernetes], [OpenShift][/alternatives/openshift], and many more.

{% include nav-internal.md %}