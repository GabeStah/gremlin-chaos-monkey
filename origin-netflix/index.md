---
title: "The Origin of Chaos Monkey - Why Netflix Needed to Create Failure"
description: "Establishes the current (and historic) role of Chaos Monkey within the Netflix architecture and general Chaos Engineering practices."
date: 2018-08-30
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

As bizarre as it may seem with the proliferation of video streaming most of us experience in our day-to-day lives, it wasn't that long ago that Netflix was *exclusively* a peddler of physical DVDs.  Throughout most of the early 2000s, binging TV shows or movies with Netflix was much more difficult than it is today, since the mail service and turnaround times were only so fast.  ("Netflix and chill?  Sure, just give it a few days while we wait for the mail carrier...")

In this chapter we'll take a deep dive into the origins and history of Chaos Monkey, how the streaming side of Netflix came about, and why Netflix needed to create failure within their systems to actually improve their service and customer experiences.  We'll also provide a brief overview of the Simian Army and its relation to the original Chaos Monkey technology.  Finally, we'll jump into the future of Chaos Monkey with version 2.0, examine the differences between older and newer iterations of those tools, dig into the creation and implementation of Failure Injection Testing (FIT) at Netflix, and discuss the potential issues and limitations that Chaos Monkey has presented to Netflix and others in the past.

## The History of Netflix Streaming

While Netflix's DVD-by-mail service was generally considered successful, those first few years were a bit of a struggle.  As Patty McCord, Chief Talent Officer at Netflix from 1998 through 2012, [explains](https://hbr.org/2014/01/how-netflix-reinvented-hr), early 2001 saw the dot-com bubble burst and forced Netflix into laying off of a third of their employees.  In spite of this setback, the DVD-by-mail service continued to grow as the 2002 Christmas season saw a [massive jump](https://www.cnet.com/news/dvd-sales-see-hot-growth-projections/) in DVD player sales, with [DVD sales finally surpassing VHS sales](https://www.bizjournals.com/sanjose/stories/2002/01/07/daily34.html) for the first time that same year.  Netflix initiated their [IPO in May 2002](https://www.nytimes.com/2002/05/23/business/offering-of-netflix-brings-in-82.5-million.html) and was finally able to post its first profit during [fiscal year 2003](https://www.netflixinvestor.com/financials/quarterly-earnings/default.aspx).

