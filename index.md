---
title: "Chaos Monkey Guide for Engineers - Tips, Tutorials, and Training"
description: "A summary of the full Chaos Monkey Guide for Engineers."
path: "/chaos-monkey"
url: "https://www.gremlin.com/chaos-monkey"
published: true
sources: "See: _docs/resources.md"
---

In August 2008, Netflix's then DVD-focused business suffered a [catastrophic database failure](https://media.netflix.com/en/company-blog/completing-the-netflix-cloud-migration) that halted DVD rental shipments to customers for three full days.  Behind the scenes, Netflix engineers quickly began work on an internal tool designed to help prevent such failures, and in 2010 [Netflix](https://www.netflix.com) announced the existence and success of their own [resiliency tool](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c) called *Chaos Monkey*.

Chaos Monkey served served a specific role -- to test system stability by enforcing failures via the pseudo-random termination of instances and services within Netflix's architecture.  Since Netflix's service was reliant upon Amazon Web Services (AWS), Netflix needed a technology that could force their hand by deliberately taking down critical components of their service infrastructure *within* the production environment.  The Netflix team was banking on the notion that their ability to handle this single, common type of failure without negatively impacting the customer experience would suss out any weaknesses in their systems and guide them towards automated solutions that could gracefully handle future failures.  Given Netflix's growing success, popularity, and stability over the last half decade, it appears they succeeded.

