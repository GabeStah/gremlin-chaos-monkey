---
title: "Chaos Monkey Alternatives - Private Cloud"
description: "Explores Chaos Monkey alternative technologies on Private Cloud systems."
date: 2018-08-30
path: "/chaos-monkey/alternatives/private-cloud"
url: "https://www.gremlin.com/chaos-monkey/alternatives/private-cloud"
sources: "See: _docs/resources.md"
published: true
---

## GomJabbar

[GomJabbar](https://github.com/outbrain/GomJabbar) is an open-source implementation of Chaos Monkey written in Java and designed to perform attacks within a private cloud architecture.  Attacks are defined through the YAML configuration file and are executed as plain shell commands (e.g. `sudo service ${module} stop`).  It also integrates with [Ansible](https://docs.ansible.com/ansible/latest/index.html) and [Rundeck](https://rundeck.org/).

Attacks are defined in the `config.yaml` within the `commands` block.  The `fail` value is the fault command to be executed, while the (optional) `revert` value is executed to attempt reversion.  For example, here the `shutdown_service` command calls `sudo service <service-name> stop` as a fault and the opposite to revert.

```yaml
commands:
  kill_service:
    description: "Kills services."
    fail: "sudo pkill -s 9 -f ${module}"
    revert: "sudo service ${module} start"

  shutdown_service:
    description: "Shuts down services."
    fail: "sudo service ${module} stop"
    revert: "sudo service ${module} start"
```

The `filters` block in `config.yaml` defines a list of `clusters`, `modules`, and `tags` to either be whitelisted or blacklisted via `include` or `exclude`, respectively.

```yaml
filters:
  clusters:
    include:
      - gremlin-chaos
    exclude:
      - grandmas-cluster

  modules:
    include:
      - nginx
      - redis-server
    exclude:
      - critical

  tags:
    include:
      - development
      - production
    exclude:
      - test
```

As we saw in the `commands` block above `${module}` can be referenced in fault commands and will automatically be replaced with the relevant service name.  Once configured you can start the server by exporting the generated `GJ_OPTIONS` and calling the `gomjabbar.sh` script.

```bash
export GJ_OPTIONS="-Dcom.outbrain.gomjabbar.configFileUrl=<config file url> ..."
./gomjabbar.sh
```

You can then use the [REST API](https://github.com/outbrain/GomJabbar/blob/master/docs/user-guide.md#rest-api) to trigger attacks and revert faults.

## Failure Injection on Your Private Cloud with Gremlin

Gremlin's [Failure as a Service][#gremlin-failure-as-a-service] locates weaknesses in your private cloud architecture before they cause problems.  Gremlin makes Chaos Engineering simple, safe, and secure, improving your private cloud's stability and resilience.  You can begin executing Chaos Experiments in just a few minutes by [signing up][#gremlin-account-signup] for an account and [installing Gremlin][#gremlin-installation].  Gremlin can perform a variety of attacks against every major type of private cloud infrastructure including Linux, Docker, Kubernetes, OpenStack, VMware, and many more.

Check out [these tutorials][#gremlin-installation] to learn how to install Gremlin and start Chaos Engineering your private cloud today.

## Muxy

[Muxy](https://github.com/mefellows/muxy) is an open-source tool written in Go that allows you to tamper with network traffic at the transport, TCP, or HTTP protocol layers of your systems.  In can simulate real-world network connectivity problems and can also be extended with plugins via the [Plugo](https://github.com/mefellows/plugo) interface.

Muxy is configured through a YAML file that defines a number of `proxy` and `middleware` blocks.  

1. Start by installing Muxy with `go get`.

    ```bash
    go get github.com/mefellows/muxy
    ```

2. Create a YAML file and paste the following test configuration in it.

    ```yaml
    # gremlin.yml
    proxy:
      - name: http_proxy
        config:
          host: 0.0.0.0
          port: 8181
          proxy_host: www.gremlin.com
          proxy_port: 443

    # Proxy plugins
    middleware:
      - name: http_tamperer
        config:
          request:
            host: www.gremlin.com
            port: 443

      # Message Delay request/response plugin
      - name: delay
        config:
          request_delay:  2500
          response_delay: 2500

      # Log in/out messages
      - name: logger
    ```

    This configuration creates a `localhost:8181` proxy that targets `www.gremlin.com:443`.  It also creates an `http_tamperer` middleware that catches requests made to `www.gremlin.com:443` and adds a `2.5-second` delay to both requests and responses.  Finally, it outputs Muxy messages to the default terminal logger.

3. Start Muxy with the following command, ensuring that you specify the location of the YAML configuration file.

    ```bash
    muxy proxy --config ./gremlin.yml
    ```

    ```bash
    # OUTPUT
    2018/09/18 22:47:39.179395 [INFO]		Loading plugin 	http_tamperer
    2018/09/18 22:47:39.179415 [INFO]		Loading plugin 	delay
    2018/09/18 22:47:39.179419 [INFO]		Loading plugin 	logger
    2018/09/18 22:47:39.179451 [INFO]		Loading proxy 	http_proxy
    2018/09/18 22:47:39.179465 [DEBUG]		HTTP Tamperer Setup()
    2018/09/18 22:47:39.179476 [DEBUG]		Delay Symptom - Setup()
    2018/09/18 22:47:39.179578 [INFO]		HTTP proxy listening on http://0.0.0.0:8181
    ```

4. Now that Muxy is listening at `http://0.0.0.0:8181` you can make a request to `www.gremlin.com` through the proxy to test it out.  Muxy should add a delay of approximately 5 seconds to the request.

    ```bash
    time curl -H"Host: www.gremlin.com" http://localhost:8181/
    ```

    ```bash
    # OUTPUT
    real	0m5.070s
    user	0m0.000s
    sys	0m0.004s
    ```

5. Now try the same timed test but without passing through the `localhost:8181` proxy, and you'll see Muxy doesn't catch or *muck* with this request.

    ```bash
    time curl -o /dev/null https://www.gremlin.com
    ```

    ```bash
    # OUTPUT
    real	0m0.257s
    user	0m0.036s
    sys	0m0.012s
    ```

Check out the [official Muxy documentation](https://github.com/mefellows/muxy/) for more information on integrating Muxy into your private cloud Chaos Engineering.

{% include nav-internal.md %}