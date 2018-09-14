---
title: "Chaos Monkey Alternatives - Tools for Creating Chaos Outside of AWS"
description: "A one-stop resource for a multitude of alternatives to Chaos Monkey, curated and sorted based on the primary technology on which they are based."
path: "/chaos-monkey/alternatives"
url: "https://www.gremlin.com/chaos-monkey/alternatives"
sources: "See: _docs/resources.md"
published: true
outline: "
  - URL: 'https://www.gremlin.com/chaos-monkey/alternatives'
  - Parent: 'Pillar Page: Chaos Monkey Guide for Engineers - Tips, Tutorials, and Training'
  - Layout: Model based on [this landing page list](https://instapage.com/blog/landing-page-examples).  A top-level table of contents should be anchored to `categories` and `sections` within the content
  - Content:
    - Intro:
      - What: 'Describe the purpose of this page as a one-stop resource for a multitude of alternatives to Chaos Monkey, curated and sorted based on the primary technology on which they are based.'
      - Who: 'Explain that the intended audience is engineers looking for alternative solutions to Chaos Monkey that can be used outside of AWS.  Whether the reader knows the specific technology they wish to use, or not, these resources will help.'
      - Why: To provide a list of Chaos Monkey alternatives for readers looking to learn, or who may be disappointed in Chaos Monkey's limitations.
    - Categories:
      - As listed below, each relevant category (as defined in this spreadsheet) will be given its own `section` with a brief description and overview.  Within each `category section` is all relevant sub-technology `sections`, which will each be detailed as necessary.  When relevant, a given `section` should contain a link to the explicit `/alternatives/<technology>` page, which will provide additional details about the actual implementation of a Chaos Monkey alternatives within said technology.
    - CategorySection: Apache
      - Section: Hadoop
      - Section: Kafka
      - Section: Spark
    - Category Section: Containers
      - Section + Page: Docker (`https://www.gremlin.com/chaos-monkey/alternatives/docker`)
      - Section + Page: Gremlin (`https://www.gremlin.com/chaos-monkey/alternatives/gremlin`)
      - Section + Page: OpenShift (`https://www.gremlin.com/chaos-monkey/alternatives/openshift`)
    - Category Section: Erlang VM
      - Section: Elixir
    - Category Section: Infrastructure
      - Section + Page: Azure (`https://www.gremlin.com/chaos-monkey/alternatives/azure`)
      - Section + Page: Google Cloud Platform (`https://www.gremlin.com/chaos-monkey/alternatives/google-cloud-platform`)
      - Section + Page: Kubernetes (`https://www.gremlin.com/chaos-monkey/alternatives/kubernetes`)
      - Section: On Premise
      - Section: OpenStack
      - Section + Page: Private Cloud (`https://www.gremlin.com/chaos-monkey/alternatives/private-cloud`)
      - Section + Page: VMWare (`https://www.gremlin.com/chaos-monkey/alternatives/vmware`)
    - Category Section: Java
      - Section: Maven
      - Section + Page: Spring Boot (`https://www.gremlin.com/chaos-monkey/alternatives/spring-boot`)
    - Category Section: OS
      - Section: Linux
      - Section: Windows
    - Additional Chaos Monkey Resources: In addition to outside resources, _all_ unique pages/URLs found within this guide should be included in this section.  It can later be determined how best to format this, but one possibility is a separate section containing a site map link collection.
"
---

Chaos Monkey serves a singular purpose -- to randomly terminate instances.  As discussed in [Chaos Monkey and Spinnaker][#spinnaker-strictly] and [The Pros and Cons of Chaos Monkey][#chaos-monkey-pros-cons], Chaos Monkey is incapable of covering the broad spectrum of experimentation and failure injection required for proper Chaos Engineering.

In this chapter we'll explore a wide range of tools and techniques -- regardless of the underlying technologies -- that you and your team can use to intelligently induce failures while confidently building toward a more resilient system.

## Apache

### Hadoop



### Kafka

### Spark

## Containers

### Docker

### Gremlin

**(TODO)**: Decide if enough content to warrant this section, or should just mention Gremlin in footer of other relevant sections?  See discussion between John-Henry and Gabe below.

> **JH**: There's an alternatives/gremlin page that's in the plan - let's talk about this in a video meeting when you have a few minutes to chat. There's some search for "chaos monkey vs gremlin" so it makes sense for this page to exist - but I also think it makes sense to put info on how to use Gremlin + [technology the page is about] on every subpage in the alternatives section. What do you think about this? My theory is that's how we can make this thing produce some free trails.

> **Gabe**: I originally added the /chaos-monkey/alternatives/gremlin page on a whim because the brief mentions that the Alternatives page "should also feature Gremlin as an alternative to chaos monkey, and provide a CTA that explains that Gremlin is platform/technology agnostic."  I'm open to your suggestion here since I see the merits in both approaches, but you're the SEO expert and creator of the original brief.

> **Gabe**: From my perspective, I still need to spend more time playing around with the actual Gremlin platform to see what it's capable of and where it is applicable before I can write all those bits, but for the sake of argument, let's assume for a moment that Gremlin is a "viable alternative" in, say, 75%+ of the cases in which we discuss an alternative technology.  In that scenario, I'd be a little concerned that an explicit mention of Gremlin within 3 out of every 4 alternative technology sections would stand out and come across as a little heavy-handed from the reader's perspective.

> **Gabe**: That said, I'm all for CTAs and there's multiple mentions of good places to add them to the guide throughout the brief, so I'm open to further thoughts from you and/or Austin.  Additionally, even if Gremlin could reasonably be listed in 3 out of 4 alternative sections, that doesn't mean we have to do so at every opportunity.  

> **Gabe**: As you suggest, maybe just doing so on every actual sub-page (i.e. those with a unique URL) is sufficient enough without being too overbearing (that'd be on about half of all alternative technology sections).  As mentioned, I won't be writing those sections for a while yet so we can always change stuff up, but for now I'll move forward with your suggestion of mentioning Gremlin only in sub-pages, and I'll also think about whether there's enough content to warrant the extra /chaos-monkey/alternatives/gremlin page on top of that.  Sound good?

> **JH**: I think when Gremlin is a solution, linking to the specific Gremlin docs could be a good option that wont seem heavy handed, we don't need to suggest people sign up for a free trail or anything like that. I'm not sure the /alternatives/gremlin page is needed, that content could just go on the main /alternatives page. However, you will have much more expertise on the product and how to write about it after using it some more. If when exploring the product you come up with a better way to communicate this info, please don't hesitate to suggest and alternative way to communicate this. 

### OpenShift

## Erlang VM

### Elixir

## Infrastructure

### Azure

### Google Cloud Platform

### Kubernetes

### On Premise

### OpenStack

### Private Cloud

### VMWare

## Java

### Maven

### Spring Boot

## OS

### Linux

### Windows

{% include nav-internal.md %}