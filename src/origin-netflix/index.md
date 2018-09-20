---
title: "The Origin of Chaos Monkey - Why Netflix Needed to Create Failure"
description: "Establishes the current (and historic) role of Chaos Monkey within the Netflix architecture and general Chaos Engineering practices."
path: "/chaos-monkey/origin-netflix"
url: "https://www.gremlin.com/chaos-monkey/origin-netflix"
sources: "See: _docs/resources.md"
published: true
outline:
  - URL: https://www.gremlin.com/chaos-monkey/origin-netflix
  - Parent: 'Pillar Page: Chaos Monkey Guide for Engineers - Tips, Tutorials, and Training'
  - Content:
    - Intro:
      - Why: 'Answer the general question proposed in title as to why Netflix needed to create Chaos Monkey in the first place.  Detail the overall creation story.'
      - What: 'Establish the current (and historic) role of Chaos Monkey within the Netflix architecture and engineering practices.'
      - When/Where: 'Explore example scenarios where Chaos Monkey has been used and is most appropriate.'
      - Who: 'Discuss other organizations using Chaos Monkey (Amazon, Spinnaker, etc).  Expound on the internal culture that Chaos Monkey helped to promote at both Netflix, Amazon, and elsewhere.'
---

In this chapter we'll take a deep dive into the origins and history of Chaos Monkey, how [Netflix streaming services emerged][#netflix-history], and why Netflix needed to create failure within their systems to actually improve their service and customer experiences.  We'll also provide a brief overview of the [Simian Army][#netflix-simian-army] and its relation to the original Chaos Monkey technology.  Finally, we'll jump into the [present and future of Chaos Monkey][#chaos-monkey-today], dig into the creation and implementation of [Failure Injection Testing][#netflix-fit] at Netflix, and discuss the potential issues and limitations presented by Chaos Monkey's [reliance on Spinnaker][#spinnaker-strictly].

## The History of Netflix Streaming

Netflix launched their streaming service in early 2007, as a free addon for their existing DVD-by-mail subscribers.  While their initial streaming library contained only [around 1,000 titles](https://profkenhoma.wordpress.com/2009/06/23/netflix-managing-a-still-hot-business-as-its-time-runs-out/) at launch, the popularity and demand continued to rise, and Netflix kept adding to their streaming library, reaching over 12,000 titles by June 2009.

Netflix's streaming service was [initially built](https://www.nytimes.com/2007/01/16/technology/16netflix.html) by Netflix engineers on top of Microsoft software and housed within vertically scaled server racks. However, this single point of failure came back to bite them in August 2008, when a [major database corruption](https://media.netflix.com/en/company-blog/completing-the-netflix-cloud-migration) resulted in a three-day downtime during which DVDs couldn’t be shipped to customers. Following this event, Netflix engineers began migrating the entire Netflix stack away from a monolithic architecture, and into a distributed cloud architecture, deployed on [Amazon Web Services](https://aws.amazon.com/).

This major shift toward a distributed architecture of hundreds of microservices presented a great deal of additional complexity. This level of intricacy and interconnectedness in a distributed system created something that was intractable and required a new approach to prevent seemingly random outages.  But by using proper Chaos Engineering techniques, starting first with Chaos Monkey, and evolving into [more sophisticated tools like FIT](https://medium.com/netflix-techblog/fit-failure-injection-testing-35d8e2a9bb2), Netflix was able to engineer a resilient architecture.

Netflix's move toward a horizontally scaled software stack required systems that were much more reliable and fault tolerant.  One of the most critical lessons -- as made particularly evident by the major database corruption incident back in 2008 -- was that ["the best way to avoid failure is to fail constantly."](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c).  The engineering team needed a tool that could *proactively* inject failure into the system.  This would show the team how the system behaved under abnormal conditions, and would teach them how to alter the system so other services could easily tolerate future, *unplanned* failures.  Thus, the Netflix team began their journey into Chaos.

## The Simian Army

**(TODO)**: Briefly explore Simian Army, as introduction and lead into [The Simian Army - Overview and Resources][/simian-army] chapter.

## Chaos Monkey Today

Chaos Monkey 2.0 was [announced](https://medium.com/netflix-techblog/netflix-chaos-monkey-upgraded-1d679429be5d) and [publicly released on GitHub](https://github.com/netflix/chaosmonkey) in late 2016.  The new version includes a handful of major feature changes and additions.

- **Spinnaker Requirement**: [Spinnaker](https://www.spinnaker.io/) is an open-source, multi-cloud continuous delivery platform developed by Netflix, which allows for automated deployments across multiple cloud providers like AWS, Azure, Kubernetes, and [a few more](https://www.spinnaker.io/reference/providers/).  One major drawback of using Chaos Monkey is that it *forces* you and your organization to build atop Spinnaker's CD architecture.  If you need some guidance on that, check out our [Spinnaker deployment tutorials][#spinnaker-manual].
- **Improved Scheduling**: Instance termination schedules are no longer determined by probabilistic algorithms, but are instead  based on the *mean time* between terminations.  Check out [How to Schedule Chaos Monkey Terminations][#chaos-monkey-schedule-terminations] for technical instructions.
- **Trackers**: [Trackers](https://netflix.github.io/chaosmonkey/Tracker/) are Go language objects that report instance terminations to external services.
- **Loss of Additional Capabilities**: Prior to 2.0, Chaos Monkey was capable of performing additional actions *beyond* just terminating instances.  With version 2.0, those capabilities have been removed and moved to other [Simian Army][/simian-army] tools.

## Failure Injection Testing

In October 2014, dissatisfied with the lack of control introduced when unleashing some of the [Simian Army][/simian-army] tools, [Netflix introduced](https://medium.com/netflix-techblog/fit-failure-injection-testing-35d8e2a9bb2) a solution they called *Failure Injection Testing* (*FIT*).  Built by a small team of Netflix engineers -- including Gremlin Co-Founder and CEO [Kolton Andrus](https://twitter.com/koltonandrus) -- FIT added dimensions to the failure injection process, allowing Netflix to more precisely determine what was failing and which components that failure impacted.

FIT works by first pushing failure simulation metadata to [Zuul](https://github.com/Netflix/zuul/wiki), which is an edge service developed by Netflix.  Zuul handles all requests from devices and applications that utilize the back end of Netflix's streaming service.  As of version 2.0, [Zuul can handle](https://github.com/Netflix/zuul/wiki/Core-Features) dynamic routing, monitoring, security, resiliency, load balancing, connection pooling, and more.  The core functionality of Zuul's business logic comes from [*Filters*](https://github.com/Netflix/zuul/wiki/Filters), which behave like simple **pass/fail** tests applied to each request and determine if a given action should be performed for that request.  A filter can handle actions such as [adding debug logging](https://github.com/Netflix/zuul/blob/2.1/zuul-sample/src/main/groovy/com/netflix/zuul/sample/filters/inbound/DebugRequest.groovy), determining if a [response should be GZipped](https://github.com/Netflix/zuul/blob/2.1/zuul-core/src/main/java/com/netflix/zuul/filters/common/GZipResponseFilter.java), or [attaching injected failure](https://medium.com/netflix-techblog/fit-failure-injection-testing-35d8e2a9bb2#f07e), as in the case of FIT.

The introduction of FIT into Netflix's failure injection strategy was a monumental move toward better, modern-day Chaos Engineering practices.  Since FIT is a service unto itself, it allowed failure to be injected by a variety of teams, who could then perform proactive Chaos Experiments with greater precision.  This allowed Netflix to truly emphasize a core discipline of Chaos Engineering, knowing they were testing for failure in every nook and cranny, proving confidence that their systems were resilient to truly *unexpected* failures.

**(TODO)**: https://docs.google.com/document/d/1sLcvq2zpEpHieI2bJdg3zbA4amEsDT2ant0u77vgKYE/edit?disco=uiAAAACMDlDW8

> Austin: this would be a good place to put some of the Gremlin Demo account usage to work. Describe a couple failure states that Chaos Monkey couldn't test for that FIT could as a way of illustrating the limitations of Chaos Monkey

## Chaos Monkey and Spinnaker

As discussed [above][#chaos-monkey-today] and later in our [Spinnaker Quick Start][#spinnaker-quick-start] guide, Chaos Monkey can **only** be used to terminate instances within an application managed by [Spinnaker](https://spinnaker.io).

![bummer](../images/origin-netflix-bummer.gif 'Bill Murray Bummer')

This requirement is not a problem for Netflix or those other companies (such as [Waze](https://cloudplatform.googleblog.com/2017/02/guest-post-multi-cloud-continuous-delivery-using-Spinnaker-at-Waze.html)) that using Spinnaker to great success.  However, limiting your Chaos Engineering tools and practices to just Chaos Monkey also means limiting yourself to only Spinnaker as your continuous delivery and deployment solution.  This may present a number of potential issues:

- **Setup and Propagation**: Spinnaker requires quite a bit of investment in server setup and propagation.  As you may notice in even the streamlined, provider-specific tutorials found [later in this guide][/advanced-tips], getting Spinnaker up and running on a production environment takes a lot of time (and a hefty number of CPU cycles).
- **Limited Documentation**: Spinnaker's [official documentation](https://www.spinnaker.io/setup/install/) is rather limited and somewhat outdated in certain areas.
- **Provider Support**: Spinnaker currently supports most of the [big name cloud providers](https://www.spinnaker.io/concepts/providers/), but if your use case requires a provider outside of this list you're out of luck (or will need to develop your own [CloudDriver](https://github.com/spinnaker/clouddriver)).

{% include nav-internal.md %}