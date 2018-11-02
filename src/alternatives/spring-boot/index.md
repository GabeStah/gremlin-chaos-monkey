---
title: "Chaos Monkey Alternatives - Spring Boot"
description: "Explores Chaos Monkey alternative technologies on Spring Boot."
date: 2018-09-08
path: "/chaos-monkey/alternatives/spring-boot"
url: "https://www.gremlin.com/chaos-monkey/alternatives/spring-boot"
sources: "See: _docs/resources.md"
published: true
redirect_to: https://www.gremlin.com/chaos-monkey/chaos-monkey-alternatives/spring-boot/
---

## Chaos Monkey for Spring Boot

[Chaos Monkey for Spring Boot](https://codecentric.github.io/chaos-monkey-spring-boot/2.0.0/) is an open-source tool written in Java that is installed as either an [internal](https://codecentric.github.io/chaos-monkey-spring-boot/2.0.1/#_dependency_in_your_pom_file) or [external](https://codecentric.github.io/chaos-monkey-spring-boot/2.0.1/#_external_dependency_jar_file) dependency at startup.  Spring Boot for Chaos Monkey can perform three types of **Assaults**: **Latency**, **Exception**, and **KillApplication**.  Assaults are triggered based on **Watcher** components that monitor `@Controller`, `@RestController`, `@Service`, `@Repository`, and `@Component` Spring Boot annotations.

A Watcher can only be triggered by *public* method calls, which can then execute a configured Assault.  A Latency Assault adds random latency to the request, an Exception Assault randomly throws a Runtime Exception, and a KillApplication Assault kills the Spring Boot application.

A few minimal Assault and Watcher settings can be configured via `chaos.monkey` properties, as listed below.

| Property                                      | Description                           | Type           | Default |
| --------------------------------------------- | ------------------------------------- | -------------- | ------- |
| `chaos.monkey.enabled`                        | Toggle Chaos Monkey                   | Boolean        | `FALSE` |
| `chaos.monkey.assaults.level`                 | Assault severity                      | Integer (1-10) | `5`     |
| `chaos.monkey.assaults.latencyRangeStart`     | Minimum latency (MS) added to request | Integer        | `3000`  |
| `chaos.monkey.assaults.latencyRangeEnd`       | Maximum latency (MS) added to request | Integer        | `15000` |
| `chaos.monkey.assaults.latencyActive`         | Toggle Latency Assault                | Boolean        | `TRUE`  |
| `chaos.monkey.assaults.exceptionsActive`      | Toggle Exception Assault              | Boolean        | `FALSE` |
| `chaos.monkey.assaults.killApplicationActive` | Toggle KillApplication Assault        | Boolean        | `FALSE` |
| `chaos.monkey.watcher.controller`             | Toggle Controller Watcher             | Boolean        | `FALSE` |
| `chaos.monkey.watcher.restController`         | Toggle RestController Watcher         | Boolean        | `FALSE` |
| `chaos.monkey.watcher.service`                | Toggle Service Watcher                | Boolean        | `TRUE`  |
| `chaos.monkey.watcher.repository`             | Toggle Repository Watcher             | Boolean        | `FALSE` |
| `chaos.monkey.watcher.component`              | Toggle Component Watcher              | Boolean        | `FALSE` |

Most are self-explanatory, but the Assault severity level property (`chaos.monkey.assaults.level`) actually determines two things: The number of requests between Assaults, and also how many Assaults will occur at that time.  Thus, a default level of `5` means that `5` Assaults will occur on every fifth request.

Configuration properties can be changed at runtime via the [HTTP endpoints](https://codecentric.github.io/chaos-monkey-spring-boot/2.0.1/#_http_endpoint).  For example, sending JSON configuration data to the [`/chaosmonkey/assaults`](https://codecentric.github.io/chaos-monkey-spring-boot/2.0.1/#assaultspost) endpoint can be used to modify future Assault configurations.

```json
{
  "level": 2,
  "latencyRangeStart": 2500,
  "latencyRangeEnd": 7500,
  "latencyActive": true,
  "exceptionsActive": true,
  "killApplicationActive": true,
  "restartApplicationActive": true,
  "watchedCustomServices": [ "com.example.chaos.monkey.chaosdemo.controller.HelloController.sayHello" ]
}
```

Check out the [reference guide](https://codecentric.github.io/chaos-monkey-spring-boot/2.0.1) for more information on getting Chaos Monkey for Spring Boot up and running.

## Injecting Failure in Spring Boot Applications with Gremlin

Gremlin's [Failure as a Service][#gremlin-failure-as-a-service] makes it easy to execute thoughtful Chaos Experiments within your standalone Spring-based applications, including those built with Spring Boot.  Rather than inject itself directly into your application's Java code Gremlin performs attacks against the instances powering your application.  Gremlin can execute a wide range of attacks including draining disk space, hogging CPU and memory, overloading IO, manipulating network traffic, terminating instances, and more.

Running your first Chaos Experiment with Gremlin is as simple as [signing up][#gremlin-account-signup] for a Gremlin account, [installing](https://help.gremlin.com/install-gremlin-ubuntu-1604/) the Gremlin daemon on the targeted instances, and then launching attacks via either the [web UI][#gremlin-web-ui] or [API][#gremlin-api].  Check out [this installation tutorial](https://help.gremlin.com/install-gremlin-ubuntu-1604/) to get started!

## Chaos Engineering with Fabric8 and Spring Boot

The [Fabric8](http://www.fabric8.io/) development platform has [first-class support](http://spring.fabric8.io/) for building Spring Boot applications and comes with a [built-in Chaos Monkey](https://fabric8.io/guide/chaosMonkey.html) app.  The Fabric8 Chaos Monkey is capable of deleting pods within Kubernetes/OpenShift applications.  

To get started in the Fabric8 console navigate to **Apps**, click **Run...**, select the **Chaos Monkey** app, and run it.  Once the Chaos Monkey app is running within your Fabric8 Sprint Boot deployment you can configure Chaos Monkey using a few options.

- **Chaos Monkey Excludes**: A comma-separated regex pattern list indicating which pods *are not* eligible for deletion.
- **Chaos Monkey Includes**: A comma-separated regex pattern list indicating which pods *are* eligible for deletion.
- **Chaos Monkey Frequency Seconds**: The delay between each pod deletion.

You can also optionally run the ChatOps app and set the **Chaos Monkey Room** configuration option to indicate which chat room Chaos Monkey should communicate with.  The Chaos Monkey app will then post notifications of its actions in chat.

```bash
# CHAT OUTPUT EXAMPLE
added replicationController chaos-monkey
added pod chaos-monkey-2fahv
Chaos Monkey is starting in namespace default with include patterns 'fabric8mq*' exclude patterns 'chat*' and a kill frequency of 30 seconds.  Here I come!
Chaos Monkey killed pod fabric8mq-consumer-7hwe1 in namespace default
```

Have a look at the [official documentation](https://fabric8.io/guide/chaosMonkey.html) for more details.

{% include nav-internal.md %}