---
title: "Taking Chaos Monkey to the Next Level - Advanced Developer Guide"
description: "A detailed, advanced developer guide for Chaos Monkey and related alternatives/technologies."
date: 2018-08-30
path: "/chaos-monkey/advanced-tips"
url: "https://www.gremlin.com/chaos-monkey/advanced-tips"
sources: "See: _docs/resources.md"
published: true
---

# Taking Chaos Monkey to the Next Level - Advanced Developer Guide

- URL: `https://www.gremlin.com/chaos-monkey/advanced-tips`
- Parent: `Pillar Page: Chaos Monkey Guide for Engineers - Tips, Tutorials, and Training`
- Content:
  - Per **Austin**, content to be determined after direction from **Kolton**.

## Installing Chaos Monkey with Kubernetes on AWS

> See: https://aws.amazon.com/blogs/opensource/spinnaker-on-aws/

### Configure Kubectl and AWS IAM Authenticator

> See: https://docs.aws.amazon.com/eks/latest/userguide/configure-kubectl.html

### Configure Kubernetes

> See: https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html

- Copy and paste the following into `~/.kube/config-<cluster-name>`, where `<cluster-name>` is replaced by the name of the Kubernetes cluster you already created:

```yaml
apiVersion: v1
clusters:
- cluster:
    server: <endpoint-url>
    certificate-authority-data: <base64-encoded-ca-cert>
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "<cluster-name>"
        # - "-r"
        # - "<role-arn>"
      # env:
        # - name: AWS_PROFILE
        #   value: "<aws-profile>"
```

- Replace the `<...>` placeholder strings with the following `EKS_CLUSTER_` exported values retrieved earlier:
  - `<endpoint-url>`: `${EKS_CLUSTER_ENDPOINT}`
  - `<base64-encoded-ca-cert>`: `${EKS_CLUSTER_CA_DATA}`
  - `<cluster-name>`: `${EKS_CLUSTER_NAME}`

!!! Tip
    You can easily output the value of an exported variable with `echo $VARIABLE_NAME`:
    ```bash
    $ echo $EKS_CLUSTER_NAME
    spinnaker-cluster
    ```

- Your `config-spinnaker-cluster` file should now look something like this:

```yaml
apiVersion: v1
clusters:
- cluster:
    server: https://51A93D4A4B1228D6D06BE160DA2D3A8A.yl4.us-west-2.eks.amazonaws.com
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNE1Ea3dOakExTVRnME1BHeGFNN3QyaApzcm8wa1ZOWTdCQ1g5YVBBY09rRFVuRExGektpZTJnZVZLOFpxVHJvZEpLR0p3SEtjVDJNNUtsR0ZTSjMzSGpoCk5ZeVErTnJkd0VKT2puR2xZN3R1eVFvZjhnNU0vNWZzZSt0TWFMTjJjQ3NWNFA1NCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFKN3owTEI5NFVoZWNwTUh0VGYrVTkxVDlxU2IKNWFVRGQrdlVTNEpVTWwwdk01OXBqc05CNDU1Z1l6ZkpLelZ1YXI5TjJOVURiREllNUJsbjlCRjWb1hEVEk0TURrd016QTFNVGcwTVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBT0h6CldrZ2pzTWZ0eEJYd3NZOGRuVXI5UUQTAzUVczazlaZHZlMWNYRlp4bHdqc3RSdWN3eUxRTG12eUh0VzJsTjE4RENqSXF5OGwxeUlYSENERQpXQjI3eHo4TXg3ZDJVSjIyaThjQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0V5OSTJHYjV4QU1vYjJBaWQwbEQrT2NncGdDcXQvQ3h2SlFJRGpxbjRKT1AKejh6RVkvWVVsQjBUOTVXUUFsRE9ZWnlKY3lDeWxYcFZRTnNDRWNSMFhUakRaVDFVbXMyMmk4NlozYy8xQ1IrWgpKNkNqZ3IvZkNadVVaV0VUbGt1WXhlSG5CQS91ZURJM1NsMVdnY0ZFMGFyNGxsVkVFVngyS01PZXhuM09FdHI0CjhBd1dmQWxzSUNXRWdjMjRKdzk5MG9LelNObXB0cWRaOEFwczhVaHJoZWtoNEh1blpFLzhud1prb213SE1TcTYKbjl5NFJN3RyR0xWN0RzMUxWUFBlWjkKVVB0eU1WODlieFVEeFhNV3I3d2tNRy9YckdtaC9nN1gwb1grdXRnUUtiSWdPaHZMZEFKSDNZUUlyTjhHS0krcwpIMGtjTnpYMWYzSGdabUVINUIxNXhER0R2SnA5a045Q29VdjRYVE5tdlljVlNVSy9vcWdwaXd1TU9oZz0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "spinnaker-cluster"
        # - "-r"
        # - "<role-arn>"
      # env:
        # - name: AWS_PROFILE
        #   value: "<aws-profile>"
```