Chaos Monkey also jump-started the [*Chaos Engineering* revolution](https://www.gremlin.com/community/tutorials/chaos-engineering-the-history-principles-and-practice/).  [Chaos Engineering](https://principlesofchaos.org/) is "the discipline of experimenting on a distributed system in order to build confidence in the system’s capability to withstand turbulent conditions in production."  By proactively testing how a system responds under stress, you can identify and fix failures before they become disastrous.  Chaos Engineering lets you compare what you *think* will happen with what is *actually* happening in your systems.  By performing the smallest possible experiments you can measure, you're able to "break things on purpose" in order to learn how to build more resilient systems.  

The following year, in 2011, [Netflix announced](https://medium.com/netflix-techblog/the-netflix-simian-army-16e57fbab116) the evolution of Chaos Monkey with a series of additional tools known as [_The Simian Army_][/simian-army].  Inspired by the success of their original Chaos Monkey tool aimed at randomly disabling production instances and services, the engineering team developed additional "simians" built to cause other types of failure and induce abnormal system conditions.  For example, the *Latency Monkey* tool introduces artificial delays in RESTful client-server communication, allowing the team at Netflix to simulate service unavailability without actually taking down said service.  We'll dive into all the details -- including a close look at every member of that fearsome, technological fighting squad -- in [The Simian Army][/simian-army] chapter of this guide.

With a stable codebase and ample real-world testing in their pockets, Netflix engineers publicly released the Chaos Monkey [source code on GitHub](https://github.com/Netflix/chaosmonkey) a few months later in 2012, and the world of Chaos Engineering was unleashed upon the world!

## What Is This Guide?

The [*Chaos Monkey Guide for Engineers*][/] provides a curated and exhaustive examination of Chaos Monkey, including what it is, its [origin story][/origin-netflix], its [pros](#pros-of-chaos-monkey) and [cons](#cons-of-chaos-monkey), its relation to the broader topic of Chaos Engineering, and much more.  We've also included [step-by-step technical tutorials][/developer-tutorial] for getting started with Chaos Monkey, along with [advanced engineering tips and guides][/advanced-tips] for those looking to go beyond the basics.  [The Simian Army][/simian-army] explores all the additional tools created after Chaos Monkey.

This guide also provides a plethora of useful [resources, tutorials, and downloads][/downloads-resources] for engineers seeking to improve their own Chaos Engineering practices.  In fact, our [alternative technologies][/alternatives] chapter goes above and beyond by examining a curated list of the best alternatives to Chaos Monkey -- we dig into everything from [Azure][/alternatives/azure] and [Docker][/alternatives/docker] to [Kubernetes][/alternatives/kubernetes] and [VMWare][/alternatives/vmware]!

## Who Is This Guide For?

We've created this guide primarily for engineers and other enterprise technologists who are looking for the ultimate resource on Chaos Monkey.  We want to help readers see how Chaos Monkey fits into the whole realm of Chaos Engineering practices while illustrating what Chaos Monkey can and cannot do.  By providing the best practices and resources for Monkey-ing your own Chaos, and supplying a well-researched list of alternative technologies and techniques, you'll learn what Chaos Engineering techniques and tools are best suited to your organization and the specific needs of your projects.

## Why Did We Create This Guide?

Our goal here at Gremlin is to empower engineering teams to build more resilient systems through thoughtful Chaos Engineering.  We're on a constant quest to promote the [Chaos Community](https://www.gremlin.com/community/) through frequent [conferences & meetups](https://meetup.com/pro/chaos), in-depth [talks](https://www.gremlin.com/community/#talks), detailed [tutorials](https://www.gremlin.com/community/tutorials/), and the ever-growing list of [Chaos Engineering Slack channels](https://www.gremlin.com/slack).

While Chaos Engineering extends well beyond the scope of one single technique or idea, we here at Gremlin feel it's critical for you to understand the full breadth of what Chaos Monkey is (and is not) capable of.  After reading this guide you'll have all the information you need to make informed and educated decisions about what Chaos Engineering technologies, techniques, and tests are best for you and your team.

## When and Where Should This Guide Be Used?

When and where should this guide be used?  Frankly, we leave that up to you!  We've streamlined every chapter of this guide, so you'll have quick access to all of the information within.  Whether reading this in the office, at home on your laptop, or even late night in bed via our [downloadable PDF version][/pdf-download], you'll have total access to every ounce of that sweet, tangy nectar we could squeeze into this thing.  Mmm, tasty!

## The Pros and Cons of Chaos Monkey

Considering Chaos Monkey was publicly released in 2012, it's still a relatively new technology compared to many other technologies regularly used today (Unix, anyone?).  This means that [Chaos Monkey][/origin-netflix], the [Simian Army][/simian-army], and many related [technologies][/alternatives] have **all** begun burgeoning quite recently.  As such, there is still quite a lot of misinformation, or mere lacks of understanding, surrounding Chaos Monkey's capabilities.

### Pros of Chaos Monkey

- **Planned Failure**: Chaos Monkey allows for planned instance failures when you and your team are best-prepared to handle them.  You can [schedule terminations][#chaos-monkey-schedule-terminations] so they occur based on a configurable *mean* number of days and during a given *time period* each day.
- **Encourages Distribution**: As [Netflix learned][#netflix-history] all too well in 2008 prior to developing Chaos Monkey, a vertically-stacked architecture is dangerous and prone to single points of failure.  Conversely, a distributed architecture that Chaos Engineering practices and tools like Chaos Monkey encourage is inherently more resilient, so long as you proactively "break things on purpose" in an effort to learn.
- **Encourages Redundancy**: Part and parcel of a distributed architecture, redundancy is another major benefit to smart Chaos Engineering practices.  If a single service or instance is brought down unexpectedly, a redundant backup may save the day.
- **Discourages Wasteful Dependencies**: Chaos Engineering best practices emphasize the importance of separating the wheat from the chaff by eliminating all unnecessary dependencies and allowing the system to remain functional with the absolute minimal components and services.
- **Discovering Improvements**: Performing Chaos Experiments can often shed light on previously unknown improvements and workarounds.  ("Turns out, even with our core XYZ service offline, we're still going.  Awesome!")
- **Built Into Spinnaker**: If your architecture already relies on Spinnaker, getting Chaos Monkey up and running is a breeze.

### Cons of Chaos Monkey

- **Requires Spinnaker**: As discussed in [The Origin of Chaos Monkey][#spinnaker-strictly], Chaos Monkey **does not** support deployments that are managed by anything other than Spinnaker.
- **Limited Failure Mode**: Chaos Monkey's limited scope means it merely performs one, and only one, simple task -- causing pseudo-random instance failure.  Smart Chaos Engineering is about looking at an application's future, toward unknowable and unpredictable failures.  Chaos Monkey only handles a tiny subset of the "long tail" failures that software will experience during its life cycle.  Check out the [Chaos Monkey Alternatives][/alternatives] chapter for more information.
- **Lack of Coordination**: While Chaos Monkey can terminate instances and cause failures, it lacks much semblance of coordination.  Since Chaos Monkey is an open-source tool that was built by and for Netflix, it's left to you as the end-user to inject your own system-specific logic.  Bringing down an instance is great and all, but knowing how to coordinate and act on that information is critical.

    ![now-what](images/now-what.gif 'Finding Nemo - Now What?')

- **No Recovery Capabilities**: A big reason why Chaos Engineering encourages performing the smallest possible experiments is so any repercussions are somewhat contained.  Unlike some other [tools and services][/alternatives], Chaos Monkey doesn't provide any safety net features.  If something goes wrong, it's entirely up to you and your team to recognize and resolve it.
- **No User Interface**: Chaos Monkey is entirely executed through the command line, scripts, and configuration files.  Being able to execute Chaos Experiments in a user-friendly interface opens the doors to more people contributing to the resilience of your system.
- **Limited Auditing Tools**: By itself, Chaos Monkey doesn't provide much auditing information.  Spinnaker supports a framework for creating your own Chaos Monkey auditing through its [Echo](https://github.com/spinnaker/echo) events microservice, but you'll generally be required to create your own [custom auditing tools](https://netflix.github.io/chaosmonkey/Tracker/) to get much info out of Chaos Monkey.

## Guide Chapters

### The Origin of Chaos Monkey - Why Netflix Needed to Create Failure

In our [The Origin of Chaos Monkey][/origin-netflix] chapter we examine why Chaos Monkey became the most prolific and well-known technology in Chaos Engineering.  We also dive further into why Netflix created Chaos Monkey after their dramatic database failure in mid-2008 forced them to devise a solution for random service failure.  We also explore the [future of Chaos Monkey][#chaos-monkey-today], Chaos Monkey's [reliance on Spinnaker][#spinnaker-strictly], and the introduction of [Netflix's Failure Injection Testing][#netflix-fit].

### Chaos Monkey Tutorial - A Step-by-Step Guide to Creating Failure on AWS

In the [Chaos Monkey Developer Tutorial][/developer-tutorial] we provide in-depth, step-by-step technical guides for [getting Chaos Monkey up and running][#chaos-monkey-install] on AWS.  We also explore a handful of scenarios in which Chaos Monkey may, or may not, be the most relevant solution for dealing with long tail failures that proper Chaos Engineering discipline encourages.

### Taking Chaos Monkey to the Next Level - Advanced Developer Guide

Our [Advanced Developer Guide][/advanced-tips] gets into the nitty-gritty of using Chaos Monkey with walkthroughs for manually deploying Spinnaker stacks [locally][#spinnaker-manual], on a [virtual machine][#spinnaker-manual], or [with Kubernetes][#spinnaker-stack-with-kubernetes].  From there, we've also included instructions for [deploying Spinnaker][#spinnaker-install] itself, so you can begin your Chaos Experiments.

### The Simian Army - Overview and Resources

**(TODO)**

### Chaos Monkey Resources, Guides, and Downloads for Engineers

**(TODO)**

### Chaos Monkey Alternatives - Tools for Creating Chaos Outside of AWS

**(TODO)**

{% include nav-internal.md %}