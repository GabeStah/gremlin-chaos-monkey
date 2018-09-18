---
title: "Chaos Monkey Alternatives - Private Cloud"
description: "Explores Chaos Monkey alternative technologies on Private Cloud systems."
date: 2018-08-30
path: "/chaos-monkey/alternatives/private-cloud"
url: "https://www.gremlin.com/chaos-monkey/alternatives/private-cloud"
sources: "See: _docs/resources.md"
published: true
outline: "
- URL: `https://www.gremlin.com/chaos-monkey/alternatives/private-cloud`
- Parent: `Category Section: Infrastructure`
- Content:
  - `Overview`: _See above._
  - [`GomJabbar`](https://github.com/outbrain/GomJabbar): Detail the `GomJabbar` service, aimed at providing Chaos Monkey-like services and tools within a private cloud architecture.
- Competition:
  - https://github.com/outbrain/GomJabbar
  - https://www.outbrain.com/techblog/2017/06/failure-testing-for-your-private-cloud-introducing-gomjabbar/
  - https://next.nutanix.com/blog-40/chaos-monkey-for-the-enterprise-cloud-27781
"
---

## GomJabbar

[GomJabbar](https://github.com/outbrain/GomJabbar) is an open-source implementation of Chaos Monkey written in Java and designed to perform attacks within private cloud architecture.  Attacks are defined through the YAML configuration file and are executed as plain shell commands (e.g. `sudo service ${module} stop`).  It also integrates with [Ansible](https://docs.ansible.com/ansible/latest/index.html) and [Rundeck](https://rundeck.org/).

Attacks are defines in the `config.yaml` in the `commands` block.  The `fail` value is the fault command to be executed, while the (optional) `revert` value is executed to attempt reversion.  For example, here the `shutdown_service` command calls `sudo service <service-name> stop` as a fault and the opposite to revert.

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

The `filters` block in `config.yaml` defines a list of `clusters`, `modules`, and `tags` to either be whitelisted or blacklisted (i.e. via `include` or `exclude`).

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



{% include nav-internal.md %}