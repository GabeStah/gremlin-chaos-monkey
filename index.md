---
title: "Chaos Monkey Guide for Engineers - Tips, Tutorials, and Training"
description: "A summary of the full Chaos Monkey Guide for Engineers."
path: "/chaos-monkey"
url: "https://www.gremlin.com/chaos-monkey"
published: true
sources: "See: _docs/resources.md"
---

In August 2008 Netflix's then DVD-focused business suffered a [catastrophic database failure](https://media.netflix.com/en/company-blog/completing-the-netflix-cloud-migration) that halted DVD rental shipments to customers for three full days.  Behind the scenes, Netflix engineers quickly began work on a tool to help prevent such failures, and 2010 [Netflix](https://www.netflix.com) announced the existence and success of their own [resiliency tool](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c) called *Chaos Monkey*.

[Chaos Monkey served](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c) served a specific role -- to test system stability by enforcing failures via the pseudo-random termination of instances and services within Netflix's architecture.  With the Netflix service being directly linked to and reliant upon Amazon Web Services (AWS), Netflix needed a technology that could force their hand by deliberately taking down critical components of their service infrastructure *within* the production environment.  The Netflix team was banking on the notion that their ability to handle this single, common type of failure without negatively impacting the customer experience would suss out any weaknesses in their systems and guide them towards automated solutions that could gracefully handle these failures in the future.  Given Netflix's growing success, popularity, and stability over the last half decade, we can surmise that the engineering team was correct in their assumptions.

