---
title: "Chaos Monkey Guide for Engineers - Tips, Tutorials, and Training"
description: "A summary of the full Chaos Monkey Guide for Engineers."
date: 2018-08-26
path: "/chaos-monkey"
url: "https://www.gremlin.com/chaos-monkey"
published: true
sources: "See: _docs/resources.md"
---

> This section should be a broad overview of chaos monkey, and link to all the subsections of the guide while answering the questions, "what is chaos monkey" and other basic awareness level questions. 
> Below this intro section, there should be links + descriptions to all other pages in this content plan, each new page will be linked to and listed below, mimicking the format of the Machine Learning Guide for Marketers. 
> http://ipullrank.com/machine-learning-guide/

# Chaos Monkey Guide for Engineers - Tips, Tutorials, and Training

Both in the wilds and during study, monkeys have been observed displaying all manner of interesting and socially-beneficial behaviors.  Primates are known to develop [tight-knit friendships](https://nyaspubs.onlinelibrary.wiley.com/doi/pdf/10.1111/nyas.12315) with their peers, provide each other with [support during agonistic encounters](https://www.ncbi.nlm.nih.gov/pubmed/23304433), [groom one another](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1761567/) as a means of promoting health and developing social bonds, [display relatively advanced emotions](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2826104/), perform [altruistic actions](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2936169/) for the benefit of friends (along with the [occasional reciprocation](https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1461-0248.2009.01396.x)), and are even capable of (at least) a rudimentary [degree of empathy](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4687595/).  While not quite as closely related to human beings as some of their hominoid primate cousins like the chimpanzee, monkeys are often anthropomorphized throughout our culture, within our myths, our media, and even our minds.  And, just like humans, [monkeys are capable](http://carlsafina.org/book/beyond-words-what-animals-think-and-feel/) of surprising compassion and total destruction.

In 2010, taking inspiration from the often dramatic behaviors of wild animals, engineers at [Netflix](https://www.netflix.com) announced the existence and success of their own [resiliency tool](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c), which they lovingly dubbed *Chaos Monkey*.  As described on the [Netflix tech blog](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c), Chaos Monkey served a specific yet vitally important role -- to test system stability by enforcing failures via random killing of instances and services within Netflix's architecture.  With the Netflix service being directly linked to and reliant upon Amazon Web Services (AWS), Netflix needed a technology that could force their hand by deliberately taking down critical components of their service infrastructure *within* the production environment.  The Netflix team was banking on the notion that their ability to handle this single, common type of failure without negatively impacting the customer experience would suss out any weaknesses in their systems and guide them towards automated solutions that could gracefully handle these failures in the future.  Given Netflix's growing success, popularity, and stability over the last half decade, we can surmise that the engineering team was correct in their assumptions.  Chaos Monkey was built to accomplish one particular task for Netflix's particular architecture, and it worked beautifully in that regard.

The following year, in 2011, [Netflix announced](https://medium.com/netflix-techblog/the-netflix-simian-army-16e57fbab116) the evolution of Chaos Monkey with a series of additional tools known as _The Simian Army_.  Inspired by the success of their original Chaos Monkey tool aimed at randomly disabling production instances and services, the engineering team developed additional "simians" built to cause other types of failure and induce abnormal system conditions.  For example, the `Latency Monkey` tool introduces artificial delays in RESTful client-server communication, allowing the team at Netflix to simulate service unavailability without actually taking down said service.  We'll dive into all the details of The Simian Army -- including a close look at every member of that fearsome, technological fighting squad -- \n [The Simian Army - Overview and Resources][/simian-army] section of this guide.

With a stable codebase and ample real-world testing in their pockets, Netflix's engineers publicly released the Chaos Monkey [source code on GitHub](https://github.com/Netflix/chaosmonkey) a few months later in 2012.  

> Introduction to Chaos Monkey

## What Is This Guide?

The [*Chaos Monkey Guide for Engineers*][/] provides a curated and exhaustive examination of Chaos Monkey, including what it is, its [origin story][/origin-netflix], its [pros](#pros-of-chaos-monkey) and [cons](#cons-of-chaos-monkey), its relation to the broader topic of Chaos Engineering, and much more.  We've also included [step-by-step technical tutorials][/developer-tutorial] for getting started with Chaos Monkey, along with [advanced engineering tips and guides][/advanced-tips] for those looking to go beyond the basics.  Speaking of advanced topics, our chapter on [The Simian Army][/simian-army] explores all the additional tools that aim to round out the original Chaos Monkey software.  This guide also provides a plethora of useful [resources, guides, and downloads][/downloads-resources] for engineers seeking to improve their own Chaos Engineering techniques and implementations.  In fact, our [alternative technologies][/alternatives] chapter goes above and beyond by examining a curated list of the best alternative tools and techniques to Chaos Monkey -- we dig into everything from [Azure][/alternatives/azure] and [Docker][/alternatives/docker] to [Kubernetes][/alternatives/kubernetes] and [VMWare][/alternatives/vmware]!

## Who Is This Guide For?

As the title suggest, we've created this guide primarily for engineers and other enterprise technologists who are looking for the ultimate resource on Chaos Monkey, helping readers to see how Chaos Monkey fits into the whole realm of Chaos Engineering practices, illustrating what Chaos Monkey can and cannot do, providing the best practices and resources for Monkey-ing your own Chaos, and -- when appropriate -- supplying a well-researched list of alternative technologies and techniques that may be better suited to your organization and the specific needs of your projects.

## Why Did We Create This Guide?

Our goal here at Gremlin is to empower engineering teams to build more resilient systems through safe experimentation.  We're on a constant quest to promote Chaos Engineering and the massive benefits that come with it -- after all, we live by our motto to "break things on purpose."  We've tried our best to promote the expanding [Chaos Community](https://www.gremlin.com/community/) through frequent [conferences & meetups](https://meetup.com/pro/chaos), in-depth [talks](https://www.gremlin.com/community/#talks), detailed [tutorials](https://www.gremlin.com/community/tutorials/), and the ever-growing list of [Chaos Engineering Slack channels](https://www.gremlin.com/slack).

As Chaos Engineering continues to grow, and as engineers and other thought leaders realize the multitude of benefits Chaos practices provide, we knew that creating this guide the next logical step to support the Chaos community.  While Chaos Engineering extends well beyond the scope of one single technique or idea, Chaos Monkey remains the most recognizable Chaos-related term/technology in the industry, and we here at Gremlin feel it's critical for you, curious reader, to understand the full breadth of what Chaos Monkey is (and is not) capable of.  Ultimately, we created this guide to give you the complete and total story on Chaos Monkey and what it can be used for, so you'll have all the information you need to make informed and educated decisions about what Chaos Engineering technologies, techniques, and tests are best for you and your organization.

## When and Where Should This Guide Be Used?

When and where should this guide be used?  Frankly, we leave that up to you!  We've done our best to streamline every chapter of this guide, so you'll have quick access to all of the information you're most interested in.  Whether reading this in the office, at home on your laptop, or even late night in bed via our [downloadable PDF version][/pdf-download], you'll have total access to every ounce of that sweet, tangy nectar we could squeeze into this thing.  Mmm, tasty!

## The Pros and Cons of Chaos Monkey

Considering Chaos Monkey was publicly released just a few short years ago in 2012, it's still a relatively new technology compared to many other technologies regularly used today (Unix, anyone?).  Additionally, Chaos Engineering practices and concepts more or less emerged into technical consciousness around the same time, which means that [Chaos Monkey][/origin-netflix], the [Simian Army][/simian-army], and many related [technologies][/alternatives] have **all** begun burgeoning quite recently.  As such, there is still quite a lot of misinformation, or merely lacks of understanding, surrounding Chaos Monkey's capabilities and the inherent advantages and disadvantages it brings with it.

### Pros of Chaos Monkey

- Allows for planned system failures when you and your team are prepared to handle them.
- Forces a distributed system by taking down randomized instances and services on a whim.
- Similarly, encourages redundancy -- where one server was sufficient in the past, two servers (or four, or eight, ...) provide a redundant safety net during an eventual failure.
- Encourages separation of the wheat from the chaff: Eliminating all unnecessary dependencies or "bloat", allowing the system to function while using the absolute minimal components and services.
- Encourages backup systems and intelligent, automated workarounds for previously unthinkable outages ("Turns out, even with our core XYZ service offline, we can still run.  Awesome!")
- Available for systems using AWS with Spinnaker.

### Cons of Chaos Monkey

- **_Only_** available for systems using AWS with Spinnaker.
- Limited failure mode (random failure of AWS box).
- If stored state, would go away on reboot.
- As with most open source tools, can cause failure but lacks much semblance of coordination.
- No user interface.
- Limited auditing tools.

> `Pros` and `Cons` list for Chaos Monkey.  Articulate the subtle limitations of Chaos Monkey, while educating readers about alternatives.
>    - Describe Chaos Monkey's usefulness for certain types of failures (e.g. randomized AWS instance unavailability), but express the limitations this brings.

## The Origin of Chaos Monkey - Why Netflix Needed to Create Failure

## Chaos Monkey Tutorial - A Step-by-Step Guide to Creating Failure on AWS

## Taking Chaos Monkey to the Next Level - Advanced Developer Guide

## The Simian Army - Overview and Resources

## Chaos Monkey Resources, Guides, and Downloads for Engineers

## Chaos Monkey Alternatives - Tools for Creating Chaos Outside of AWS

- URL: `https://www.gremlin.com/chaos-monkey/`
- Parent: None
- Content:
  - `Intro`
    - Who: Explain that the guide is meant for all audiences, including engineers, managers, executives, hobbyists, students, and so forth; anyone who is looking to learn more about what Chaos Monkey can (and cannot) do.
    - What: Summarize what the guide will cover, from `hub page` sections such as step-by-step tutorials, advanced engineering tips, simian army details, extensive tool recommendations, and an abundance of additional resources, all curated by Gremlin.
    - Why: Discuss the purpose of the guide to provide resources, critical information, tools, and insight from leaders in the field, so engineers and other readers can make educated decisions about their own Chaos Engineering path.
    - When/Where: Briefly explore when and where this guide can be used -- along with Chaos Monkey and Chaos Engineering in general -- including both professional and private scenarios.  Mention of downloadable `PDF` guide for offline viewing as well.
  - `Pros` and `Cons` list for Chaos Monkey.  Articulate the subtle limitations of Chaos Monkey, while educating readers about alternatives.
    - Describe Chaos Monkey's usefulness for certain types of failures (e.g. randomized AWS instance unavailability), but express the limitations this brings.
  - `Hub Page Section Blurbs`: Include `section` blurbs introducing each `hub page` topic.
    - `Section: The Origin of Chaos Monkey - Why Netflix Needed to Create Failure`
    - `Section: Chaos Monkey Tutorial - A Step-by-Step Guide to Creating Failure on AWS`
    - `Section: Taking Chaos Monkey to the Next Level - Advanced Developer Guide`
    - `Section: The Simian Army - Overview and Resources`
    - `Section: Chaos Monkey Resources, Guides, and Downloads for Engineers`
    - `Section: Chaos Monkey Alternatives - Tools for Creating Chaos Outside of AWS`

[/]:                                    /
[/advanced-tips]:                       /advanced-tips
[/alternatives]:                        /alternatives
[/alternatives/azure]:                  /alternatives/azure
[/alternatives/docker]:                 /alternatives/docker
[/alternatives/google-cloud-platform]:  /alternatives/google-cloud-platform
[/alternatives/kubernetes]:             /alternatives/kubernetes
[/alternatives/openshift]:              /alternatives/openshift
[/alternatives/private-cloud]:          /alternatives/private-cloud
[/alternatives/spring-boot]:            /alternatives/spring-boot
[/alternatives/vmware]:                 /alternatives/vmware
[/developer-tutorial]:                  /developer-tutorial
[/downloads-resources]:                 /downloads-resources
[/origin-netflix]:                      /origin-netflix
[/simian-army]:                         /simian-army