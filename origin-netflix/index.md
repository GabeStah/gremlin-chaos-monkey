---
title: "The Origin of Chaos Monkey - Why Netflix Needed to Create Failure"
description: "Establishes the current (and historic) role of Chaos Monkey within the Netflix architecture and general Chaos Engineering practices."
path: "/chaos-monkey/origin-netflix"
url: "https://www.gremlin.com/chaos-monkey/origin-netflix"
sources: "See: _docs/resources.md"
published: true
---

- URL: `https://www.gremlin.com/chaos-monkey/origin-netflix`
- Parent: `Pillar Page: Chaos Monkey Guide for Engineers - Tips, Tutorials, and Training`
- Content:
  - `Intro`
    - Why: Answer the general question proposed in title as to why Netflix needed to create Chaos Monkey in the first place.  Detail the overall creation story.
    - What: Establish the current (and historic) role of Chaos Monkey within the Netflix architecture and engineering practices.
    - When/Where: Explore example scenarios where Chaos Monkey has been used and is most appropriate.
    - Who: Discuss other organizations using Chaos Monkey (Amazon, Spinnaker, etc).  Expound on the internal culture that Chaos Monkey helped to promote at both Netflix, Amazon, and elsewhere.

In this chapter we'll take a deep dive into the origins and history of Chaos Monkey, how the streaming side of Netflix came about, and why Netflix needed to create failure within their systems to actually improve their service and customer experiences.  We'll also provide a brief overview of the Simian Army and its relation to the original Chaos Monkey technology.  Finally, we'll jump into the future of Chaos Monkey with version 2.0, examine the differences between older and newer iterations of those tools, dig into the creation and implementation of Failure Injection Testing (FIT) at Netflix, and discuss the potential issues and limitations that Chaos Monkey has presented to Netflix and others in the past.

## The History of Netflix Streaming

Netflix launched their own initial streaming service in early 2007, as a free addon for their existing DVD-by-mail subscribers.  While their initial streaming library contained only [around 1,000 titles](https://profkenhoma.wordpress.com/2009/06/23/netflix-managing-a-still-hot-business-as-its-time-runs-out/) at launch, the popularity and demand continued to rise, and Netflix continued to add to their streaming library by reaching over 12,000 titles by June 2009.

As with any rapidly scaling product, Netflix's streaming service was not without its share of flaws and limitations.  It was [initially built](https://www.nytimes.com/2007/01/16/technology/16netflix.html) by Netflix engineers on top of Microsoft software and housed within vertically scaled server racks.  However, Netflix's reliance on single points of failure within their architecture really bit the team in August 2008 when a [major database corruption](https://media.netflix.com/en/company-blog/completing-the-netflix-cloud-migration) resulted in a three-day downtime in which DVDs couldn't be shipped to waiting customers.  This event in particular led Netflix engineers to conclude their reliance on vertical scaling and monolithic architecture was not the best approach moving forward, and the journey of migrating the entire Netflix stack into the cloud began in late 2008 and was completed by [early January, 2016](https://media.netflix.com/en/company-blog/completing-the-netflix-cloud-migration).  While the *full* migration took about seven years, by [late 2010](https://medium.com/netflix-techblog/four-reasons-we-choose-amazons-cloud-as-our-computing-platform-4aceb692afec) the team had successfully shifted the majority of Netflix's member traffic through software built and deployed in [Amazon Web Services](https://aws.amazon.com/).  The major architectural shift for Netflix was migrating away from a singular, massive app toward building and utilizing hundreds of microservices.

This shift toward a distributed architecture presented a great deal of additional complexity.  Most modern web software is composed of many moving parts including servers, databases, load balancers, clusters, CDNs, VPCs, APIs, and more initialisms than you can shake a stick at.  This level of intricacy and interconnectedness presents problems that can be extremely difficult to understand, let alone resolve.  Failure is inevitable, but with Chaos Engineering techniques systems can be created that are resilient and robust enough better handle future failure.

Netflix's shift toward an entirely horizontally-scalable software stack required systems that were much more reliable and fault tolerant than previously necessary.  One of the most critical lessons -- as made particularly evident by the major database corruption incident back in 2008 -- was that ["the best way to avoid failure is to fail constantly."](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c).  The engineering team needed a tool that could *proactively* inject failure into the system.  This would show the team how the system behaved under abnormal conditions, and taught them how to alter the system so their other services could easily tolerate any future, *unplanned* failures.  Thus, the Netflix team began their journey into Chaos.

## The Simian Army

**(TODO)**: Briefly explore Simian Army, as introduction and lead into [The Simian Army - Overview and Resources][/simian-army] chapter.

## Chaos Monkey Today

Chaos Monkey 2.0 was [announced](https://medium.com/netflix-techblog/netflix-chaos-monkey-upgraded-1d679429be5d) and [publicly released on GitHub](https://github.com/netflix/chaosmonkey) in late 2016.  The new version includes a handful of major feature changes and additions.

- **Spinnaker Integration**: The biggest change introduced with this current version is the full integration (and, thus, reliance upon) [Spinnaker](https://www.spinnaker.io/).  Spinnaker is an open-source, multi-cloud continuous delivery platform developed by Netflix, which allows for automated deployments across multiple cloud providers like AWS, Azure, Kubernetes, and [a few more](https://www.spinnaker.io/reference/providers/).  While this may work for some, the major drawback to modern Chaos Monkey is that it *forces* you and your organization to build atop Spinnaker's CD architecture.  Our [How to Manually Deploy Spinnaker for Chaos Monkey][#spinnaker-manual] tutorials can help you setup and deploy Spinnaker.
- **Improved Scheduling**: Instance termination schedules are no longer determined by probabilistic algorithms, but are instead  based on the *mean time* between terminations.  Check out [How to Schedule Chaos Monkey Terminations][#chaos-monkey-schedule-terminations] for more details.
- **Trackers**: [Trackers](https://netflix.github.io/chaosmonkey/Tracker/) are Go language objects that record instance terminations to external services.
- **Loss of Additional Capabilities**: Prior to 2.0, Chaos Monkey was capable of performing additional actions *beyond* just terminating instances.  With version 2.0, those capabilities have been removed from Chaos Monkey itself and moved to other [Simian Army][/simian-army] tools.

## Failure Injection Testing

In October 2014, dissatisfied with the lack of control introduced by some of the [Simian Army][/simian-army] tools out in the wild, Netflix introduced their solution, which they called *Failure Injection Testing* (*FIT*).  Built by a small team of Netflix engineers -- including Gremlin Co-Founder and CEO [Kolton Andrus](https://www.gremlin.com/team/) -- FIT simplified the failure injection process, allowing Netflix to more precisely determine what fails and who that failure will impact.

FIT 

**(TODO)**: Expound on points below.

- Examine modern and future Chaos Monkey iterations (2.0+).
- Explain changes and upgrade paths from 1.0 to 2.0.
- Explore [Netflix Failure Injection Testing (FIT)](https://medium.com/netflix-techblog/fit-failure-injection-testing-35d8e2a9bb2)
- Discuss Netflix's (and others') use of [`Spinnaker`](https://www.spinnaker.io/) and the potential issues and limitations such tools may present (investment in setup and propagation, maintenance, forced `continuous delivery` solution, etc).

{% include nav-internal.md %}