- Save your config file, then specify the path to the `KUBECONFIG` environment variable:

```bash
export KUBECONFIG=$KUBECONFIG:~/.kube/config-spinnaker-cluster
```

- Test that `kubectl` is able to use your credentials to connect to your cluster with `kubectl get svc`:

```bash
$ kubectl get svc

NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   172.25.0.1   <none>        443/TCP   31m
```

#### Create AWS Accounts and Roles

- Issue the following commands to create the `spinnaker` namespace, `spinnaker-service-account` serviceaccount, and `spinnaker-admin` binding:

```bash
CONTEXT=aws
kubectl create namespace spinnaker
kubectl apply -f https://d3079gxvs8ayeg.cloudfront.net/templates/spinnaker-service-account.yaml
kubectl apply -f https://d3079gxvs8ayeg.cloudfront.net/templates/spinnaker-cluster-role-binding.yaml
```

- Next get your secret key and set it in the `TOKEN` environmental variable:

```bash
TOKEN=$(kubectl get secret --context $CONTEXT \
   $(kubectl get serviceaccount spinnaker-service-account \
       --context $CONTEXT \
       -n spinnaker \
       -o jsonpath='{.secrets[0].name}') \
   -n spinnaker \
   -o jsonpath='{.data.token}' | base64 --decode)
```

- Now we'll pass the `TOKEN` to configuration commands to specify `kubectl` credentials:

```bash
kubectl config set-credentials ${CONTEXT}-token-user --token $TOKEN
kubectl config set-context $CONTEXT --user ${CONTEXT}-token-user
```

### Add Kubernetes Provider to Halyard

- Start by enabling the Kubernetes provider in Halyard: `$ hal config provider kubernetes enable`.
- Next, add the `kubernetes-master` account to Halyard:

```bash
hal config provider kubernetes account add kubernetes-master --provider-version v2 --context $(kubectl config current-context)`
```

- Enable the `artifacts` and `chaos` features of Halyard:

```bash
hal config features edit --artifacts true
hal config features edit --chaos true
```

### Add AWS Provider to Halyard

- Input the following commands, replacing `<AWS_ACCOUNT_ID>` with the primary/managing account ID of your AWS account:

```bash
hal config provider aws account add aws-primary --account-id <AWS_ACCOUNT_ID> --assume-role role/spinnakerManaged
hal config provider aws enable
```

### Add ECS Provider to Halyard

- Input the following commands, which will create the `ecs-primary` account in Halyard and associate it with the `aws-primary` AWS account added above:

```bash
hal config provider ecs account add ecs-primary --aws-account aws-primary
hal config provider ecs enable
```

```bash
hal config deploy edit --type distributed --account-name kubernetes-master
```

!!! Error Error: Problems in default.deploymentEnvironment
    - WARNING Field DeploymentEnvironment.haServices not supported for Spinnaker version 1.9.2: High availability services are not available prior to this release.
    ? Use at least 1.10.0 (It may not have been released yet).

### Use S3 for Persistent Storage

- Allow Spinnaker to use AWS S3 to store persistent data, which simply creates a small S3 bucket.  Issue the following command by replacing `<AWS_ACCESS_KEY_ID>` with any AWS access key that has full S3 service privileges:

```bash
hal config storage s3 edit --access-key-id <AWS_ACCESS_KEY_ID> --secret-access-key --region us-west-2
hal config storage edit --type s3
```

### Create Kubernetes Worker Nodes

- Download [this](https://d3079gxvs8ayeg.cloudfront.net/templates/amazon-eks-nodegroup.yaml) `amazon-eks-nodegroup.yml` template file:

```bash
curl -O https://d3079gxvs8ayeg.cloudfront.net/templates/amazon-eks-nodegroup.yaml
```

- Make sure you're still running the same console window in which you issued the series of 

```bash
aws cloudformation deploy --stack-name spinnaker-eks-nodes --template-file amazon-eks-nodegroup.yaml \
--parameter-overrides NodeInstanceProfile=$SPINNAKER_INSTANCE_PROFILE_ARN \
NodeInstanceType=t2.large ClusterName=$EKS_CLUSTER_NAME NodeGroupName=spinnaker-cluster-nodes ClusterControlPlaneSecurityGroup=$CONTROL_PLANE_SG \
Subnets=$SUBNETS VpcId=$VPC_ID --capabilities CAPABILITY_NAMED_IAM
```

- Paste the following into a new `~/.kube/aws-auth-cm.yaml` file, replacing `<AUTH_ARN>` with the `AUTH_ARN` variable created previously (use `echo $AUTH_ARN` to print to console):

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: <AUTH_ARN>
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
```

