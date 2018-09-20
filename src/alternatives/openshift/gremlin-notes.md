---
published: false
---

**(TODO)**: https://geekflare.com/no-internet-connection-from-vmware-with-centos-7/

```bash
yum update -y
```

```bash
yum install -y git docker net-tools open-vm-tools
```

```bash
git clone https://github.com/gshipley/installcentos.git
cd installcentos
./install-openshift.sh
```

```bash
FAILED - RETRYING: Wait for all control plane pods to become ready (2 retries left).
FAILED - RETRYING: Wait for all control plane pods to become ready (1 retries left).
failed: [192.168.224.132] (item=controllers) => {"attempts": 60, "changed": false, "item": "controllers", "results": {"cmd": "/usr/bin/oc get pod master-controllers-192.168.224.132 -o json -n kube-system", "results": [{}], "returncode": 0, "stderr": "Error from server (NotFound): pods \"master-controllers-192.168.224.132\" not found\n", "stdout": ""}, "state": "list"}

NO MORE HOSTS LEFT *****************************************************************************************************
        to retry, use: --limit @/root/installcentos/openshift-ansible/playbooks/deploy_cluster.retry

PLAY RECAP *************************************************************************************************************
192.168.224.132            : ok=311  changed=130  unreachable=0    failed=1
localhost                  : ok=12   changed=0    unreachable=0    failed=0


INSTALLER STATUS *******************************************************************************************************
Initialization              : Complete (0:00:09)
        [DEPRECATION WARNING]: The following are deprecated variables and will be no longer be used in the next minor release. Please update your inventory accordingly.
        openshift_node_kubelet_args
Health Check                : Complete (0:00:08)
Node Bootstrap Preparation  : Complete (0:02:35)
etcd Install                : Complete (0:00:24)
Master Install              : In Progress (0:17:00)
        This phase can be restarted by running: playbooks/openshift-master/config.yml


Failure summary:


  1. Hosts:    192.168.224.132
     Play:     Configure masters
     Task:     Wait for all control plane pods to become ready
     Message:  All items completed
```

```bash
******
* Your console is https://console.openshift.gabewyatt.com:8443
* Your username is gabe
* Your password is hobbes
*
* Login using:
*
$ oc login -u gabe -p hobbes https://console.openshift.gabewyatt.com:8443/
******
Login successful.

You have access to the following projects and can switch between them with 'oc project <projectname>':

  * default
    kube-public
    kube-system
    openshift
    openshift-infra
    openshift-node

Using project "default".
```

```bash
nmtui
```

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