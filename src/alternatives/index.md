---
title: "Chaos Monkey Alternatives - Tools for Creating Chaos Outside of AWS"
description: "A one-stop resource for a multitude of alternatives to Chaos Monkey, curated and sorted based on the primary technology on which they are based."
path: "/chaos-monkey/alternatives"
url: "https://www.gremlin.com/chaos-monkey/alternatives"
sources: "See: _docs/resources.md"
published: true
redirect_to: https://www.gremlin.com/chaos-monkey/chaos-monkey-alternatives/
---

Chaos Monkey serves a singular purpose -- to randomly terminate instances.  As discussed in [Chaos Monkey and Spinnaker][#spinnaker-strictly] and [The Pros and Cons of Chaos Monkey][#chaos-monkey-pros-cons], additional tools are required when using Chaos Monkey, in order to cover the broad spectrum of experimentation and failure injection required for proper Chaos Engineering.

In this chapter, we'll explore a wide range of tools and techniques -- regardless of the underlying technologies -- that you and your team can use to intelligently induce failures while confidently building toward a more resilient system.

## Apache

Perhaps the most prominent fault-tolerant tool for Apache is [Cassandra](https://cassandra.apache.org/), the NoSQL, performant, highly-scalable data management solution.  Check out [this talk](https://www.youtube.com/watch?v=Mu01DmxQjWA) by Christos Kalantzis, Netflix's Director of Engineering for a great example of how Chaos Engineering can be applied within Cassandra.

### Hadoop

Hadoop's unique Distributed File System (HDFS) requires that the [FileSystem Java API](http://hadoop.apache.org/docs/current/api/) and shell access allow applications and the operating system to read and interact with the HDFS.  Therefore, most of the Chaos Engineering tools that run on underlying systems can also be used for injecting failure into Hadoop.  Check out the [Linux][/alternatives#linux] section in particular.

#### Anarchy Ape

[Anarchy Ape](https://github.com/david78k/anarchyape) is an open-source tool primarily coded in Java that injects faults into Hadoop cluster nodes.  It is capable of corrupting specific files, corrupting random HDFS blocks, disrupting networks, killing DataNodes or NameNodes, dropping network packets, and much more.

Anarchy Ape is executed via the `ape` command line tool.  Check out the [official repository](https://github.com/david78k/anarchyape) for more details on installing and using Anarchy Ape on your Hadoop clusters.

#### Hadoop Killer

[Hadoop Killer](https://github.com/oza/hadoop-killer) is an open-source tool written in Ruby that kills random Java processes on a local system.  It can be installed using RubyGems and is configured via a simple YAML syntax.

```yaml
kill:
  target : "MyProcess"
  max: 3
  probability: 20
  interval: 1
```

- `target`: The name of the process to kill.
- `max`: Maximum number of times to kill the process.
- `probability`: Percentage probability to kill the process during each attempt.
- `interval`: Number of seconds between attempts.

Have a look at the [GitHub repository](https://github.com/oza/hadoop-killer) for the basic info on using Hadoop Killer.

### Kafka

The primary fault injection tool explicitly built for Kafka is its built-in [Trogdor](https://github.com/apache/kafka/blob/trunk/TROGDOR.md) test framework.  Trogdor executes fault injection through a single-coordinator multi-agent process.  Trogdor has two built-in fault types.

- `ProcessStopFault`: Stops the specified process by sending a `SIGSTOP` signal.
- `NetworkPartitionFault`: Creates an artificial network partition between nodes using `iptables`.

Each user agent can be assigned to perform a **Task**, which is an action defined in JSON and includes the full Java `class`, along with `startMs` and `durationMs`, which indicate the milliseconds since the Unix epoch for when to start and how long to run the Task, respectively.  All additional fields are customized and Task-specific.

Here's a simple Task to trigger a `NetworkPartitionFault` by creating a network partition between `node1` and `node2`.

```json
{
    "class": "org.apache.kafka.trogdor.fault.NetworkPartitionFaultSpec",
    "startMs": 1000,
    "durationMs": 30000,
    "partitions": ["node1", "node2"]
}
```

Check out the [wiki documentation](https://cwiki.apache.org/confluence/display/KAFKA/Fault+Injection) for more details on using Trogdor to inject faults and perform tests in your Kafka system.

### Spark

Chaos Engineering with Spark comes down to the underlying platforms on which your application resides.  For example, if you're using the [Tensorframes](https://github.com/databricks/tensorframes) wrapper to integrate Spark with your TensorFlow application then Gremlin's [Failure as a Service][/alternatives/google-cloud-platform#gremlin] solution can help you inject failure and learn how to create a more resilient application.

Spark Streaming applications also include built-in fault-tolerance.  Each [Resilient Distributed Dataset](http://spark.apache.org/docs/latest/api/scala/index.html#org.apache.spark.rdd.RDD) (RDD) that Spark handles is subject to loss prevention policies defined in the [Fault-Tolerance Semantics](http://spark.apache.org/docs/latest/streaming-programming-guide.html#fault-tolerance-semantics) documentation.

Lastly, Spark's built-in integration tests include a handful of fault injections like the [NetworkFaultInjection](https://github.com/databricks/spark-integration-tests/blob/master/src/test/scala/org/apache/spark/integrationtests/SparkStandaloneSuite.scala).

## Containers

There are an abundance of Chaos Monkey alternatives for container-based applications.  Browse through the [Chaos Monkey Alternatives - Docker][/alternatives/docker] and [Chaos Monkey Alternatives - OpenShift][/alternatives/openshift] chapters for many great solutions.

### Docker

Check out [Chaos Monkey Alternatives - Docker][/alternatives/docker] for details on using Pumba, Gremlin, Docker Chaos Monkey, and Docker Simian Army to inject chaos into your Docker containers.

### OpenShift

Head over to the [Chaos Monkey Alternatives - OpenShift][/alternatives/openshift] chapter for information on utilizing Monkey Ops, Gremlin, and Pumba to run Chaos Experiments in OpenShift distributions.

## Erlang VM

In addition to the Elixir-specific [Chaos Spawn][/alternatives#elixir] tool, [this presentation](https://www.youtube.com/watch?v=W_j-5BeiaYE) by Pavlo Baron shows a real-time demo of a Chaos Experiment that injects failure into 1,000 parallel actors within Erlang VM.

### Elixir

[Chaos Spawn](https://github.com/meadsteve/chaos-spawn) is an open-source tool written in Elixir that periodically terminates low-level processes.  Based on Chaos Monkey, Chaos Spawn has limited capabilities but it is also quite easy to install and configure.

1. To install Chaos Spawn just add `chaos_spawn` to your `mix.exs` dependencies.

    ```elixir
    # mix.exs
    defp deps do
      [
        { :chaos_spawn, "~> 0.8.0" },
        # ...
      ]
    end
    ```

2. Within `mix.exs` you'll also need to add `chaos_spawn` to `applications`.

    ```elixir
    def application do
      applications: [:chaos_spawn, :phoenix, :phoenix_html, :logger]]
    end
    ```

3. Add `use ChaosSpawn.Chaotic.Spawn` to any module that should be eligible to create targetable processes.

    ```elixir
    defmodule ChaosSpawn.Example.Spawn do
      use ChaosSpawn.Chaotic.Spawn

      def test do
        spawn fn ->
          IO.puts "Message sent"
          receive do
            _ -> IO.puts "Message received"
          end
        end
      end
    end
    ```

4. You can also add `:chaos_spawn` configuration keys to your `config/config.exs` file.

    ```elixir
    # config/config.exs
    # Milliseconds between spawn checks.
    config :chaos_spawn, :kill_tick, 5000
    # Per-tick probability of killing a targeted process (0.0 - 1.0).
    config :chaos_spawn, :kill_probability, 0.25
    # Valid time period (UTC) in which to kill processes.
    config :chaos_spawn, :only_kill_between, {% raw %}{{12, 00, 00}, {16, 00, 00}}{% endraw %}
    ```

Have a look at the [official GitHub repository](https://github.com/meadsteve/chaos-spawn) for more info on using Chaos Spawn to inject Chaos in your Elixir applications.

## Infrastructure

There are dozens of alternative tools to Chaos Monkey available for the most popular infrastructure technologies and platforms on the market.  Have a look through [Chaos Monkey Alternatives - Azure][/alternatives/azure], [Chaos Monkey Alternatives - Google Cloud Platform][/alternatives/google-cloud-platform], and [Chaos Monkey Alternatives - Kubernetes][/alternatives/kubernetes] for many great options.

### Azure

Read through our [Chaos Monkey Alternatives - Azure][/alternatives/azure] chapter for guidance on how the Azure Search team created their own Search Chaos Monkey, along with implementing your own Chaos Engineering practices in Azure with Gremlin, WazMonkey, and Azure's Fault Analysis Service.

### Google Cloud Platform

Check out [Chaos Monkey Alternatives - Google Cloud Platform][/alternatives/google-cloud-platform] for details on using the simple Google Cloud Chaos Monkey tool, Gremlin's Failure as a Service, and the open-source Chaos Toolkit for injecting failure into your own Google Cloud Platform systems.

### Kubernetes

A quick read of our [Chaos Monkey Alternatives - Kubernetes][/alternatives/kubernetes] chapter will teach you all about the Kube Monkey, Kubernetes Pod Chaos Monkey, Chaos Toolkit, and Gremlin tools, which can be deployed on Kubernetes clusters to execute Chaos Experiments and create more resilient applications.

### On-Premise

In addition to the many tools features in the [Azure][/alternatives/azure], [Google Cloud Platform][/alternatives/google-cloud-platform], [Kubernetes][/alternatives/kubernetes], [Private Cloud][/alternatives/private-cloud], and [VMware][/alternatives/vmware] sections we're looking at a few network manipulation tools for injecting failure in your on-premise architecture.

#### Blockade

[Blockade](https://github.com/worstcase/blockade) is an open-source tool written in Python that creates various network failure scenarios within distributed applications.  Blockade uses Docker containers to perform actions and manage the network from the host system.

1. To get started with Blockade you'll need a Docker container image for Blockade to use.  We'll use `ubuntu:trusty` so make sure it's locally installed.

    ```bash
    sudo docker pull ubuntu:trusty
    ```

2. Install Blockade via `pip`.

    ```bash
    pip install blockade
    ```

3. Verify the installation with `blockade -h`.

    ```bash
    blockade -h
    ```

4. Blockade is configured via the `blockade.yml` file, which defines the containers and the respective commands that will be executed by that container.  These `command` values can be anything you'd like (such as running an app or service), but for this example, we're just performing a `ping` on port `4321` of the first container.

    ```bash
    nano blockade.yml
    ```

    ```yaml
    containers:
      c1:
        image: ubuntu:trusty
        command: /bin/sleep 300000
        ports: [4321]

      c2:
        image: ubuntu:trusty
        command: sh -c "ping $C1_PORT_4321_TCP_ADDR"
        links: ["c1"]

      c3:
        image: ubuntu:trusty
        command: sh -c "ping $C1_PORT_4321_TCP_ADDR"
        links: ["c1"]
    ```

5. To run Blockade and have it create the specified containers use the `blockade up` command.

    ```bash
    blockade up
    # OUTPUT
    NODE            CONTAINER ID    STATUS  IP              NETWORK    PARTITION  
    c1              dcb76a588453    UP      172.17.0.2      NORMAL
    c2              e44421cae80f    UP      172.17.0.4      NORMAL
    c3              de4510131684    UP      172.17.0.3      NORMAL
    ```

6. Blockade grabs the log output from each container, which can be viewed via `blockade logs <container>`.  Here we're viewing the last few lines of the `c2` log output, which shows it is properly pinging port `4321` on container `c1`.

    ```bash
    blockade logs c2 | tail
    # OUTPUT
    64 bytes from 172.17.0.2: icmp_seq=188 ttl=64 time=0.049 ms
    64 bytes from 172.17.0.2: icmp_seq=189 ttl=64 time=0.100 ms
    64 bytes from 172.17.0.2: icmp_seq=190 ttl=64 time=0.119 ms
    64 bytes from 172.17.0.2: icmp_seq=191 ttl=64 time=0.034 ms
    ```

7. Blockade comes with a handful of network manipulation commands, each of which can be applied to one or more containers.
  
    - `blockade duplicate <container1>[, <containerN>]`: Randomly generates duplicate packets.
    - `blockade fast <container>[, <containerN>]`: Reverts any previous modifications.
    - `blockade flaky <container>[, <containerN>]`: Randomly drops packets.
    - `blockade slow <container>[, <containerN>]`: Slows the network.
    - `blockade partition <container>[, <containerN>]`: Creates a network partition.

8. Run a test on `c2` to see how it impacts traffic.  Here we're slowing `c2`.

    ```bash
    blockade slow c2
    blockade logs c2 | tail
    ```

    ```bash
    # OUTPUT
    64 bytes from 172.17.0.2: icmp_seq=535 ttl=64 time=86.3 ms
    64 bytes from 172.17.0.2: icmp_seq=536 ttl=64 time=0.120 ms
    64 bytes from 172.17.0.2: icmp_seq=537 ttl=64 time=116 ms
    64 bytes from 172.17.0.2: icmp_seq=538 ttl=64 time=85.1 ms
    ```

    We can see that the network has been slowed significantly, causing (relatively) massive delays to the majority of our ping requests.

> info "Clean Up"
> If you need to clean up any containers created by Blockade just run the `blockade destroy` command.
> ```bash
> blockade destroy
> ```

Check out the [official documentation](https://blockade.readthedocs.io/en/latest/index.html) for more details on using Blockade.

#### Toxiproxy

[Toxiproxy](https://github.com/Shopify/toxiproxy) is an open-source framework written in Go for simulating network conditions within application code.  It is primarily intended for testing, continuous integration, and development environments, but it can be customized to support randomized Chaos Experiments.  Much of Toxiproxy's integration comes from open-source [client APIs](https://github.com/Shopify/toxiproxy#clients), which make it easy for Toxiproxy to integrate with a given application stack.

As an API within your application Toxiproxy can accomplish a lot of network simulations and manipulations, but this example shows how to use Toxiproxy to disconnect all Redis connections during a Rails application test.

1. (Optional) Create a Rails application.

    ```bash
    rails new toxidemo && cd toxidemo
    ```

2. Add the `toxiproxy` and `redis` gems to the `Gemfile`.

    ```ruby
    # Gemfile
    gem 'redis'
    gem 'toxiproxy'
    ```

3. Install all gems.

    ```bash
    bundle install
    ```

4. Scaffold a new `Post` model in Rails.

    ```bash
    rails g scaffold Post tags:string
    ```

5. For this test, we need to map both listener and upstream Redis ports for Toxiproxy.  Add this to `config/boot.rb` to ensure it executes before connections are established.

    ```ruby
    # config/boot.rb
    require 'toxiproxy'

    Toxiproxy.populate([
      {
        name: "toxiproxy_test_redis_tags",
        listen: "127.0.0.1:22222",
        upstream: "127.0.0.1:6379"
      }
    ])
    ```

6. To create the `TagRedis` proxied instance we need to add the following to `config/environment/test.rb` so it is only created during test executions.

    ```ruby
    # config/environment/test.rb
    TagRedis = Redis.new(port: 22222)
    ```

7. Add the following methods to `app/models/post.rb`, which explicitly calls the proxied `TagRedis` instance that is created above.

    ```ruby
    # app/models/post.rb
    def tags
      TagRedis.smembers(tag_key)
    end

    def add_tag(tag)
      TagRedis.sadd(tag_key, tag)
    end

    def remove_tag(tag)
      TagRedis.srem(tag_key, tag)
    end

    def tag_key
      "post:tags:#{self.id}"
    end
    ```

8. Add the following test to `test/models/post_test.rb`.

    ```ruby
    setup do
      @post = posts(:one)
    end

    test "should return empty array when tag redis is down while listing tags" do
      @post.add_tag "gremlins"

      Toxiproxy[/redis/].down do
        assert_equal [], @post.tags
      end
    end
    ```

9. Migrate the database for the first time if you haven't done so.

    ```bash
    rails db:migrate
    ```

10. Open a second terminal window and start the Toxiproxy server so it'll listen for connections.

    ```bash
    toxiproxy-server
    # OUTPUT
    INFO[0000] API HTTP server starting    host=localhost port=8474 version=2.1.3
    ```

11. Now run our test with `rake test`.  You should see the `Redis::CannotConnectError` reported from Rails.

    ```bash
    # OUTPUT
    Error:
    PostTest#test_should_return_empty_array_when_tag_redis_is_down_while_listing_tags:
    Redis::CannotConnectError: Error connecting to Redis on 127.0.0.1:22222 (Errno::ECONNREFUSED)
    ```

    This is because Toxiproxy successfully closed the Redis connection during the test.  Looking at the output from the `toxiproxy-server` window confirms this.

    ```bash
    # OUTPUT
    INFO[0108] Started proxy                                 name=toxiproxy_test_redis_tags proxy=127.0.0.1:22222 upstream=127.0.0.1:6379
    INFO[0110] Accepted client                               client=127.0.0.1:49958 name=toxiproxy_test_redis_tags proxy=127.0.0.1:22222 upstream=127.0.0.1:6379
    INFO[0110] Terminated proxy                              name=toxiproxy_test_redis_tags proxy=127.0.0.1:22222 upstream=127.0.0.1:6379
    WARN[0110] Source terminated                             bytes=4 err=read tcp 127.0.0.1:51080->127.0.0.1:6379: use of closed network connection name=toxiproxy_test_redis_tags
    WARN[0110] Source terminated                             bytes=54 err=read tcp 127.0.0.1:22222->127.0.0.1:49958: use of closed network connection name=toxiproxy_test_redis_tags
    INFO[0110] Started proxy                                 name=toxiproxy_test_redis_tags proxy=127.0.0.1:22222 upstream=127.0.0.1:6379
    INFO[0110] Accepted client                               client=127.0.0.1:49970 name=toxiproxy_test_redis_tags proxy=127.0.0.1:22222 upstream=127.0.0.1:6379
    WARN[0110] Source terminated                             bytes=163 err=read tcp 127.0.0.1:51092->127.0.0.1:6379: use of closed network connection name=toxiproxy_test_redis_tags
    ```

12. In this simple example this test can pass by altering the `app/models/post.rb#tags` method to rescue the `Redis::CannotConnectError`.

    ```ruby
    # app/models/post.rb
    def tags
      TagRedis.smembers(tag_key)
    rescue Redis::CannotConnectError
      []
    end
    ```

Check out this [Shopify blog post](https://shopifyengineering.myshopify.com/blogs/engineering/building-and-testing-resilient-ruby-on-rails-applications) and the [official repository](https://github.com/Shopify/toxiproxy) for more information on setting up and using Toxiproxy in your own architecture.

### OpenStack

As software for data center management [OpenStack](https://www.openstack.org) can universally employ virtually any infrastructure-based Chaos tool we've already covered.  Additionally, the [OS-Faults](https://github.com/openstack/os-faults) tool is an open-source library developed by the OpenStack team and written in Python that is designed to perform destructive actions within an OpenStack cloud.  Actions are defined using technology- and platform-specific [drivers](https://os-faults.readthedocs.io/en/latest/drivers.html).  There are currently drivers for nearly every aspect of OpenStack's architecture including drivers for the cloud, power management, node discovering, services, and containers.

While using OpenStack will depend heavily on your particular use case, below is one example showing the basics to get started.

1. Install OS-Faults via `pip`.

    ```bash
    pip install os-faults
    ```

2. Configuration is read from a JSON or YAML file (`os-faults.{json,yaml,yml}`).  Here we'll create the `/etc/os-faults.yml` file and paste the following inside.

    ```yaml
    cloud_management:
      driver: devstack
      args:
        address: 192.168.1.10
        username: ubuntu
        password: password
        private_key_file: ~/.ssh/developer
        slaves:
        - 192.168.1.11
        iface: eth1

    power_managements:
    - driver: libvirt
      args:
        connection_uri: qemu+unix:///system
    ```

    The `cloud_management` block contains just a single driver to be used, with relevant args such as the IP and credentials.  The `power_managements` block can contain a list of drivers.  

3. Now inject some failure by using the [command line API](https://os-faults.readthedocs.io/en/latest/cli.html).  Here we're performing a simple restart of the `redis` service.

    ```bash
    os-inject-fault restart redis service
    ```

    > info ""
    > You may need to specify the location of your configuration file by adding the `-c <config-path>` flag to CLI commands.

That's all there is to it.  OS-Faults is capable of many types of Chaos Experiments including disconnecting nodes, overloading IO and memory, restarting and killing services/nodes, and much more.  The [official documentation](https://os-faults.readthedocs.io/en/latest/index.html) has more details.

### Private Cloud

Take a look at the [Chaos Monkey Alternatives - Private Cloud][/alternatives/private-cloud] chapter to see how to begin Chaos Engineering within your own private cloud architecture using GomJabbar, Gremlin, and Muxy.

### VMware

Check out the [Chaos Monkey Alternatives - VMware][/alternatives/vmware] chapter to learn about the Chaos Lemur tool and Gremlin's own Failure as a Service solution, both of will inject failure into your VMware and other BOSH-managed virtual machines with relative ease.

## Java

The tools you choose for implementing Chaos Engineering in Java will primarily be based on the technologies of your system architecture.  However, in addition to the [Maven][/alternatives#maven] and [Spring Boot][/alternatives/spring-boot] tools discussed below, you may also consider [Namazu](https://github.com/osrg/namazu), which is an open-source fuzzy scheduler for testing distributed system implementations.  Via a pseudo-randomized schedule, Namazu can attack the filesystem and IO, network packets, and Java function calls.

Namazu can be installed locally or via a Docker container.  Additionally, the [Namazu Swarm](https://github.com/osrg/namazu-swarm) plugin allows multiple jobs to be paralleled via Docker swarms or Kubernetes clusters.

Check out the official GitHub [repository](https://github.com/osrg/namazu) for more details on Chaos Engineering your Java applications with Nazamu.

### Maven

Since Maven is a build automation tool for Java applications performing Chaos Experiments in Maven-based projects is as easy as utilizing one of the Java-related Chaos Engineering tools we've detailed elsewhere.  Check out our guides for [Chaos Monkey for Spring Boot][/alternatives/spring-boot#chaos-monkey], [Gremlin][/alternatives/spring-boot#gremlin], [Fabric8][/alternatives/spring-boot#fabric8], and [Chaos Lemur][/alternatives/vmware#chaos-lemur] for some ways to inject failure in Maven- and Java-based systems.

### Spring Boot

Exploring our [Chaos Monkey Alternatives - Spring Boot][/alternatives/spring-boot] chapter will teach you about how to use Chaos Monkey for Spring Boot, Gremlin, and Fabric8 to execute Chaos Experiments against your Spring Boot applications.

## OS

Regardless of the operating system you're using there is a slew of Chaos Monkey alternative technologies.  Check out the notable selections in the [Linux][/alternatives#linux] and [Windows][/alternatives#windows] sections below for some quick tools to get your Chaos Engineering kicked into high gear.

### Linux

Performing Chaos Engineering on Linux is a match made in heaven -- virtually every tool we've explored here in the [Alternatives][/alternatives] chapter and listed in our [Resources - Tools][/downloads-resources#tools] section was designed for if not built with Unix/Linux.

Some standout alternatives for Linux include [The Chaos Toolkit][/alternatives/kubernetes#chaos-toolkit] on Kubernetes, [Gremlin's Failure as a Service][#gremlin-failure-as-a-service] on nearly every platform, [Pumba][/alternatives/docker#pumba] on Docker, and [Chaos Lemur][/alternatives/vmware#chaos-lemur] on BOSH-managed platforms.

### Windows

Like Linux, Windows Chaos Engineering depends on the platforms and architecture your organization is using.  Much of the software we've covered in [Resources - Tools][/downloads-resources#tools] and this entire [Alternatives][/alternatives] chapter can be applied to Windows-based systems.

Some particularly useful Chaos Monkey alternatives for Windows are the [Fault Analysis Service][/alternatives/azure#fault-analysis-service] for Azure Service Fabric, Gremlin's [Failure as a Service][#gremlin-installation-docker] for Docker, and [Muxy][/alternatives/private-cloud#muxy] for private cloud infrastructures.

{% include nav-internal.md %}