In spite of this success, the industry was beginning to trend away from physical DVD rentals to a more direct content delivery method.  In fact, Netflix was beat to the streaming punch by Amazon, who launched their own video on demand service known as [Amazon Unbox](http://phx.corporate-ir.net/phoenix.zhtml?c=176060&p=irol-newsArticle&ID=903244) on September 7th, 2006.  As DVD sales began to decline the industry incorrectly predicted the demise of Netflix, but as Netflix's CEO Reed Hastings [told *The New York Times*](https://www.nytimes.com/2007/01/16/technology/16netflix.html) in early January 2007, "We've gotten used to it.  Because DVD is not a hundred-year format, people wonder what will Netflix's second act be."  

In fact, Netflix already knew what that second act would entail and, not be outdone by Amazon, Netflix launched their own initial streaming service in early 2007, as a free addon for their existing DVD-by-mail subscribers.  While their initial streaming library contained only [around 1,000 titles](https://profkenhoma.wordpress.com/2009/06/23/netflix-managing-a-still-hot-business-as-its-time-runs-out/) at launch, the popularity and demand continued to rise, and Netflix continued to add to their streaming library by reaching over 12,000 titles by June 2009.

Unfortunately, Netflix's streaming service was not without its share of flaws and limitations.  It was [initially built](https://www.nytimes.com/2007/01/16/technology/16netflix.html) by Netflix engineers on top of Microsoft software and housed within vertically scaled server racks.  However, Netflix's reliance on single points of failure within their architecture really bit the team in August 2008 when a [major database corruption](https://media.netflix.com/en/company-blog/completing-the-netflix-cloud-migration) resulted in a three-day downtime in which DVDs couldn't be shipped to waiting customers.  This event in particular led Netflix engineers to conclude their reliance on vertical scaling and monolithic architecture was not the best approach moving forward, and the journey of migrating the entire Netflix stack into the cloud began in late 2008 and was completed by [early January, 2016](https://media.netflix.com/en/company-blog/completing-the-netflix-cloud-migration).  While the *full* migration took about seven years, by [late 2010](https://medium.com/netflix-techblog/four-reasons-we-choose-amazons-cloud-as-our-computing-platform-4aceb692afec) the team had successfully shifted the majority of Netflix's member traffic through software built and deployed in [Amazon Web Services](https://aws.amazon.com/).  The major architectural shift for Netflix was migrating away from a singular, massive app toward building and utilizing hundreds of *immutable, loosely coupled microservices that have bounded contexts*.  As Adrian Cockcroft, Director of Web Engineering and later Cloud Architect at Netflix, [explains during a 2014 talk](https://youtu.be/5qJ_BibbMLw?t=1554), "immutable, loosely coupled" microservices are services that can be updated independently of one another.  Additionally, the notion of "bounded context" originates from the book [*Domain Driven Design*](https://www.amazon.com/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215) by Eric Evans.  When applied to microservices it simply means that the code and functionality of each service is wholly independent of all other services -- a change to how `Service A` functions has no impact on the functionality of `Service B` or `Service C`.  Netflix's microservices communicate with each other through APIs, so the microservice that handles `user authentication` can always communicate with the `account creation` microservice, regardless of the internal workings of each service.

Netflix's shift toward an entirely horizontally-scalable software stack required systems that were much more reliable and fault tolerant than previously necessary.  The move into AWS and cloud computing provided many benefits, but it also presented a new set of challenges and lessons the team had to quickly learn and adapt to.  One of the most critical lessons -- as made particularly evident by the major database corruption incident back in 2008 -- was that ["the best way to avoid failure is to fail constantly."](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c).  The engineering team needed a tool that could cause microservices to fail, thereby *forcing* all other systems to tolerate this failure and continue to function appropriately.  The Netflix team thus began their journey into Chaos.

## Let the Monkeys Hit the Racks

In 2010, taking inspiration from the frequently dramatic behaviors of a beloved sub-group of primates, engineers at [Netflix](https://www.netflix.com) announced the existence and success of their own [resiliency tool](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c), which they lovingly dubbed *Chaos Monkey*.  [Chaos Monkey served](https://medium.com/netflix-techblog/5-lessons-weve-learned-using-aws-1f2a28588e4c) a specific yet vitally important role -- to test system stability by enforcing failures through the random killing of instances and services within Netflix's architecture.  With the Netflix service being directly linked to and reliant upon Amazon Web Services (AWS), Netflix needed a technology that could force their hand by deliberately taking down critical components of their microservice infrastructure *within* the production environment.  The Netflix team was banking on the notion that their ability to handle this single, common type of failure without negatively impacting the customer experience would suss out any weaknesses in their systems and guide them towards automated solutions that could gracefully manage these failures in the future.  Given Netflix's growing success, popularity, and stability over the last half decade, we can deduce that the engineering team was correct in their assumptions.  Chaos Monkey was built to accomplish one particular task for Netflix's particular architecture, and it worked beautifully in that regard.

By the following year, [Netflix had announced](https://medium.com/netflix-techblog/the-netflix-simian-army-16e57fbab116) the evolution of Chaos Monkey with a series of additional tools known as *The Simian Army*.  Inspired by the success of their original Chaos Monkey tool aimed at randomly disabling production instances and services, the engineering team developed additional "simians" built to cause other types of failure and induce abnormal system conditions.  For example, the `Latency Monkey` tool introduces artificial delays in RESTful client-server communication, allowing the team at Netflix to simulate service unavailability without actually taking down said service.  We'll dive into all the details of The Simian Army -- including a close look at every member of that fearsome, technological fighting squad -- in [The Simian Army - Overview and Resources][/simian-army] section of this guide.

With a stable codebase and ample real-world testing in their pockets, Netflix's engineers publicly released the Chaos Monkey [source code on GitHub](https://github.com/Netflix/chaosmonkey) a few months later in 2012.  

## The Simian Army

    - Briefly explore Simian Army, as introduction and lead into `The Simian Army - Overview and Resources` `hub page`.

## Chaos Monkey Today



    - Examine modern and future Chaos Monkey iterations (2.0+).
    - Explain changes and upgrade paths from 1.0 to 2.0.
    - Explore [Netflix Failure Injection Testing (FIT)](https://medium.com/netflix-techblog/fit-failure-injection-testing-35d8e2a9bb2)
    - Discuss Netflix's (and others') use of [`Spinnaker`](https://www.spinnaker.io/) and the potential issues and limitations such tools may present (investment in setup and propagation, maintenance, forced `continuous delivery` solution, etc).

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