---
title: "Chaos Monkey Alternatives - Docker"
description: "Explores Chaos Monkey alternative technologies using Docker."
date: 2018-08-30
path: "/chaos-monkey/alternatives/docker"
url: "https://www.gremlin.com/chaos-monkey/alternatives/docker"
sources: "See: _docs/resources.md"
published: true
outline: "
  - URL: `https://www.gremlin.com/chaos-monkey/alternatives/docker`
  - Parent: `Category Section: Containers`
  - Content:
    - `Overview`: _See above._
    - [`docker-chaos-monkey`](https://github.com/titpetric/docker-chaos-monkey): Overview of the `docker-chaos-monkey` tool for implementing Chaos Monkey systems within a `Docker Swarm`.
    - [`docker-simianarmy`](https://github.com/mlafeldt/docker-simianarmy): A simple `Docker` image of the Simian Army toolset.
    - [`pumba`](https://github.com/alexei-led/pumba): A CLI chaos testing and network emulation tool for `Docker` that uses Linux kernel traffic controls to handle underlying network commands.
"
---

## Docker Chaos Monkey

[Docker Chaos Monkey](https://github.com/titpetric/docker-chaos-monkey) is a simple shell script that terminates [Docker Swarm](https://docs.docker.com/engine/swarm/) [services](https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/).  Targetable services are specified by applying the `role=disposable` label.

```bash
docker service create -l role=disposable --name gremlin gremlin/gremlin
```

The script kills off the first Docker image with the `role=disposable` label that also meets the following criteria:

- Must have more than `1` replica.
- *Actual* and *desired* replica counts must be equal.

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
hsn3ezlkqow7  gremlin   replicated  2/2             gremlin/gremlin:latest
jam29chanegg  gremlin2  replicated  1/1             gremlin/gremlin:latest
----------------------------------------------------------------------------

hsn3ezlkqow7 gremlin: swarm1
removing a container
> gremlin.2.zecjcxha6zbr0bpfqb017v8vb

jam29chanegg gremlin2: service has only one running container - skipping
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

Add the `-d -p 8080:8080` flag to forward port `8080` and connect to the SimianArmy REST API.

## Pumba

[Pumba](https://github.com/alexei-led/pumba) is a powerful Chaos testing tool for injecting Chaos in Docker.  It can kill, pause, stop, and remove Docker containers with highly-configurable selection rules.  It can also perform network emulation through delays, packet loss, rate limiting, and more.

Get started by downloading the [latest binary release](https://github.com/alexei-led/pumba/releases) and making it executable.

```bash
sudo curl -L https://github.com/alexei-led/pumba/releases/download/0.5.2/pumba_linux_amd64 -o /usr/bin/pumba &&
sudo chmod +x /usr/bin/pumba
```

*(Optional)* Create a Docker container.

```bash
docker run -l service=nginx --name nginx -p 80:80 -d nginx
docker container ls
```

```bash
# OUTPUT
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
b9df13525a13        nginx               "nginx -g 'daemon of…"   4 minutes ago       Up 4 minutes        0.0.0.0:80->80/tcp   nginx
```

Execute Pumba commands to start experimenting.  Here we're killing a random container every 30 seconds (`--dry-run` only simulates the process; remove it to actually kill).

```bash
pumba -l info --random --dry-run --interval 30s kill
INFO[0000] killing container  app=pumba dryrun=true function=github.com/alexei-led/pumba/pkg/container.dockerClient.KillContainer id=b9df13525a139d9a4a55a249b9cff37ba4656b72b4971fbc1f85d93058f2770d name=/nginx signal=SIGKILL source=container/client.go:115
```

{% include nav-internal.md %}