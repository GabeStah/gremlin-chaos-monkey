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
      - Section + Page: VMware (`https://www.gremlin.com/chaos-monkey/alternatives/vmware`)
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

**(TODO)**

### Hadoop

**(TODO)**

### Kafka

**(TODO)**

### Spark

**(TODO)**

## Containers

**(TODO)**

### Docker

Check out [Chaos Monkey Alternatives - Docker][/alternatives/docker] for details on using Pumba, Gremlin, Docker Chaos Monkey, and Docker Simian Army to inject chaos into your Docker containers.

### OpenShift

Head over to the [Chaos Monkey Alternatives - OpenShift][/alternatives/openshift] chapter for information on utilizing Monkey Ops, Gremlin, and Pumba to run Chaos Experiments in OpenShift distributions.

## Erlang VM

**(TODO)**

### Elixir

**(TODO)**

## Infrastructure

**(TODO)**

### Azure

Have a look at our [Chaos Monkey Alternatives - Azure][/alternatives/azure] chapter for the guidance on how the Azure Search team created their own Search Chaos Monkey, along with implementing your own Chaos Engineering practices in Azure with Gremlin, WazMonkey, and Azure's Fault Analysis Service.

### Google Cloud Platform

Check out [Chaos Monkey Alternatives - Google Cloud Platform][/alternatives/google-cloud-platform] for details on using the simple Google Cloud Chaos Monkey tool, Gremlin's Failure as a Service, and the open-source Chaos Toolkit for injecting failure into your own Google Cloud Platform systems.

### Kubernetes

A quick read of our [Chaos Monkey Alternatives - Kubernetes][/alternatives/kubernetes] chapter will teach you all about the Kube Monkey, Kubernetes Pod Chaos Monkey, Chaos Toolkit, and Gremlin tools, which can be deployed on Kubernetes clusters to execute Chaos Experiments and create more resilient applications.

### On Premise

**(TODO)**

#### Blockade

- https://github.com/worstcase/blockade

#### Toxiproxy

- https://github.com/Shopify/toxiproxy

### OpenStack

**(TODO)**

### Private Cloud

Take a look at the [Chaos Monkey Alternatives - Private Cloud][/alternatives/private-cloud] chapter to see how to begin Chaos Engineering within your own private cloud architecture using GomJabbar, Gremlin, and Muxy.

### VMware

Check out the [Chaos Monkey Alternatives - VMware][/alternatives/vmware] chapter to learn about the Chaos Lemur tool and Gremlin's own Failure as a Service solution, both of will inject failure into your VMware- or BOSH-managed virtual machines with relative ease.

## Java

**(TODO)**

- https://github.com/osrg/namazu

### Maven

**(TODO)**

- https://github.com/mrwilson/byte-monkey
- http://maven.fabric8.io/
- https://fabric8.io/guide/chaosMonkey.html
- https://github.com/strepsirrhini-army/chaos-lemur

### Spring Boot

Exploring our [Chaos Monkey Alternatives - Spring Boot][/alternatives/spring-boot] chapter will teach you about how to use Chaos Monkey for Spring Boot, Gremlin, and Fabric8 to execute Chaos Experiments against your Spring Boot applications.

## OS

**(TODO)**

- https://github.com/Shopify/toxiproxy

### Linux

**(TODO)**

- https://github.com/bbc/chaos-lambda

### Windows

**(TODO)**

{% include nav-internal.md %}