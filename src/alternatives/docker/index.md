---
title: "Chaos Monkey Alternatives - Docker"
description: "Explores Chaos Monkey alternative technologies using Docker."
path: "/chaos-monkey/alternatives/docker"
url: "https://www.gremlin.com/chaos-monkey/alternatives/docker"
sources: "See: _docs/resources.md"
published: true
redirect_to: https://www.gremlin.com/chaos-monkey/chaos-monkey-alternatives/docker/
---

## Pumba

[Pumba](https://github.com/alexei-led/pumba) is a powerful Chaos testing tool for injecting Chaos in Docker.  It can kill, pause, stop, and remove Docker containers with highly-configurable selection rules.  It can also perform network emulation through delays, packet loss, rate limiting, and more.

Get started by downloading the [latest binary release](https://github.com/alexei-led/pumba/releases) and setting its permissions.

```bash
sudo curl -L https://github.com/alexei-led/pumba/releases/download/0.5.2/pumba_linux_amd64 -o /usr/bin/pumba &&
sudo chmod +x /usr/bin/pumba
```

> note "Execute Pumba Within a Container"
> If you'd prefer to run Pumba from within a Docker container, you can preface your Pumba command with the following.  This creates a temporary container using the [`gaiaadm/pumba`](https://hub.docker.com/r/gaiaadm/pumba/) image.  The `-v` flag bind-mounts the local `docker.sock` file to the same path in the container, so Pumba can connect to the Docker daemon.  The `--rm` flag makes the container temporary and `-it` creates an interactive shell so we can pass the `pumba` command that follows.
> ```bash
> docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba \
> <PUMBA_COMMAND>
> ```

### Killing a Random Container

1. Create a Docker container.

    ```bash
    docker run -l service=nginx --name nginx -p 80:80 -d nginx
    docker container ls
    ```

    ```bash
    # OUTPUT
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
    b9df13525a13        nginx               "nginx -g 'daemon of…"   4 minutes ago       Up 4 minutes        0.0.0.0:80->80/tcp   nginx
    ```

2. This command attempts to kill a random container every 30 seconds.  The `--dry-run` flag *simulates* the result, so remove it to perform actual killings.

    ```bash
    pumba -l info --random --dry-run --interval 30s kill
    INFO[0000] killing container  app=pumba dryrun=true function=github.com/alexei-led/pumba/pkg/container.dockerClient.KillContainer id=b9df13525a139d9a4a55a249b9cff37ba4656b72b4971fbc1f85d93058f2770d name=/nginx signal=SIGKILL source=container/client.go:115
    ```

### Network Emulation

Pumba uses the `tc` utility for performing network emulation, which is typically installed with the [`iproute2`](https://wiki.linuxfoundation.org/networking/iproute2) tool set.  We'll be creating containers using [Alpine Linux](https://alpinelinux.org/) distributions in these samples, but make sure your own container images contain a copy of the `tc` utility when performing network emulations.

#### Causing Delays

1. Issue the following command to create a container named `networker`.  This ensures `iproute2` is up to date and performs a ping on `google.com` for testing.

    ```bash
    docker run --rm --name networker -it alpine sh -c "apk add --update iproute2 && ping google.com"
    ```

    ```bash
    # OUTPUT
    fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/APKINDEX.tar.gz
    fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/community/x86_64/APKINDEX.tar.gz
    (1/6) Installing libelf (0.8.13-r3)
    (2/6) Installing libmnl (1.0.4-r0)
    (3/6) Installing jansson (2.11-r0)
    (4/6) Installing libnftnl-libs (1.1.1-r0)
    (5/6) Installing iptables (1.6.2-r0)
    (6/6) Installing iproute2 (4.13.0-r0)
    Executing iproute2-4.13.0-r0.post-install
    Executing busybox-1.28.4-r1.trigger
    OK: 8 MiB in 19 packages
    PING google.com (172.217.3.174): 56 data bytes
    64 bytes from 172.217.3.174: seq=0 ttl=127 time=8.992 ms
    64 bytes from 172.217.3.174: seq=1 ttl=127 time=9.965 ms
    64 bytes from 172.217.3.174: seq=2 ttl=127 time=10.332 ms
    ```

2. Open a second terminal and issue the following command to cause a `5000` millisecond `delay` over a total of `15` seconds.

    ```bash
    pumba -l info netem --duration 15s delay --time 5000 networker
    ```

    ```bash
    # TERMINAL 2: OUTPUT
    INFO[0000] Running netem command '[delay 5000ms 10ms 20.00]' on container 2a4066e2865ed24464fa458982374795d62df11b0368e0886f77fc62cdc47664 for 15s  app=pumba function=github.com/alexei-led/pumba/pkg/container.dockerClient.NetemContainer source=container/client.go:220
    INFO[0000] start netem for container                     app=pumba dryrun=false function=github.com/alexei-led/pumba/pkg/container.dockerClient.startNetemContainer id=2a4066e2865ed24464fa458982374795d62df11b0368e0886f77fc62cdc47664 iface=eth0 name=/networker netem=delay 5000ms 10ms 20.00 source=container/client.go:276 tcimage=
    INFO[0015] stopping netem on container                   IPs=[] app=pumba dryrun=false function=github.com/alexei-led/pumba/pkg/container.dockerClient.StopNetemContainer id=2a4066e2865ed24464fa458982374795d62df11b0368e0886f77fc62cdc47664 iface=eth0 name=/networker source=container/client.go:240 tc-image=
    INFO[0015] stop netem for container                      IPs=[] app=pumba dryrun=false function=github.com/alexei-led/pumba/pkg/container.dockerClient.stopNetemContainer id=2a4066e2865ed24464fa458982374795d62df11b0368e0886f77fc62cdc47664 iface=eth0 name=/networker source=container/client.go:298 tcimage=
    ```

    ```bash
    # TERMINAL 1: OUTPUT
    64 bytes from 172.217.3.174: seq=509 ttl=127 time=9.638 ms
    64 bytes from 172.217.3.174: seq=512 ttl=127 time=5013.608 ms
    64 bytes from 172.217.3.174: seq=514 ttl=127 time=5011.516 ms
    64 bytes from 172.217.3.174: seq=510 ttl=127 time=9299.192 ms
    64 bytes from 172.217.3.174: seq=511 ttl=127 time=9297.367 ms
    64 bytes from 172.217.3.174: seq=516 ttl=127 time=5011.184 ms
    64 bytes from 172.217.3.174: seq=513 ttl=127 time=9301.741 ms
    64 bytes from 172.217.3.174: seq=518 ttl=127 time=5016.096 ms
    64 bytes from 172.217.3.174: seq=519 ttl=127 time=5014.941 ms
    64 bytes from 172.217.3.174: seq=515 ttl=127 time=9304.069 ms
    64 bytes from 172.217.3.174: seq=527 ttl=127 time=10.468 ms
    ```

#### Dropping Packets

1. Issue the following command to create a container named `networker` and have it start downloading a fairly large file via `curl`.

    ```bash
    docker run --rm --name networker -it alpine sh -c "apk add --update iproute2 && apk add --update curl && curl -O http://ubuntu-releases.eecs.wsu.edu/18.04.1/ubuntu-18.04.1-desktop-amd64.iso"
    ```

    ```bash
    # TERMINAL 1: OUTPUT
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                    Dload  Upload   Total   Spent    Left  Speed
    8 1862M    8  155M    0     0  9698k      0  0:03:16  0:00:16  0:03:00 11.4M
    ```

2. Open a second terminal and issue the `loss` command, which will drop `25%` of all packets for the next `2` minutes.

    ```bash
    pumba netem --duration 2m loss --percent 10 networker
    ```

    You should notice the packet loss affecting the `curl` download -- in this case, roughly halving download speeds.

    ```bash
    # TERMINAL 1: OUTPUT
     % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                    Dload  Upload   Total   Spent    Left  Speed
    13 1862M   13  259M    0     0  7403k      0  0:04:17  0:00:35  0:03:42 5807k
    ```

## Injecting Failure Into Docker with Gremlin

Gremlin's [Failure as a Service][#gremlin-failure-as-a-service] platform makes it easy to run Chaos Experiments on Docker containers.  You can start running experiments in just a few minutes after installing Docker.  Once installed, Gremlin is intelligent enough to recognize each of your unique Docker containers and will accurately apply smart identifier tags, so you can target exactly the right services and systems.  Gremlin can perform a variety of attacks against Docker containers including killing containers, manipulating network traffic, overloading CPU/memory/disk/IO, and much more.

Check out [this tutorial](https://help.gremlin.com/install-gremlin-docker-ubuntu-1604/) to learn how to install Gremlin on Ubuntu and attack Docker containers.  Alternatively, [this guide](https://help.gremlin.com/install-gremlin-docker-container-ubuntu-1604/) shows how to install Gremlin within a Docker container for use against other containers.

## Docker Chaos Monkey

[Docker Chaos Monkey](https://github.com/titpetric/docker-chaos-monkey) is a simple shell script that terminates [Docker Swarm](https://docs.docker.com/engine/swarm/) [services](https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/).  Targetable services are specified by applying the `role=disposable` label.

```bash
docker service create -l role=disposable --name nginx nginx:stable
```

The script kills off the first Docker image with the `role=disposable` label that also meets the following criteria:

- Must have more than `1` replica.
- *Actual* and *desired* replica counts must be equivalent.

Here it is in action.

```bash
./chaos.sh
```

```bash
# OUTPUT
----------------------------------------------------------------------------
| Running this script will kill off 1 docker image with label: role=disposable
| You have 5 seconds to change your mind and CTRL+C out of this.
----------------------------------------------------------------------------
hsn3ezlkqow7  nginx   replicated  2/2                           nginx:stable
jam29chanegg  nginx2  replicated  1/1                           nginx:stable
----------------------------------------------------------------------------

hsn3ezlkqow7 nginx: swarm1
removing a container
> nginx.2.zecjcxha6zbr0bpfqb017v8vb

jam29chanegg nginx2: service has only one running container - skipping
```

## Docker Simian Army

The [Docker Simian Army](https://github.com/mlafeldt/docker-simianarmy) is a Docker image of the [Simian Army][/simian-army] Java toolset.  It doesn't provide any additional features on its own, but it's a useful alternative to installing the Simian Army locally.  You can test it out in **dry** mode with the following command.

```bash
docker run -d \
    -e SIMIANARMY_CLIENT_AWS_ACCOUNTKEY=$AWS_ACCESS_KEY_ID \
    -e SIMIANARMY_CLIENT_AWS_SECRETKEY=$AWS_SECRET_ACCESS_KEY \
    -e SIMIANARMY_CLIENT_AWS_REGION=$AWS_REGION \
    -e SIMIANARMY_CALENDAR_ISMONKEYTIME=true \
    -e SIMIANARMY_CHAOS_ASG_ENABLED=true \
    mlafeldt/simianarmy
```

Add the `-d -p 8080:8080` flag to forward port `8080` and connect to the Simian Army [REST API](https://github.com/Netflix/SimianArmy/wiki/REST).

{% include nav-internal.md %}