Chaos Monkey also jump-started the [*Chaos Engineering* revolution](https://www.gremlin.com/community/tutorials/chaos-engineering-the-history-principles-and-practice/).  [Chaos Engineering](https://principlesofchaos.org/) is "the discipline of experimenting on a distributed system in order to build confidence in the system’s capability to withstand turbulent conditions in production."  By proactively testing how a system responds under stress, you can identify and fix failures before they become disastrous.  Chaos Engineering lets you compare what you *think* will happen with what is *actually* happening in your systems.  By performing the smallest possible experiments you can test, you're able to "break things on purpose" in order to learn how to build more resilient systems.  

The following year, in 2011, [Netflix announced](https://medium.com/netflix-techblog/the-netflix-simian-army-16e57fbab116) the evolution of Chaos Monkey with a series of additional tools known as [_The Simian Army_][/simian-army].  Inspired by the success of their original Chaos Monkey tool aimed at randomly disabling production instances and services, the engineering team developed additional "simians" built to cause other types of failure and induce abnormal system conditions.  For example, the `Latency Monkey` tool introduces artificial delays in RESTful client-server communication, allowing the team at Netflix to simulate service unavailability without actually taking down said service.  We'll dive into all the details of The Simian Army -- including a close look at every member of that fearsome, technological fighting squad -- [The Simian Army - Overview and Resources][/simian-army] section of this guide.

With a stable codebase and ample real-world testing in their pockets, Netflix's engineers publicly released the Chaos Monkey [source code on GitHub](https://github.com/Netflix/chaosmonkey) a few months later in 2012, and the world of Chaos Engineering was unleashed upon the world!

## What Is This Guide?

The [*Chaos Monkey Guide for Engineers*][/] provides a curated and exhaustive examination of Chaos Monkey, including what it is, its [origin story][/origin-netflix], its [pros](#pros-of-chaos-monkey) and [cons](#cons-of-chaos-monkey), its relation to the broader topic of Chaos Engineering, and much more.  We've also included [step-by-step technical tutorials][/developer-tutorial] for getting started with Chaos Monkey, along with [advanced engineering tips and guides][/advanced-tips] for those looking to go beyond the basics.  Speaking of advanced topics, our chapter on [The Simian Army][/simian-army] explores all the additional tools that aim to round out the original Chaos Monkey software.  This guide also provides a plethora of useful [resources, guides, and downloads][/downloads-resources] for engineers seeking to improve their own Chaos Engineering techniques and implementations.  In fact, our [alternative technologies][/alternatives] chapter goes above and beyond by examining a curated list of the best alternative tools and techniques to Chaos Monkey -- we dig into everything from [Azure][/alternatives/azure] and [Docker][/alternatives/docker] to [Kubernetes][/alternatives/kubernetes] and [VMWare][/alternatives/vmware]!

## Who Is This Guide For?

We've created this guide primarily for engineers and other enterprise technologists who are looking for the ultimate resource on Chaos Monkey, helping readers to see how Chaos Monkey fits into the whole realm of Chaos Engineering practices, illustrating what Chaos Monkey can and cannot do, providing the best practices and resources for Monkey-ing your own Chaos, and -- when appropriate -- supplying a well-researched list of alternative technologies and techniques that may be better suited to your organization and the specific needs of your projects.

## Why Did We Create This Guide?

Our goal here at Gremlin is to empower engineering teams to build more resilient systems through thoughtful Chaos Engineering.  We're on a constant quest to promote the [Chaos Community](https://www.gremlin.com/community/) through frequent [conferences & meetups](https://meetup.com/pro/chaos), in-depth [talks](https://www.gremlin.com/community/#talks), detailed [tutorials](https://www.gremlin.com/community/tutorials/), and the ever-growing list of [Chaos Engineering Slack channels](https://www.gremlin.com/slack).

While Chaos Engineering extends well beyond the scope of one single technique or idea, we here at Gremlin feel it's critical for you to understand the full breadth of what Chaos Monkey is (and is not) capable of.  After reading this guide you'll have all the information you need to make informed and educated decisions about what Chaos Engineering technologies, techniques, and tests are best for you and your organization.

## When and Where Should This Guide Be Used?

When and where should this guide be used?  Frankly, we leave that up to you!  We've streamlined every chapter of this guide, so you'll have quick access to all of the information within.  Whether reading this in the office, at home on your laptop, or even late night in bed via our [downloadable PDF version][/pdf-download], you'll have total access to every ounce of that sweet, tangy nectar we could squeeze into this thing.  Mmm, tasty!

## The Pros and Cons of Chaos Monkey

Considering Chaos Monkey was publicly released in 2012, it's still a relatively new technology compared to many other technologies regularly used today (Unix, anyone?).  This means that [Chaos Monkey][/origin-netflix], the [Simian Army][/simian-army], and many related [technologies][/alternatives] have **all** begun burgeoning quite recently.  As such, there is still quite a lot of misinformation, or merely lacks of understanding, surrounding Chaos Monkey's capabilities.

### Pros of Chaos Monkey

**(TODO)**: Expand on on pros.

- Allows for planned system failures when you and your team are prepared to handle them.
- Forces a distributed system by taking down randomized instances and services on a whim.
- Similarly, encourages redundancy -- where one server was sufficient in the past, two servers (or four, or eight, ...) provide a redundant safety net during an eventual failure.
- Encourages separation of the wheat from the chaff: Eliminating all unnecessary dependencies or "bloat", allowing the system to function while using the absolute minimal components and services.
- Encourages backup systems and intelligent, automated workarounds for previously unthinkable outages ("Turns out, even with our core XYZ service offline, we can still run.  Awesome!")
- Available for systems using AWS with Spinnaker.

### Cons of Chaos Monkey

**(TODO)**: Expand on on cons.

> `Pros` and `Cons` list for Chaos Monkey.  Articulate the subtle limitations of Chaos Monkey, while educating readers about alternatives.
>    - Describe Chaos Monkey's usefulness for certain types of failures (e.g. randomized AWS instance unavailability), but express the limitations this brings.

- **_Only_** available for systems using AWS with Spinnaker.
- Limited failure mode (random failure of AWS box).
- If stored state, would go away on reboot.
- As with most open source tools, can cause failure but lacks much semblance of coordination.
- No user interface.
- Limited auditing tools.

## The Origin of Chaos Monkey - Why Netflix Needed to Create Failure

In our [The Origin of Chaos Monkey][/origin-netflix] chapter we examine why Chaos Monkey became the most prolific and well-known technology in Chaos Engineering.  We also dive further into why Netflix created Chaos Monkey after their dramatic database failure in mid-2008 forced them to devise a solution for random service failure.  We also explore the future of Chaos Monkey with version 2.0, Chaos Monkey's reliance on Spinnaker, and the introduction of [Netflix's Failure Injection Testing](https://medium.com/netflix-techblog/fit-failure-injection-testing-35d8e2a9bb2).

## Chaos Monkey Tutorial - A Step-by-Step Guide to Creating Failure on AWS

In the [Chaos Monkey Developer Tutorial][/developer-tutorial] we provide in-depth, step-by-step technical guides for getting Chaos Monkey up and running on AWS.  We also explore a handful of scenarios in which Chaos Monkey may, or may not, be the most relevant solution to provide confidence in handling long tail failure in the way that general Chaos Engineering practices will.

## Taking Chaos Monkey to the Next Level - Advanced Developer Guide

Our [Advanced Developer Guide][/advanced-tips] gets into the nitty-gritty of using Chaos Monkey with walkthroughs for manually deploying Spinnaker stacks on a [local machine][#spinnaker-manual], [virtual machine][#spinnaker-manual], or [with Kubernetes][#spinnaker-stack-with-kubernetes].  We've also included instructions for [deploying Spinnaker][#spinnaker-install] itself, along with [installing Chaos Monkey][#chaos-monkey-install] or [alternative Chaos Engineering tools][/alternatives]!

## The Simian Army - Overview and Resources

**(TODO)**

## Chaos Monkey Resources, Guides, and Downloads for Engineers

**(TODO)**

## Chaos Monkey Alternatives - Tools for Creating Chaos Outside of AWS

**(TODO)**

{% include nav-internal.md %}