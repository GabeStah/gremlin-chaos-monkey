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

Gremlin's [Failure as a Service][#gremlin-failure-as-a-service] simplifies your Chaos Engineering workflow for OpenShift by making it safe and effortless to execute Chaos Experiments across all application containers.  As a distributed architecture OpenShift is particularly sensitive to instability and unexpected failures, and yet containers are becoming first-class citizens for many organizations.  Gremlin can perform a variety of attacks on your OpenShift applications including overloading CPU, memory, disk, and IO; killing pods; modifying network traffic; and much more.

Check out [this tutorial](https://help.gremlin.com/install-gremlin-centos-7/) to get started!

## Pumba

**(TODO)**: http://www.lordofthejars.com/2017/10/adding-chaos-on-openshift-cluster.html

**(TODO)**: Test daemonset for Gremlin.

```yaml
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: gremlin
  namespace: <namespace where you want to run an attack>
  labels:
    k8s-app: gremlin
    version: v1
spec:
  template:
    metadata:
      labels:
        k8s-app: gremlin
        version: v1
    spec:
      containers:
      - name: gremlin
        image: gremlin/gremlin
        args: [ "daemon" ]
        imagePullPolicy: Always
        securityContext:
          capabilities:
            add:
              - NET_ADMIN
              - SYS_BOOT
              - SYS_TIME
              - KILL
        env:
          - name: GREMLIN_TEAM_ID
            value: <YOUR TEAM ID GOES HERE>
          - name: GREMLIN_TEAM_SECRET
            value: <YOUR SECRET GOES HERE>
          - name: GREMLIN_IDENTIFIER
            valueFrom:
              fieldRef:
                fieldPath: spec.nodeName
        volumeMounts:
          - name: docker-sock
            mountPath: /var/run/docker.sock
          - name: gremlin-state
            mountPath: /var/lib/gremlin
          - name: gremlin-logs
            mountPath: /var/log/gremlin
      volumes:
        # Gremlin uses the Docker socket to discover eligible containers to attack,
        # and to launch Gremlin sidecar containers
        - name: docker-sock
          hostPath:
            path: /var/run/docker.sock
        # The Gremlin daemon communicates with Gremlin sidecars via its state directory.
        # This should be shared with the Kubernetes host
        - name: gremlin-state
          hostPath:
            path: /var/lib/gremlin
        # The Gremlin daemon forwards logs from the Gremlin sidecars to the Gremlin control plane
        # These logs should be shared with the host
        - name: gremlin-logs
          hostPath:
            path: /var/log/gremlin
```

{% include nav-internal.md %}