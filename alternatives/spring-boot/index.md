---
title: "Chaos Monkey Alternatives - Spring Boot"
description: "Explores Chaos Monkey alternative technologies on Spring Boot."
date: 2018-09-08
path: "/chaos-monkey/alternatives/spring-boot"
url: "https://www.gremlin.com/chaos-monkey/alternatives/spring-boot"
sources: "See: _docs/resources.md"
published: true
outline: "
- URL: `https://www.gremlin.com/chaos-monkey/alternatives/spring-boot`
- Parent: `Category Section: Java`
- Content:
  - `Overview`: _See above._
  - [`Spring Boot Chaos Monkey`](https://codecentric.github.io/chaos-monkey-spring-boot/): A small library which implements a Chaos Monkey for testing and attacking a [`Spring Boot`](http://spring.io/projects/spring-boot) application.
  - https://jaxenter.com/chaos-monkey-spring-boot-143435.html
- Competition
  - https://codecentric.github.io/chaos-monkey-spring-boot/
  - https://www.baeldung.com/spring-boot-chaos-monkey
"
---

## Injecting Failure in Spring Boot Applications with Gremlin

Gremlin's [Failure as a Service][#gremlin-failure-as-a-service] makes it easy to execute thoughtful Chaos Experiments within your standalone Spring-based applications, including those built with Spring Boot.  Rather than inject itself directly into your application's Java code Gremlin performs attacks against the instances powering your application.  Gremlin can execute a wide range of attacks including draining disk space, hogging CPU and memory, overloading IO, manipulating network traffic, terminating instances, and more.

Running your first Chaos Experiment with Gremlin is as simple as [signing up][#gremlin-account-signup] for a Gremlin account, [installing](https://help.gremlin.com/install-gremlin-ubuntu-1604/) the Gremlin daemon on the targeted instances, and then launching attacks via either the [web UI][#gremlin-web-ui] or [API][#gremlin-api].  Check out [this installation tutorial](https://help.gremlin.com/install-gremlin-ubuntu-1604/) to get started!

{% include nav-internal.md %}