- Apply this newly created role mapping by issuing the following command:

```bash
kubectl apply -f aws-auth-cm.yaml
```

- Check the status of your Kubernetes nodes with `kubectl get nodes`.  The `--watch` flag can be added to perform constant updates.

```bash
kubectl get nodes
NAME                                          STATUS    ROLES     AGE       VERSION
ip-10-100-10-178.us-west-2.compute.internal   Ready     <none>    2m        v1.10.3
ip-10-100-10-210.us-west-2.compute.internal   Ready     <none>    2m        v1.10.3
ip-10-100-11-239.us-west-2.compute.internal   Ready     <none>    2m        v1.10.3
```

- Once all nodes have a `Ready` **STATUS** you're all set to deploy Spinnaker.

### Deploy Spinnaker

- View the currently available Spinnaker versions with `hal version list`:

```bash
hal version list
+ Get current deployment
  Success
+ Get Spinnaker version
  Success
+ Get released versions
  Success
+ You are on version "", and the following are available:
 - 1.7.8 (Ozark):
   Changelog: https://gist.github.com/spinnaker-release/75f98544672a4fc490d451c14688318e
   Published: Wed Aug 29 19:09:57 UTC 2018
   (Requires Halyard >= 1.0.0)
 - 1.8.6 (Dark):
   Changelog: https://gist.github.com/spinnaker-release/0844fadacaf2299d214a82e88217d97c
   Published: Wed Aug 29 19:11:34 UTC 2018
   (Requires Halyard >= 1.0.0)
 - 1.9.2 (Bright):
   Changelog: https://gist.github.com/spinnaker-release/9323c90ab2088d89e68ce2a7ef7e5809
   Published: Wed Aug 29 20:08:18 UTC 2018
   (Requires Halyard >= 1.0.0)
```

- Specify the version you wish to install with the `--version` flag below.  We'll be using the latest at the time of writing, `1.9.2`:

```bash
hal config version edit --version 1.9.2
hal deploy apply
```

!!! Error `Deploy apply` errors.
    In some cases you may experience a deployment error related to your `kubeconfig` file(s).  

```bash
sudo hal deploy connect
```

[/]:                                    /
[/advanced-tips]:                       /advanced-tips
[/alternatives]:                        /alternatives
[/alternatives/azure]:                  /alternatives/azure
[/alternatives/docker]:                 /alternatives/docker
[/alternatives/google-cloud-platform]:  /alternatives/google-cloud-platform
[/alternatives/kubernetes]:             /alternatives/kubernetes
[/alternatives/openshift]:              /alternatives/openshift
[/alternatives/private-cloud]:          /alternatives/private-cloud
[/alternatives/spring-boot]:            /alternatives/spring-boot
[/alternatives/vmware]:                 /alternatives/vmware
[/developer-tutorial]:                  /developer-tutorial
[/downloads-resources]:                 /downloads-resources
[/origin-netflix]:                      /origin-netflix
[/simian-army]:                         /simian-army