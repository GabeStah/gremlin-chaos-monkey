---
title: "Chaos Monkey Alternatives - OpenShift"
description: "Explores Chaos Monkey alternative technologies using OpenShift."
date: 2018-08-30
path: "/chaos-monkey/alternatives/openshift"
url: "https://www.gremlin.com/chaos-monkey/alternatives/openshift"
sources: "See: _docs/resources.md"
published: true
outline: "
- URL: `https://www.gremlin.com/chaos-monkey/alternatives/openshift`
- Parent: `Category Section: Infrastructure`
- Content:
  - `Overview`: _See above._
  - [`monkey-ops`](https://github.com/Produban/monkey-ops): Describe how the `monkey-ops` service can be used to perform Chaos Engineering tasks inside an [`OpenShift`](https://www.openshift.com/) container application.
- Competition:
  - https://github.com/Produban/monkey-ops
- Services (for Gremlin?):
  - https://docs.openshift.com/online/dev_guide/integrating_external_services.html
  - https://docs.openshift.com/online/architecture/core_concepts/pods_and_services.html#services
"
---

## Monkey-Ops

[Monkey-Ops](https://github.com/Produban/monkey-ops) is an open-source Chaos Monkey implementation written in Go and designed to be deployed alongside an OpenShift application.  Monkey-Ops will randomly perform one of two possible attacks:

  - Delete a random pod by calling the [`DELETE /api/v1/namespaces/{namespace}/pods`](https://docs.openshift.com/container-platform/3.6/rest_api/kubernetes_v1.html#delete-collection-of-pod) Kubernetes API endpoint.
  - Scale the number of replicas for the associated deployment config by calling the [`PUT /oapi/v1/namespaces/{namespace}/deploymentconfigs/{name}/scale`](https://docs.openshift.com/container-platform/3.6/rest_api/openshift_v1.html#replace-scale-of-the-specified-scale) OpenShift API endpoint.

You can install Monkey-Ops either via Docker or as a separate OpenShift project.

### Docker Installation

Create a Docker container with the following command.  Be sure to replace `TOKEN` with your own OpenShift auth token and `PROJECT_NAME` with the appropriate value.

```bash
docker run produban/monkey-ops /monkey-ops \
  --TOKEN="_uAGahsDihxorIVxQvasmiTRbijJCbwj1toFD0ifWw" \
  --PROJECT_NAME="chaos-demo" \
  --API_SERVER="https://api.starter-us-west-2.openshift.com:443" \
  --INTERVAL=30 \
  --MODE="background"
```

This will randomly execute one of the two possible attacks every `INTERVAL` seconds.  If you wish to have more control over attacks, change `MODE` to `"rest"` and use the [`/chaos` REST API](https://github.com/Produban/monkey-ops#api-rest) to launch an attack.

### OpenShift Installation

Installing Monkey-Ops as an OpenShift project is a bit more complex.

1. Clone the Git repo to a local directory.

    ```bash
    git clone https://github.com/Produban/monkey-ops.git
    ```

2. Create a `monkey-ops.json` file and paste the following, which will be used to create a Service Account.

    ```json
    {
      "apiVersion": "v1",
      "kind": "ServiceAccount",
      "metadata": {
        "name": "monkey-ops"
      }
    }
    ```

3. Create the OpenShift Service Account using the [OpenShift CLI](https://docs.okd.io/latest/cli_reference/get_started_cli.html) and grant it privileges for your project (e.g. `chaos-demo`).

    ```bash
    oc create -f monkey-ops.json && oc policy add-role-to-user edit system:serviceaccount:chaos-demo:monkey-ops
    ```

4. Now create a new pod using the `monkey-ops-template.yaml` found in the Monkey-Ops project.

    ```bash
    oc create -f ./openshift/monkey-ops-template.yaml -n chaos-demo
    ```

5. Finally, create a new app called `monkey-ops` and pass appropriate values for each `PARAM` indicating when and how attacks will be executed.

    ```bash
    oc new-app \
      --name=monkey-ops \
      --template=monkey-ops \
      --param APP_NAME=monkey-ops \
      --param INTERVAL=30 \
      --param MODE=background \
      --param TZ=America/Los_Angeles \
      --labels=app_name=monkey-ops -n chaos-demo
    ```

## Engineering Chaos In OpenShift with Gremlin

Gremlin's [Failure as a Service][#gremlin-failure-as-a-service] simplifies your Chaos Engineering workflow for OpenShift by making it safe and effortless to execute Chaos Experiments across all application containers.  As a distributed architecture OpenShift is particularly sensitive to instability and unexpected failures.  Gremlin can perform a variety of attacks on your OpenShift applications including overloading CPU, memory, disk, and IO; killing pods; modifying network traffic; and much more.

Check out [this tutorial](https://help.gremlin.com/install-gremlin-centos-7/) for installing Gremlin on Centos to get started!

## Pumba

As discussed in the [Chaos Monkey Alternatives - Docker][/alternatives/docker#pumba] chapter, [Pumba](https://github.com/alexei-led/pumba) is a Chaos injection tool primarily built for Docker.  However, it can also be deployed on [Kubernetes](https://github.com/alexei-led/pumba/blob/master/deploy/pumba_kube.yml) and, by extension, on [OpenShift](https://github.com/alexei-led/pumba/blob/master/deploy/pumba_openshift.yml) using a DaemonSets.  Pumba can stop, pause, kill, and remove containers, which means it works fairly well with OpenShift pods that are made up of one or more containers.

1. To deploy Pumba in OpenShift nodes using a DaemonSet you must first add a security policy to allow the OpenShift `developer` user to administer Kubernetes clusters.

    ```bash
    oc adm policy --as system:admin add-cluster-role-to-user cluster-admin developer
    ```

2. Add the `privileged` security context restraint to the `default` user for your project.

    ```bash
    oc adm policy add-scc-to-user privileged system:serviceaccount:<project>:default
    ```

3. Set the `allowHostDirVolumePlugin` option to `true` in the `restricted` security restraint, which will allow OpenShift to connect to the Docker container.

    ```bash
    oc edit scc restricted
    ```

    ```bash
    # Please edit the object below. Lines beginning with a '#' will be ignored,
    # and an empty file will abort the edit. If an error occurs while saving this file will be
    # reopened with the relevant failures.
    #
    allowHostDirVolumePlugin: true
    allowHostIPC: false
    allowHostNetwork: false
    allowHostPID: false
    allowHostPorts: false
    allowPrivilegedContainer: false
    allowedCapabilities: null
    apiVersion: security.openshift.io/v1
    # [...]
    ```

4. Download the [pumba_openshift.yml](https://raw.githubusercontent.com/alexei-led/pumba/master/deploy/pumba_openshift.yml) file and modify it as necessary.  By default every 30 seconds it will kill a container within a pod containing the string `"hello"` in its name.

    ```bash
    curl -O https://raw.githubusercontent.com/alexei-led/pumba/master/deploy/pumba_openshift.yml
    ```

    ```yaml
    apiVersion: extensions/v1beta1
    kind: DaemonSet
    metadata:
      name: pumba
    spec:
      template:
        metadata:
          labels:
            app: pumba
          name: pumba
        spec:
          containers:
          - image: gaiaadm/pumba:master
            imagePullPolicy: Always
            name: pumba
            command: ["pumba"] 
            args: ["--random", "--debug", "--interval", "30s", "kill", "--signal", "SIGKILL", "re2:.*hello.*"]
            securityContext:
              runAsUser: 0
            volumeMounts:
              - name: dockersocket
                mountPath: /var/run/docker.sock
          volumes:
            - hostPath:
                path: /var/run/docker.sock
              name: dockersocket
    ```

5. Finally, create the DaemonSet from the `pumba_openshift.yml`.

    ```bash
    oc create -f pumba_openshift.yml
    daemonset.extensions "pumba" created
    ```

That's it.  Now just add some pods to your project that match the regex used in the DaemonSet, if any, and Pumba should pick up on them and start killing them off.  Check out this handy [video tutorial](https://www.youtube.com/watch?v=kA0P-V2JPTA) for all the details.

{% include nav-internal.md %}