---
title: "Chaos Monkey Tutorial - A Step-by-Step Guide to Creating Failure on AWS"
description: "A step-by-step guide on setting up and using Chaos Monkey with AWS, and also explores specific scenarios in which Chaos Monkey may (or may not) be relevant."
date: 2018-08-30
path: "/chaos-monkey/developer-tutorial"
url: "https://www.gremlin.com/chaos-monkey/developer-tutorial"
sources: "See: _docs/resources.md"
published: true
---

- URL: `https://www.gremlin.com/chaos-monkey/developer-tutorial`
- Parent: `Pillar Page: Chaos Monkey Guide for Engineers - Tips, Tutorials, and Training`
- Content:
  - `Intro`
    - What: Describe the purpose of the tutorial, which is to give not only a step-by-step guide on setting up and using Chaos Monkey with AWS, but we'll also go beyond initial setup to explore specific _scenarios_ in which Chaos Monkey may (or may not) be relevant.
    - Who: Define intended audiences (primarily technically-minded professionals or hobbyists, engineers, developers, etc).
    - When/Why: The entire page will expound on the _when_ and _why_, detailing scenarios (as listed below) in which using Chaos Monkey is appropriate, and providing the _how to_ technical steps to make it work.
  - `Basic Usage Guide`
    - Provide full walk through detailing propagation, configuration, setup, and execution of Chaos Monkey within an AWS instance.
  - `Monitoring Health and Stability`
  - `Detecting Service Latency`
  - [`Discovering Security Vulnerabilities`](https://www.battery.com/powered/youve-heard-of-the-netflix-chaos-monkey-we-propose-for-cyber-security-an-infected-monkey/)
  - [`Examining Exception Handling`](https://www.baeldung.com/spring-boot-chaos-monkey)
  - [`On Demand Chaos`](https://medium.com/production-ready/using-chaos-monkey-whenever-you-feel-like-it-e5fe31257a07)
  - [`Building Your Own Customized Monkey`](https://blog.serverdensity.com/building-chaos-monkey/)
  - `Additional Resources`: Section to include an abundance of additional links and resources, with careful consideration for _types_ of curated content.  Resources should include written tutorials, books, research papers, talks/conferences, podcasts, videos, and so forth.

## Setting Up Chaos Monkey

### 

```
######### WELCOME TO SPINNAKER ############

Initializing systems!

Default region is configured for Amazon AWS region:

GCE is disabled on this host. Refer to http://spinnaker.io/
for more specific instructions.

You are in a VPC setting this . . .
Amazon VPC ID is set to: vpc-08e215071274f2822

Amazon AWS Subnet is set to: subnet-0cee7f54078833309

Reconfiguring deck . . . .

Rewriting deck settings in "/opt/deck/html/settings.js".
Restarting Spinnaker . . .

spinnaker start/running

Edit /etc/default/spinnaker and restart Spinnaker if you wish to change this
Then execute:
sudo service clouddriver restart
sudo service rosco restart

------ You should be ready to go -----
To connect create a SSH tunnel from your host to ec2-34-217-178-128.us-west-2.compute.amazonaws.com remote ports 9000 and 8084

You may add this to ~/.ssh/config:
Host spinnaker
    HostName ec2-34-217-178-128.us-west-2.compute.amazonaws.com
    IdentityFile /path/to/private/key
    LocalForward 9000 127.0.0.1:9000
    LocalForward 8084 127.0.0.1:8084
    LocalForward 8087 127.0.0.1:8087
    User ubuntu

If the ssh config file is new. Ensure it is chmod 400

Execute: ssh -f -N spinnaker
Open http://localhost:9000/ in your web browser

This message will now self-destruct. Enjoy
```

### SSH Configuration

- May need to modify auto-generated `SpinnakerWebServerSecurityGroup` AWS Secury Group to add your local IP address/range [SCREENSHOT].

### AWS EC2 Bastion & Spinnaker

| Timestamp         | Status             | Type                                  | Logical ID                                  | Status Reason               |
| ----------------- | ------------------ | ------------------------------------- | ------------------------------------------- | --------------------------- |
| 16:31:51 UTC-0700 | CREATE_COMPLETE    | AWS::CloudFormation::Stack            | Spinnaker                                   |                             |
| 16:31:48 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::Instance                    | SpinnakerWebServer                          |                             |
| 16:31:32 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Instance                    | SpinnakerWebServer                          | Resource creation Initiated |
| 16:31:31 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::Route                       | SpinnakerPrivateRoute                       |                             |
| 16:31:30 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Instance                    | SpinnakerWebServer                          |                             |
| 16:31:28 UTC-0700 | CREATE_COMPLETE    | AWS::IAM::InstanceProfile             | SpinnakerInstanceProfile                    |                             |
| 16:31:15 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Route                       | SpinnakerPrivateRoute                       | Resource creation Initiated |
| 16:31:15 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Route                       | SpinnakerPrivateRoute                       |                             |
| 16:31:13 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::NatGateway                  | NAT                                         |                             |
| 16:29:58 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::Instance                    | BastionServer                               |                             |
| 16:29:46 UTC-0700 | CREATE_COMPLETE    | AWS::IAM::AccessKey                   | SpinnakerAccessKey                          |                             |
| 16:29:45 UTC-0700 | CREATE_IN_PROGRESS | AWS::IAM::AccessKey                   | SpinnakerAccessKey                          | Resource creation Initiated |
| 16:29:45 UTC-0700 | CREATE_IN_PROGRESS | AWS::IAM::AccessKey                   | SpinnakerAccessKey                          |                             |
| 16:29:43 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::Route                       | SpinnakerPublicRoute                        |                             |
| 16:29:43 UTC-0700 | CREATE_COMPLETE    | AWS::IAM::User                        | SpinnakerUser                               |                             |
| 16:29:43 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::SubnetRouteTableAssociation | SpinnakerPublicSubnetRouteTableAssociation  |                             |
| 16:29:39 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::SubnetRouteTableAssociation | SpinnakerPrivateSubnetRouteTableAssociation |                             |
| 16:29:27 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Route                       | SpinnakerPublicRoute                        | Resource creation Initiated |
| 16:29:27 UTC-0700 | CREATE_IN_PROGRESS | AWS::IAM::InstanceProfile             | SpinnakerInstanceProfile                    | Resource creation Initiated |
| 16:29:27 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::SubnetRouteTableAssociation | SpinnakerPublicSubnetRouteTableAssociation  | Resource creation Initiated |
| 16:29:27 UTC-0700 | CREATE_IN_PROGRESS | AWS::IAM::InstanceProfile             | SpinnakerInstanceProfile                    |                             |
| 16:29:27 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Route                       | SpinnakerPublicRoute                        |                             |
| 16:29:26 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::SubnetRouteTableAssociation | SpinnakerPublicSubnetRouteTableAssociation  |                             |
| 16:29:25 UTC-0700 | CREATE_COMPLETE    | AWS::IAM::Role                        | SpinnakerRole                               |                             |
| 16:29:25 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Instance                    | BastionServer                               | Resource creation Initiated |
| 16:29:24 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::RouteTable                  | SpinnakerPublicRouteTable                   |                             |
| 16:29:24 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::NatGateway                  | NAT                                         | Resource creation Initiated |
| 16:29:24 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::NatGateway                  | NAT                                         |                             |
| 16:29:24 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::SubnetRouteTableAssociation | SpinnakerPrivateSubnetRouteTableAssociation | Resource creation Initiated |
| 16:29:23 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::RouteTable                  | SpinnakerPublicRouteTable                   | Resource creation Initiated |
| 16:29:23 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Instance                    | BastionServer                               |                             |
| 16:29:23 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::RouteTable                  | SpinnakerPublicRouteTable                   |                             |
| 16:29:23 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::SubnetRouteTableAssociation | SpinnakerPrivateSubnetRouteTableAssociation |                             |
| 16:29:21 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::Subnet                      | SpinnakerPublicSubnet                       |                             |
| 16:29:21 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::Subnet                      | SpinnakerPrivateSubnet                      |                             |
| 16:29:21 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::VPCGatewayAttachment        | SpinnakerAttachGateway                      |                             |
| 16:29:18 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::SecurityGroup               | SpinnakerWebServerSecurityGroup             |                             |
| 16:29:17 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::SecurityGroup               | SpinnakerWebServerSecurityGroup             | Resource creation Initiated |
| 16:29:12 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::SecurityGroup               | SpinnakerWebServerSecurityGroup             |                             |
| 16:29:10 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::SecurityGroup               | SpinnakerBastionSecurityGroup               |                             |
| 16:29:09 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::SecurityGroup               | SpinnakerBastionSecurityGroup               | Resource creation Initiated |
| 16:29:06 UTC-0700 | CREATE_IN_PROGRESS | AWS::IAM::User                        | SpinnakerUser                               | Resource creation Initiated |
| 16:29:06 UTC-0700 | CREATE_IN_PROGRESS | AWS::IAM::Role                        | SpinnakerRole                               | Resource creation Initiated |
| 16:29:06 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::RouteTable                  | SpinnakerPrivateRouteTable                  |                             |
| 16:29:05 UTC-0700 | CREATE_IN_PROGRESS | AWS::IAM::User                        | SpinnakerUser                               |                             |
| 16:29:05 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::VPCGatewayAttachment        | SpinnakerAttachGateway                      | Resource creation Initiated |
| 16:29:05 UTC-0700 | CREATE_IN_PROGRESS | AWS::IAM::Role                        | SpinnakerRole                               |                             |
| 16:29:05 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Subnet                      | SpinnakerPrivateSubnet                      | Resource creation Initiated |
| 16:29:05 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Subnet                      | SpinnakerPublicSubnet                       | Resource creation Initiated |
| 16:29:05 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::VPCGatewayAttachment        | SpinnakerAttachGateway                      |                             |
| 16:29:05 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Subnet                      | SpinnakerPrivateSubnet                      |                             |
| 16:29:04 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::RouteTable                  | SpinnakerPrivateRouteTable                  | Resource creation Initiated |
| 16:29:04 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::Subnet                      | SpinnakerPublicSubnet                       |                             |
| 16:29:04 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::SecurityGroup               | SpinnakerBastionSecurityGroup               |                             |
| 16:29:04 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::RouteTable                  | SpinnakerPrivateRouteTable                  |                             |
| 16:29:03 UTC-0700 | CREATE_COMPLETE    | AWS::IAM::Role                        | BaseIAMRole                                 |                             |
| 16:29:03 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::VPC                         | SpinnakerVPC                                |                             |
| 16:29:02 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::EIP                         | NATEIP                                      |                             |
| 16:29:02 UTC-0700 | CREATE_COMPLETE    | AWS::EC2::InternetGateway             | SpinnakerInternetGateway                    |                             |
| 16:28:46 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::EIP                         | NATEIP                                      | Resource creation Initiated |
| 16:28:46 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::VPC                         | SpinnakerVPC                                | Resource creation Initiated |
| 16:28:46 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::InternetGateway             | SpinnakerInternetGateway                    | Resource creation Initiated |
| 16:28:46 UTC-0700 | CREATE_IN_PROGRESS | AWS::IAM::Role                        | BaseIAMRole                                 | Resource creation Initiated |
| 16:28:45 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::EIP                         | NATEIP                                      |                             |
| 16:28:45 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::VPC                         | SpinnakerVPC                                |                             |
| 16:28:45 UTC-0700 | CREATE_IN_PROGRESS | AWS::EC2::InternetGateway             | SpinnakerInternetGateway                    |                             |
| 16:28:45 UTC-0700 | CREATE_IN_PROGRESS | AWS::IAM::Role                        | BaseIAMRole                                 |                             |
| 16:28:43 UTC-0700 | CREATE_IN_PROGRESS | AWS::CloudFormation::Stack            | Spinnaker                                   | User Initiated              |

### Chaos Monkey + Spinnaker Setup

- Click **Config** in top-right of Spinnaker `Deck` application page.
- Select **Chaos Monkey** in side navigation. [SCREENSHOT]
- 

### Spinnaker COnfiguration

- `/opt/spinnaker`
- `/opt/deck/html/settings.js`
- `/opt/rosco`: Bakery service that handles pipelines.

### Known Issues

- `Bake` stage can fail with `Error launching source spot instance` due to `invalid spot instance price` (see: [#2889](https://github.com/spinnaker/spinnaker/issues/2889)).
  - Resolution: Remove `spot` reference lines in `/opt/rosco/config/packer/aws-ebs.json`.

- `Bake` stage can fail with `Unknown configuration key: "ena_support"` error (see: [#2237](https://github.com/spinnaker/spinnaker/issues/2237)).
  - Resolution: Remove `ena_support` reference line in `/opt/rosco/config/packer/aws-ebs.json`.

- `Bake` stage can fail with:
```
==> amazon-ebs: Prevalidating AMI Name...
==> amazon-ebs: Inspecting the source AMI...
==> amazon-ebs: Creating temporary keypair: packer 5b8e2add-3401-259c-7142-12708cc57144
==> amazon-ebs: Creating temporary security group for this instance...
==> amazon-ebs: Authorizing access to port 22 the temporary security group...
==> amazon-ebs: Launching a source AWS instance...
    amazon-ebs: Instance ID: i-0524794dbeffb3381
==> amazon-ebs: Waiting for instance (i-0524794dbeffb3381) to become ready...
==> amazon-ebs: Waiting for SSH to become available...
==> amazon-ebs: Connected to SSH!
==> amazon-ebs: Pausing 30s before the next provisioner...
==> amazon-ebs: Provisioning with shell script: /opt/rosco/config/packer/install_packages.sh
    amazon-ebs: repository=
    amazon-ebs: package_type=deb
    amazon-ebs: packages=redis-server
    amazon-ebs: upgrade=
    amazon-ebs: artifacts=
    amazon-ebs: cat: /tmp/artifacts.json: No such file or directory
==> amazon-ebs: Terminating the source AWS instance...
==> amazon-ebs: No AMIs to cleanup
==> amazon-ebs: Deleting temporary security group...
==> amazon-ebs: Deleting temporary keypair...
Build 'amazon-ebs' errored: Script exited with non-zero exit status: 1

==> Some builds didn't complete successfully and had errors:
--> amazon-ebs: Script exited with non-zero exit status: 1

==> Builds finished but no artifacts were created.
```
  - Resolution: Execute the following command to override old `install_packages.sh` script with newer version.
```
sudo curl https://raw.githubusercontent.com/spinnaker/rosco/master/rosco-web/config/packer/install_packages.sh --output /opt/rosco/config/packer/install_packages.sh
```

### Spinnaker: Add Application

- Click **Actions > Create Application**.
- Input `bookstore` in the **Name** field.
- Input your own email address in the **Owner Email** field.
- Ensure `Chaos Monkey > Enabled` is checked.
- Input `My bookstore application` in the **Description** field.
- Under **Instance Health**, tick the `Consider only cloud provider health when executing tasks` checkbox.
- Click **Create** to add your new application.

#### Add Firewall

- Navigate to the `bookstore` application, **INFRASTRUCTURE > FIREWALLS** and click **Create Firewall**.
- Input `dev` in the **Detail** field.
- Input `Bookstore dev environment` in the **Description** field.
- Within the **VPC** dropdown select `SpinnakerVPC`.
- Under the **Ingress** header click **Add new Firewall Rule**. Set the following **Firewall Rule** settings:
  - **Firewall**: `default`
  - **Protocol**: `TCP`
  - **Start Port**: `80`
  - **End Port**: `80`
- Click the **Create** button to finalize the firewall settings. [SCREENSHOT]

#### Add Load Balancer

- Navigate to the `bookstore` application, **INFRASTRUCTURE > LOAD BALANCERS** and click **Create Load Balancer**.
- Select **Classic (Legacy)** and click **Configure Load Balancer**.
- Input `test` in the **Stack** field.
- In the **VPC Subnet** dropdown select `internal (vpc-...)`.
- In the **Firewalls** dropdown select `bookstore--dev (...)`.
- Click **Create** to generate the load balancer. [SCREENSHOT]

#### Add Pipeline

- Navigate to the `bookstore` application, **PIPELINES** and click **Create Pipeline**.
- Select `Pipeline` in the **Type** dropdown.
- Input `Bookstore Dev to Test` in the **Pipeline Name** field.
- Click **Create**. [SCREENSHOT]

##### Add Stage 1

- Click the **Add stage** button.
- Under **Type** select `Bake`.
- Input `redis-server` in the **Package** field.
- Select `trusty (v14.04)` in the **Base OS** dropdown.
- Click **Save Changes** to finalize the stage.

##### Add Stage 2

- Click the **Add stage** button.
- Under **Type** select `Deploy`.
- Click the **Add server group** button to begin creating a new server group.

##### Creating a Server Group

- Select `internal (vpc-...)` in the **VPC Subnet** dropdown.
- Input `dev` in the **Stack** field.
- Under **Load Balancers > Classic Load Balancers** select the `bookstore-dev` load balancer we created.
- Under **Firewalls > Firewalls** select the `bookstore--dev` firewall we also created.
- Under **Instance Type** select the **Custom Type** of instance you think you'll need.  For this example we'll go with something small and cheap, like `t3.micro`.
- Input `3` in the **Capacity > Number of Instances** field.
- Under **Advanced Settings > Key Name** select the `spinnaker_developer` key name.
- Click the **Add** button to create the deployment cluster configuration.
- Finally, click **Save Changes** again at the bottom of the **Pipelines** interface to save the full `Configuration > Bake > Deploy` pipeline.
- *Note: You may see a warning within the `Bake` stage that a `CI` trigger (such as Jenkins/Travis) is usually required, but we don't care in this simple example scenario.*

##### Try It Out

**Successful Bake Stage**:

```
==> amazon-ebs: Prevalidating AMI Name...
==> amazon-ebs: Inspecting the source AMI...
==> amazon-ebs: Creating temporary keypair: packer 5b8e2fbf-372c-b3c9-32b3-b01e379e886d
==> amazon-ebs: Creating temporary security group for this instance...
==> amazon-ebs: Authorizing access to port 22 the temporary security group...
==> amazon-ebs: Launching a source AWS instance...
    amazon-ebs: Instance ID: i-08d49753da1bfe24d
==> amazon-ebs: Waiting for instance (i-08d49753da1bfe24d) to become ready...
==> amazon-ebs: Waiting for SSH to become available...
==> amazon-ebs: Connected to SSH!
==> amazon-ebs: Pausing 30s before the next provisioner...
==> amazon-ebs: Provisioning with shell script: /opt/rosco/config/packer/install_packages.sh
    amazon-ebs: repository=
    amazon-ebs: package_type=deb
    amazon-ebs: packages=redis-server
    amazon-ebs: upgrade=
    amazon-ebs: Ign http://us-west-2.ec2.archive.ubuntu.com trusty InRelease
    amazon-ebs: Get:1 http://us-west-2.ec2.archive.ubuntu.com trusty-updates InRelease [65.9 kB]
    amazon-ebs: Get:2 http://us-west-2.ec2.archive.ubuntu.com trusty-backports InRelease [65.9 kB]
    amazon-ebs: Hit http://us-west-2.ec2.archive.ubuntu.com trusty Release.gpg
    amazon-ebs: Hit http://us-west-2.ec2.archive.ubuntu.com trusty Release
    amazon-ebs: Get:3 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/main Sources [421 kB]
    amazon-ebs: Get:4 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/restricted Sources [6,322 B]
    amazon-ebs: Get:5 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/universe Sources [207 kB]
    amazon-ebs: Get:6 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/multiverse Sources [7,441 B]
    amazon-ebs: Get:7 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/main amd64 Packages [1,101 kB]
    amazon-ebs: Get:8 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/restricted amd64 Packages [17.2 kB]
    amazon-ebs: Get:9 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/universe amd64 Packages [472 kB]
    amazon-ebs: Get:10 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/multiverse amd64 Packages [14.6 kB]
    amazon-ebs: Get:11 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/main Translation-en [546 kB]
    amazon-ebs: Get:12 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/multiverse Translation-en [7,616 B]
    amazon-ebs: Get:13 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/restricted Translation-en [4,021 B]
    amazon-ebs: Get:14 http://us-west-2.ec2.archive.ubuntu.com trusty-updates/universe Translation-en [253 kB]
    amazon-ebs: Get:15 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/main Sources [9,709 B]
    amazon-ebs: Get:16 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/restricted Sources [28 B]
    amazon-ebs: Get:17 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/universe Sources [35.4 kB]
    amazon-ebs: Get:18 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/multiverse Sources [1,896 B]
    amazon-ebs: Get:19 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/main amd64 Packages [13.3 kB]
    amazon-ebs: Get:20 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/restricted amd64 Packages [28 B]
    amazon-ebs: Get:21 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/universe amd64 Packages [43.1 kB]
    amazon-ebs: Get:22 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/multiverse amd64 Packages [1,567 B]
    amazon-ebs: Get:23 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/main Translation-en [7,503 B]
    amazon-ebs: Get:24 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/multiverse Translation-en [1,215 B]
    amazon-ebs: Get:25 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/restricted Translation-en [28 B]
    amazon-ebs: Get:26 http://us-west-2.ec2.archive.ubuntu.com trusty-backports/universe Translation-en [36.8 kB]
    amazon-ebs: Get:27 http://us-west-2.ec2.archive.ubuntu.com trusty/main Sources [1,064 kB]
    amazon-ebs: Get:28 http://us-west-2.ec2.archive.ubuntu.com trusty/restricted Sources [5,433 B]
    amazon-ebs: Get:29 http://us-west-2.ec2.archive.ubuntu.com trusty/universe Sources [6,399 kB]
    amazon-ebs: Get:30 http://security.ubuntu.com trusty-security InRelease [65.9 kB]
    amazon-ebs: Get:31 http://us-west-2.ec2.archive.ubuntu.com trusty/multiverse Sources [174 kB]
    amazon-ebs: Hit http://us-west-2.ec2.archive.ubuntu.com trusty/main amd64 Packages
    amazon-ebs: Hit http://us-west-2.ec2.archive.ubuntu.com trusty/restricted amd64 Packages
    amazon-ebs: Hit http://us-west-2.ec2.archive.ubuntu.com trusty/universe amd64 Packages
    amazon-ebs: Hit http://us-west-2.ec2.archive.ubuntu.com trusty/multiverse amd64 Packages
    amazon-ebs: Hit http://us-west-2.ec2.archive.ubuntu.com trusty/main Translation-en
    amazon-ebs: Hit http://us-west-2.ec2.archive.ubuntu.com trusty/multiverse Translation-en
    amazon-ebs: Hit http://us-west-2.ec2.archive.ubuntu.com trusty/restricted Translation-en
    amazon-ebs: Hit http://us-west-2.ec2.archive.ubuntu.com trusty/universe Translation-en
    amazon-ebs: Ign http://us-west-2.ec2.archive.ubuntu.com trusty/main Translation-en_US
    amazon-ebs: Ign http://us-west-2.ec2.archive.ubuntu.com trusty/multiverse Translation-en_US
    amazon-ebs: Ign http://us-west-2.ec2.archive.ubuntu.com trusty/restricted Translation-en_US
    amazon-ebs: Ign http://us-west-2.ec2.archive.ubuntu.com trusty/universe Translation-en_US
    amazon-ebs: Get:32 http://security.ubuntu.com trusty-security/main Sources [161 kB]
    amazon-ebs: Get:33 http://security.ubuntu.com trusty-security/universe Sources [79.3 kB]
    amazon-ebs: Get:34 http://security.ubuntu.com trusty-security/main amd64 Packages [763 kB]
    amazon-ebs: Get:35 http://security.ubuntu.com trusty-security/universe amd64 Packages [245 kB]
    amazon-ebs: Get:36 http://security.ubuntu.com trusty-security/main Translation-en [412 kB]
    amazon-ebs: Get:37 http://security.ubuntu.com trusty-security/universe Translation-en [133 kB]
    amazon-ebs: Fetched 12.8 MB in 4s (2,618 kB/s)
    amazon-ebs: Reading package lists... Done
    amazon-ebs: Reading package lists... Done
    amazon-ebs: Building dependency tree
    amazon-ebs: Reading state information... Done
    amazon-ebs: The following extra packages will be installed:
    amazon-ebs: libjemalloc1 redis-tools
    amazon-ebs: The following NEW packages will be installed:
    amazon-ebs: libjemalloc1 redis-server redis-tools
    amazon-ebs: 0 upgraded, 3 newly installed, 0 to remove and 99 not upgraded.
    amazon-ebs: Need to get 410 kB of archives.
    amazon-ebs: After this operation, 1,272 kB of additional disk space will be used.
    amazon-ebs: Get:1 http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty/universe libjemalloc1 amd64 3.5.1-2 [76.8 kB]
    amazon-ebs: Get:2 http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty/universe redis-tools amd64 2:2.8.4-2 [65.7 kB]
    amazon-ebs: Get:3 http://us-west-2.ec2.archive.ubuntu.com/ubuntu/ trusty/universe redis-server amd64 2:2.8.4-2 [267 kB]
    amazon-ebs: Fetched 410 kB in 0s (19.4 MB/s)
    amazon-ebs: Selecting previously unselected package libjemalloc1.
    amazon-ebs: (Reading database ... 51285 files and directories currently installed.)
    amazon-ebs: Preparing to unpack .../libjemalloc1_3.5.1-2_amd64.deb ...
    amazon-ebs: Unpacking libjemalloc1 (3.5.1-2) ...
    amazon-ebs: Selecting previously unselected package redis-tools.
    amazon-ebs: Preparing to unpack .../redis-tools_2%3a2.8.4-2_amd64.deb ...
    amazon-ebs: Unpacking redis-tools (2:2.8.4-2) ...
    amazon-ebs: Selecting previously unselected package redis-server.
    amazon-ebs: Preparing to unpack .../redis-server_2%3a2.8.4-2_amd64.deb ...
    amazon-ebs: Unpacking redis-server (2:2.8.4-2) ...
    amazon-ebs: Processing triggers for man-db (2.6.7.1-1ubuntu1) ...
    amazon-ebs: Processing triggers for ureadahead (0.100.0-16) ...
    amazon-ebs: Setting up libjemalloc1 (3.5.1-2) ...
    amazon-ebs: Setting up redis-tools (2:2.8.4-2) ...
    amazon-ebs: Setting up redis-server (2:2.8.4-2) ...
    amazon-ebs: Starting redis-server: redis-server.
    amazon-ebs: Processing triggers for libc-bin (2.19-0ubuntu6.13) ...
    amazon-ebs: Processing triggers for ureadahead (0.100.0-16) ...
==> amazon-ebs: Stopping the source instance...
==> amazon-ebs: Waiting for the instance to stop...
==> amazon-ebs: Creating the AMI: redis-server-all-20180904070951-trusty
    amazon-ebs: AMI: ami-04c042b2789ec7760
==> amazon-ebs: Waiting for AMI to become ready...
==> amazon-ebs: Adding tags to AMI (ami-04c042b2789ec7760)...
    amazon-ebs: Adding tag: "appversion": ""
    amazon-ebs: Adding tag: "build_host": ""
    amazon-ebs: Adding tag: "build_info_url": ""
==> amazon-ebs: Tagging snapshot: snap-006359301dd1236f5
==> amazon-ebs: Terminating the source AWS instance...
==> amazon-ebs: Cleaning up any extra volumes...
==> amazon-ebs: No volumes to clean up, skipping
==> amazon-ebs: Deleting temporary security group...
==> amazon-ebs: Deleting temporary keypair...
Build 'amazon-ebs' finished.

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:

us-west-2: ami-04c042b2789ec7760
```

**Successful Deploy Stage**:

**Cluster Instance Console Output**:

```
[    0.000000] Initializing cgroup subsys cpuset

[    0.000000] Initializing cgroup subsys cpu

[    0.000000] Initializing cgroup subsys cpuacct

[    0.000000] Linux version 3.13.0-137-generic (buildd@lgw01-amd64-058) (gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04.3) ) #186-Ubuntu SMP Mon Dec 4 19:09:19 UTC 2017 (Ubuntu 3.13.0-137.186-generic 3.13.11-ckt39)

[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.13.0-137-generic root=UUID=08df443d-a08d-4a06-ab5b-6fdacfc684d3 ro console=tty1 console=ttyS0

[    0.000000] KERNEL supported cpus:

[    0.000000]   Intel GenuineIntel

[    0.000000]   AMD AuthenticAMD

[    0.000000]   Centaur CentaurHauls

[    0.000000] e820: BIOS-provided physical RAM map:

[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable

[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved

[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved

[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003e3f9fff] usable

[    0.000000] BIOS-e820: [mem 0x000000003e3fa000-0x000000003fffffff] reserved

[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e03fffff] reserved

[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved

[    0.000000] NX (Execute Disable) protection: active

[    0.000000] SMBIOS 2.7 present.

[    0.000000] Hypervisor detected: KVM

[    0.000000] No AGP bridge found

[    0.000000] e820: last_pfn = 0x3e3fa max_arch_pfn = 0x400000000

[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106

[    0.000000] Scanning 1 areas for low memory corruption

[    0.000000] Using GB pages for direct mapping

[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]

[    0.000000] init_memory_mapping: [mem 0x3e000000-0x3e1fffff]

[    0.000000] init_memory_mapping: [mem 0x3c000000-0x3dffffff]

[    0.000000] init_memory_mapping: [mem 0x00100000-0x3bffffff]

[    0.000000] init_memory_mapping: [mem 0x3e200000-0x3e3f9fff]

[    0.000000] RAMDISK: [mem 0x371de000-0x378e6fff]

[    0.000000] ACPI: RSDP 00000000000f8fb0 000014 (v00 AMAZON)

[    0.000000] ACPI: RSDT 000000003e3fe3d0 000038 (v01 AMAZON AMZNRSDT 00000001 AMZN 00000001)

[    0.000000] ACPI: FACP 000000003e3fff80 000074 (v01 AMAZON AMZNFACP 00000001 AMZN 00000001)

[    0.000000] ACPI: DSDT 000000003e3fe410 0010E9 (v01 AMAZON AMZNDSDT 00000001 AMZN 00000001)

[    0.000000] ACPI: FACS 000000003e3fff40 000040

[    0.000000] ACPI: SSDT 000000003e3ff6c0 00087A (v01 AMAZON AMZNSSDT 00000001 AMZN 00000001)

[    0.000000] ACPI: APIC 000000003e3ff5d0 000076 (v01 AMAZON AMZNAPIC 00000001 AMZN 00000001)

[    0.000000] ACPI: SRAT 000000003e3ff530 0000A0 (v01 AMAZON AMZNSRAT 00000001 AMZN 00000001)

[    0.000000] ACPI: WAET 000000003e3ff500 000028 (v01 AMAZON AMZNWAET 00000001 AMZN 00000001)

[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0

[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0

[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00000000-0x3fffffff]

[    0.000000] Initmem setup node 0 [mem 0x00000000-0x3e3f9fff]

[    0.000000]   NODE_DATA [mem 0x3e3f5000-0x3e3f9fff]

[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00

[    0.000000] kvm-clock: cpu 0, msr 0:3e3f1001, boot clock

[    7.895751] Zone ranges:

[    7.895752]   DMA      [mem 0x00001000-0x00ffffff]

[    7.895753]   DMA32    [mem 0x01000000-0xffffffff]

[    7.895754]   Normal   empty

[    7.895755] Movable zone start for each node

[    7.895756] Early memory node ranges

[    7.895757]   node   0: [mem 0x00001000-0x0009efff]

[    7.895758]   node   0: [mem 0x00100000-0x3e3f9fff]

[    7.899960] ACPI: PM-Timer IO Port: 0xb008

[    7.899969] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)

[    7.899971] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)

[    7.899973] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])

[    7.899975] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])

[    7.900007] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23

[    7.900009] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)

[    7.900010] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)

[    7.900011] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)

[    7.900013] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)

[    7.900019] Using ACPI (MADT) for SMP configuration information

[    7.900021] smpboot: Allowing 2 CPUs, 0 hotplug CPUs

[    7.900047] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]

[    7.900049] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]

[    7.900051] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]

[    7.900054] e820: [mem 0x40000000-0xdfffffff] available for PCI devices

[    7.900055] Booting paravirtualized kernel on KVM

[    7.900063] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:2 nr_node_ids:1

[    7.900302] PERCPU: Embedded 27 pages/cpu @ffff88003e000000 s81536 r8192 d20864 u1048576

[    7.900325] kvm-clock: cpu 0, msr 0:3e3f1001, primary cpu clock

[    7.900333] KVM setup async PF for cpu 0

[    7.900343] kvm-stealtime: cpu 0, msr 3e00d000

[    7.900347] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 250867

[    7.900348] Policy zone: DMA32

[    7.900349] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.13.0-137-generic root=UUID=08df443d-a08d-4a06-ab5b-6fdacfc684d3 ro console=tty1 console=ttyS0

[    7.901006] PID hash table entries: 4096 (order: 3, 32768 bytes)

[    7.901060] xsave: enabled xstate_bv 0xe7, cntxt size 0xa80

[    7.901065] Checking aperture...

[    7.968066] No AGP bridge found

[    7.970739] Memory: 979016K/1019488K available (7434K kernel code, 1147K rwdata, 3424K rodata, 1340K init, 1448K bss, 40472K reserved)

[    7.970781] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1

[    7.970794] Hierarchical RCU implementation.

[    7.970794] 	RCU dyntick-idle grace-period acceleration is enabled.

[    7.970795] 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=2.

[    7.970796] 	Offload RCU callbacks from all CPUs

[    7.970797] 	Offload RCU callbacks from CPUs: 0-1.

[    7.970802] NR_IRQS:16640 nr_irqs:512 16

[    8.030304] Console: colour VGA+ 80x25

[    8.208317] console [tty1] enabled

[    8.304754] console [ttyS0] enabled

[    8.307498] allocated 4194304 bytes of page_cgroup

[    8.310257] please try 'cgroup_disable=memory' option if you don't want memory cgroups

[    8.314937] tsc: Detected 2500.000 MHz processor

[    8.317519] Calibrating delay loop (skipped) preset value.. 5000.00 BogoMIPS (lpj=10000000)

[    8.322407] pid_max: default: 32768 minimum: 301

[    8.325129] Security Framework initialized

[    8.327606] AppArmor: AppArmor initialized

[    8.330030] Yama: becoming mindful.

[    8.332381] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)

[    8.335920] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)

[    8.339270] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)

[    8.342582] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)

[    8.346119] Initializing cgroup subsys memory

[    8.348644] Initializing cgroup subsys devices

[    8.351206] Initializing cgroup subsys freezer

[    8.353740] Initializing cgroup subsys blkio

[    8.356335] Initializing cgroup subsys perf_event

[    8.358892] Initializing cgroup subsys hugetlb

[    8.361504] CPU: Physical Processor ID: 0

[    8.363914] CPU: Processor Core ID: 0

[    8.367284] mce: CPU supports 32 MCE banks

[    8.369871] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0

[    8.369871] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0

[    8.369871] tlb_flushall_shift: 6

[    8.380578] Freeing SMP alternatives memory: 32K (ffffffff81e6f000 - ffffffff81e77000)

[    8.391802] ACPI: Core revision 20131115

[    8.394848] ACPI: All ACPI Tables successfully acquired

[    8.397983] ftrace: allocating 28679 entries in 113 pages

[    8.452555] Enabling x2apic

[    8.454578] Enabled x2apic

[    8.456853] Switched APIC routing to physical x2apic.

[    8.460933] ..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1

[    8.463960] smpboot: CPU0: Intel(R) Xeon(R) Platinum 8175M CPU @ 2.50GHz (fam: 06, model: 55, stepping: 04)

[    8.469727] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.

[    8.482625] KVM setup paravirtual spinlock

[    8.486824] NMI watchdog: disabled (cpu0): hardware events not enabled

[    8.490081] x86: Booting SMP configuration:

[    8.492545] .... node  #0, CPUs:      #1[    8.504236] kvm-clock: cpu 1, msr 0:3e3f1041, secondary cpu clock



[    8.508665] x86: Booted up 1 node, 2 CPUs

[    8.508668] KVM setup async PF for cpu 1

[    8.508675] kvm-stealtime: cpu 1, msr 3e10d000

[    8.517315] smpboot: Total of 2 processors activated (10000.00 BogoMIPS)

[    8.521101] devtmpfs: initialized

[    8.525513] EVM: security.selinux

[    8.527788] EVM: security.SMACK64

[    8.529964] EVM: security.ima

[    8.532042] EVM: security.capability

[    8.534948] pinctrl core: initialized pinctrl subsystem

[    8.537742] regulator-dummy: no parameters

[    8.540284] RTC time: 19:58:18, date: 09/04/18

[    8.542911] NET: Registered protocol family 16

[    8.545541] cpuidle: using governor ladder

[    8.548006] cpuidle: using governor menu

[    8.550504] ACPI: bus type PCI registered

[    8.552937] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5

[    8.556173] PCI: Using configuration type 1 for base access

[    8.559767] bio: create slab <bio-0> at 0

[    8.562326] ACPI: Added _OSI(Module Device)

[    8.564788] ACPI: Added _OSI(Processor Device)

[    8.567296] ACPI: Added _OSI(3.0 _SCP Extensions)

[    8.569995] ACPI: Added _OSI(Processor Aggregator Device)

[    8.574660] ACPI: Interpreter enabled

[    8.576977] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20131115/hwxface-580)

[    8.582295] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20131115/hwxface-580)

[    8.587595] ACPI: (supports S0 S3 S4 S5)

[    8.590048] ACPI: Using IOAPIC for interrupt routing

[    8.592753] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug

[    8.597964] ACPI: No dock devices found.

[    8.602403] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])

[    8.605561] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]

[    8.608842] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM

[    8.612088] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.

[    8.617989] acpiphp: Slot [3] registered

[    8.620368] acpiphp: Slot [4] registered

[    8.622877] acpiphp: Slot [5] registered

[    8.625255] acpiphp: Slot [6] registered

[    8.627646] acpiphp: Slot [7] registered

[    8.630056] acpiphp: Slot [8] registered

[    8.632472] acpiphp: Slot [9] registered

[    8.634869] acpiphp: Slot [10] registered

[    8.637390] acpiphp: Slot [11] registered

[    8.733113] acpiphp: Slot [12] registered

[    8.735600] acpiphp: Slot [13] registered

[    8.738044] acpiphp: Slot [14] registered

[    8.740523] acpiphp: Slot [15] registered

[    8.742936] acpiphp: Slot [16] registered

[    8.745361] acpiphp: Slot [17] registered

[    8.747875] acpiphp: Slot [18] registered

[    8.750301] acpiphp: Slot [19] registered

[    8.752767] acpiphp: Slot [20] registered

[    8.755187] acpiphp: Slot [21] registered

[    8.757588] acpiphp: Slot [22] registered

[    8.760022] acpiphp: Slot [23] registered

[    8.762533] acpiphp: Slot [24] registered

[    8.764952] acpiphp: Slot [25] registered

[    8.767362] acpiphp: Slot [26] registered

[    8.769807] acpiphp: Slot [27] registered

[    8.772233] acpiphp: Slot [28] registered

[    8.774673] acpiphp: Slot [29] registered

[    8.777195] acpiphp: Slot [30] registered

[    8.779648] acpiphp: Slot [31] registered

[    8.782102] PCI host bridge to bus 0000:00

[    8.784591] pci_bus 0000:00: root bus resource [bus 00-ff]

[    8.787473] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]

[    8.790558] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]

[    8.793738] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]

[    8.797029] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfebfffff]

[    8.805419] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI

[    8.809975] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by PIIX4 SMB

[    8.813429] pci 0000:00:01.3: PIIX4 devres E PIO at fff0-ffff

[    8.816461] pci 0000:00:01.3: PIIX4 devres F MMIO at ffc00000-ffffffff

[    8.819656] pci 0000:00:01.3: PIIX4 devres G PIO at fff0-ffff

[    8.822629] pci 0000:00:01.3: PIIX4 devres H MMIO at ffc00000-ffffffff

[    8.825966] pci 0000:00:01.3: PIIX4 devres I PIO at fff0-ffff

[    8.829021] pci 0000:00:01.3: PIIX4 devres J PIO at fff0-ffff

[    8.835574] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)

[    8.839566] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)

[    8.843414] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)

[    8.847248] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)

[    8.851040] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)

[    8.854728] ACPI: Enabled 16 GPEs in block 00 to 0F

[    8.858132] vgaarb: setting as boot device: PCI:0000:00:03.0

[    8.861090] vgaarb: device added: PCI:0000:00:03.0,decodes=io+mem,owns=io+mem,locks=none

[    8.865823] vgaarb: loaded

[    8.867853] vgaarb: bridge control possible 0000:00:03.0

[    8.870777] SCSI subsystem initialized

[    8.873290] ACPI: bus type USB registered

[    8.875755] usbcore: registered new interface driver usbfs

[    8.878868] usbcore: registered new interface driver hub

[    8.881712] usbcore: registered new device driver usb

[    8.884544] PCI: Using ACPI for IRQ routing

[    8.887230] NetLabel: Initializing

[    8.889563] NetLabel:  domain hash size = 128

[    8.892060] NetLabel:  protocols = UNLABELED CIPSOv4

[    8.894782] NetLabel:  unlabeled traffic allowed by default

[    8.897726] Switched to clocksource kvm-clock

[    8.904153] AppArmor: AppArmor Filesystem Enabled

[    8.906775] pnp: PnP ACPI init

[    8.908891] ACPI: bus type PNP registered

[    8.911715] pnp: PnP ACPI: found 5 devices

[    8.914131] ACPI: bus type PNP unregistered

[    8.923389] NET: Registered protocol family 2

[    8.926069] TCP established hash table entries: 8192 (order: 4, 65536 bytes)

[    8.929376] TCP bind hash table entries: 8192 (order: 5, 131072 bytes)

[    8.932584] TCP: Hash tables configured (established 8192 bind 8192)

[    8.935843] TCP: reno registered

[    8.937972] UDP hash table entries: 512 (order: 2, 16384 bytes)

[    8.940945] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)

[    8.944084] NET: Registered protocol family 1

[    8.946580] pci 0000:00:00.0: Limiting direct PCI/PCI transfers

[    8.949542] pci 0000:00:01.0: Activating ISA DMA hang workarounds

[    8.952770] Trying to unpack rootfs image as initramfs...

[    9.054639] Freeing initrd memory: 7204K (ffff8800371de000 - ffff8800378e7000)

[    9.059210] microcode: CPU0 sig=0x50654, pf=0x1, revision=0x2000043

[    9.062399] microcode: CPU1 sig=0x50654, pf=0x1, revision=0x2000043

[    9.065686] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba

[    9.070556] Scanning for low memory corruption every 60 seconds

[    9.073712] Initialise system trusted keyring

[    9.076302] audit: initializing netlink socket (disabled)

[    9.079100] type=2000 audit(1536091098.489:1): initialized

[    9.103801] HugeTLB registered 2 MB page size, pre-allocated 0 pages

[    9.107873] zbud: loaded

[    9.109941] VFS: Disk quotas dquot_6.5.2

[    9.112338] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)

[    9.115752] fuse init (API version 7.22)

[    9.118196] msgmni has been set to 1926

[    9.120554] Key type big_key registered

[    9.126885] Key type asymmetric registered

[    9.129279] Asymmetric key parser 'x509' registered

[    9.131917] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)

[    9.136315] io scheduler noop registered

[    9.138733] io scheduler deadline registered (default)

[    9.141476] io scheduler cfq registered

[    9.143873] pci_hotplug: PCI Hot Plug PCI Core version: 0.5

[    9.146711] pciehp: PCI Express Hot Plug Controller Driver version: 0.4

[    9.149869] ipmi message handler version 39.2

[    9.152342] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0

[    9.156877] ACPI: Power Button [PWRF]

[    9.159273] GHES: HEST is not enabled!

[    9.161645] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled

[    9.187022] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A

[    9.192618] Linux agpgart interface v0.103

[    9.196162] brd: module loaded

[    9.198814] loop: module loaded

[    9.201254] libphy: Fixed MDIO Bus: probed

[    9.203740] tun: Universal TUN/TAP device driver, 1.6

[    9.206440] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>

[    9.209455] PPP generic driver version 2.4.2

[    9.211920] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver

[    9.214965] ehci-pci: EHCI PCI platform driver

[    9.217557] ehci-platform: EHCI generic platform driver

[    9.220273] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver

[    9.223228] ohci-pci: OHCI PCI platform driver

[    9.225666] ohci-platform: OHCI generic platform driver

[    9.228362] uhci_hcd: USB Universal Host Controller Interface driver

[    9.231577] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12

[    9.236392] i8042: Warning: Keylock active

[   10.380973] serio: i8042 KBD port at 0x60,0x64 irq 1

[   10.383838] mousedev: PS/2 mouse device common for all mice

[   10.386964] rtc_cmos 00:00: RTC can wake from S4

[   10.390153] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0

[   10.393250] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram

[   10.396316] device-mapper: uevent: version 1.0.3

[   10.398931] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel@redhat.com

[   10.403459] ledtrig-cpu: registered to indicate activity on CPUs

[   10.406546] TCP: cubic registered

[   10.408674] NET: Registered protocol family 10

[   10.411160] NET: Registered protocol family 17

[   10.413556] Key type dns_resolver registered

[   10.416146] Loading compiled-in X.509 certificates

[   10.419213] Loaded X.509 cert 'Magrathea: Glacier signing key: 4a0822c0b49428c1d91d265d12340260c61c8908'

[   10.424175] registered taskstats version 1

[   10.427891] Key type trusted registered

[   10.432409] Key type encrypted registered

[   10.434716] AppArmor: AppArmor sha1 policy hashing enabled

[   10.437534] IMA: No TPM chip found, activating TPM-bypass!

[   10.440467] regulator-dummy: disabling

[   10.442765]   Magic number: 2:776:1000

[   10.445022] i8042 aux 00:02: hash matches

[   10.447517] rtc_cmos 00:00: setting system clock to 2018-09-04 19:58:20 UTC (1536091100)

[   10.452098] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found

[   10.454960] EDD information not available.

[   10.458834] Freeing unused kernel memory: 1340K (ffffffff81d20000 - ffffffff81e6f000)

[   10.463301] Write protecting the kernel read-only data: 12288k

[   10.466393] Freeing unused kernel memory: 744K (ffff880001746000 - ffff880001800000)

[   10.472144] Freeing unused kernel memory: 672K (ffff880001b58000 - ffff880001c00000)

Loading, please wait...

[   10.487075] systemd-udevd[103]: starting version 204

[   10.500370] ena: Elastic Network Adapter (ENA) v1.2.0k

[   10.506134] ena 0000:00:05.0: Elastic Network Adapter (ENA) v1.2.0k

[   10.609756] ena: ena device version: 0.10

[   10.612137] ena: ena controller version: 0.0.1 implementation version 1

[   10.886205] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1

[   11.341780] ena 0000:00:05.0: creating 2 io queues. queue size: 1024

[   11.347792] ena 0000:00:05.0: Elastic Network Adapter (ENA) found at mem febf4000, mac addr 02:12:05:f8:97:82 Queues 2

[   11.353517] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11

[   11.566033]  nvme0n1: p1

Begin: Loading essential drivers ... done.


Begin: Running /scripts/init-premount ... done.


Begin: Mounting root file system ... Begin: Running /scripts/local-top ... done.


Begin: Running /scripts/local-premount ... done.


[   14.632201] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null)

Begin: Running /scripts/local-bottom ... done.


done.


Begin: Running /scripts/init-bottom ... done.


[   17.099229] random: init urandom read with 27 bits of entropy available

 * Stopping Send an event to indicate plymouth is up[74G[ OK ]


 * Starting Mount filesystems on boot[74G[ OK ]


 * Starting Fix-up sensitive /proc filesystem entries[74G[ OK ]


 * Starting Populate /dev filesystem[74G[ OK ]


 * Starting Populate and link to /run filesystem[74G[ OK ]


 * Stopping Fix-up sensitive /proc filesystem entries[74G[ OK ]


 * Stopping Populate and link to /run filesystem[74G[ OK ]


 * Stopping Populate /dev filesystem[74G[ OK ]


 * Stopping Track if upstart is running in a container[74G[ OK ]


[   18.429286] EXT4-fs (nvme0n1p1): re-mounted. Opts: (null)

 * Starting Signal sysvinit that the rootfs is mounted[74G[ OK ]


 * Starting Clean /tmp directory[74G[ OK ]


 * Starting Initialize or finalize resolvconf[74G[ OK ]


 * Stopping Clean /tmp directory[74G[ OK ]


Cloud-init v. 0.7.5 running 'init-local' at Tue, 04 Sep 2018 19:58:31 +0000. Up 13.01 seconds.


cloud-init-nonet[14.17]: waiting 10 seconds for network device


 * Starting Signal sysvinit that virtual filesystems are mounted[74G[ OK ]


 * Starting Signal sysvinit that virtual filesystems are mounted[74G[ OK ]


 * Starting Bridge udev events into upstart[74G[ OK ]


 * Starting Signal sysvinit that remote filesystems are mounted[74G[ OK ]


 * Starting device node and kernel event manager[74G[ OK ]


 * Starting load modules from /etc/modules[74G[ OK ]


 * Starting cold plug devices[74G[ OK ]


 * Starting log initial device creation[74G[ OK ]


 * Stopping load modules from /etc/modules[74G[ OK ]


 * Starting Uncomplicated firewall[74G[ OK ]


 * Starting configure network device security[74G[ OK ]


 * Starting configure network device security[74G[ OK ]


 * Starting Mount network filesystems[74G[ OK ]


 * Stopping Mount network filesystems[74G[ OK ]


 * Starting Bridge socket events into upstart[74G[ OK ]


 * Starting configure network device[74G[ OK ]


 * Starting Mount network filesystems[74G[ OK ]


 * Stopping Mount network filesystems[74G[ OK ]


cloud-init-nonet[16.53]: static networking is now up


 * Starting configure network device[74G[ OK ]


Cloud-init v. 0.7.5 running 'init' at Tue, 04 Sep 2018 19:58:35 +0000. Up 17.03 seconds.


ci-info: +++++++++++++++++++++++++++Net device info+++++++++++++++++++++++++++


ci-info: +--------+------+---------------+---------------+-------------------+


ci-info: | Device |  Up  |    Address    |      Mask     |     Hw-Address    |


ci-info: +--------+------+---------------+---------------+-------------------+


ci-info: |   lo   | True |   127.0.0.1   |   255.0.0.0   |         .         |


ci-info: |  eth0  | True | 10.100.10.237 | 255.255.255.0 | 02:12:05:f8:97:82 |


ci-info: +--------+------+---------------+---------------+-------------------+


ci-info: +++++++++++++++++++++++++++++++Route info++++++++++++++++++++++++++++++++


ci-info: +-------+-------------+-------------+---------------+-----------+-------+


ci-info: | Route | Destination |   Gateway   |    Genmask    | Interface | Flags |


ci-info: +-------+-------------+-------------+---------------+-----------+-------+


ci-info: |   0   |   0.0.0.0   | 10.100.10.1 |    0.0.0.0    |    eth0   |   UG  |


ci-info: |   1   | 10.100.10.0 |   0.0.0.0   | 255.255.255.0 |    eth0   |   U   |


ci-info: +-------+-------------+-------------+---------------+-----------+-------+


 * Stopping cold plug devices[74G[ OK ]


 * Stopping log initial device creation[74G[ OK ]


 * Starting load fallback graphics devices[74G[ OK ]


 * Stopping load fallback graphics devices[74G[ OK ]


 * Starting enable remaining boot-time encrypted block devices[74G[ OK ]


Generating public/private rsa key pair.


Your identification has been saved in /etc/ssh/ssh_host_rsa_key.


Your public key has been saved in /etc/ssh/ssh_host_rsa_key.pub.


The key fingerprint is:


b0:7a:d8:90:3e:48:0d:7b:eb:20:7d:76:b1:a8:ca:e2 root@ip-10-100-10-237


The key's randomart image is:


+--[ RSA 2048]----+


|                 |


|                 |


|  .   .          |


|   + . o         |


|  o = o S        |


| o + B o         |


|. + X =          |


|o. * +           |


|+E. .            |


+-----------------+


Generating public/private dsa key pair.


Your identification has been saved in /etc/ssh/ssh_host_dsa_key.


Your public key has been saved in /etc/ssh/ssh_host_dsa_key.pub.


The key fingerprint is:


7c:c6:6b:54:49:25:48:0a:16:be:5f:24:75:c4:9a:dd root@ip-10-100-10-237


The key's randomart image is:


+--[ DSA 1024]----+


|      +. .o+=..  |


|     o . o.o.o   |


|      . o .+o.   |


|       o +o.. E  |


|      . S *      |


|       . = .     |


|        . o      |


|         .       |


|                 |


+-----------------+


Generating public/private ecdsa key pair.


Your identification has been saved in /etc/ssh/ssh_host_ecdsa_key.


Your public key has been saved in /etc/ssh/ssh_host_ecdsa_key.pub.


The key fingerprint is:


ad:b5:8f:05:a9:da:7e:8b:2c:06:7f:33:4b:6d:75:8b root@ip-10-100-10-237


The key's randomart image is:


+--[ECDSA  256]---+


|                 |


|                 |


|                 |


|         . .     |


|        S = . .  |


|    .    = + o . |


|     o  + + E .  |


|      +=+o.+     |


|     ..+*=o..    |


+-----------------+


Generating public/private ed25519 key pair.


Your identification has been saved in /etc/ssh/ssh_host_ed25519_key.


Your public key has been saved in /etc/ssh/ssh_host_ed25519_key.pub.


The key fingerprint is:


6b:bf:7d:c9:56:44:0f:bc:c9:ec:1a:7d:09:2e:21:ec root@ip-10-100-10-237


The key's randomart image is:


+--[ED25519  256--+


|             .   |


|              o .|


|        .    o =.|


|         o . .= o|


|        S . oo...|


|         E ...o.o|


|        o   .+ + |


|       . . .. =  |


|          o..o   |


+-----------------+


 * Starting Signal sysvinit that local filesystems are mounted[74G[ OK ]


 * Starting configure network device security[74G[ OK ]


 * Stopping Mount filesystems on boot[74G[ OK ]


 * Starting Flush boot log to disk[74G[ OK ]


 * Starting flush early job output to logs[74G[ OK ]


 * Stopping Failsafe Boot Delay[74G[ OK ]


 * Starting System V initialisation compatibility[74G[ OK ]


 * Stopping flush early job output to logs[74G[ OK ]


 * Starting configure virtual network devices[74G[ OK ]


 * Starting Pollinate to seed the pseudo random number generator[74G[ OK ]


 * Starting D-Bus system message bus[74G[ OK ]


 * Stopping Flush boot log to disk[74G[ OK ]


 * Stopping Pollinate to seed the pseudo random number generator[74G[ OK ]


 * Starting Bridge file events into upstart[74G[ OK ]


 * Starting SystemD login management service[74G[ OK ]


 * Starting early crypto disks...       [80G 
[74G[ OK ]


 * Starting system logging daemon[74G[ OK ]


 * Starting Handle applying cloud-config[74G[ OK ]


Skipping profile in /etc/apparmor.d/disable: usr.sbin.rsyslogd


 * Starting AppArmor profiles       [80G 
[74G[ OK ]


Cloud-init v. 0.7.5 running 'modules:config' at Tue, 04 Sep 2018 19:58:37 +0000. Up 18.89 seconds.


 * Stopping System V initialisation compatibility[74G[ OK ]


 * Starting System V runlevel compatibility[74G[ OK ]


 * Starting deferred execution scheduler[74G[ OK ]


 * Starting regular background program processing daemon[74G[ OK ]


 * Starting ACPI daemon[74G[ OK ]


 * Starting save kernel messages[74G[ OK ]


 * Stopping save kernel messages[74G[ OK ]


 * Starting CPU interrupts balancing daemon[74G[ OK ]


 * Starting automatic crash report generation[74G[ OK ]


Starting redis-server: redis-server.


 * Starting OpenSSH server[74G[ OK ]


open-vm-tools: not starting as this is not a VMware VM


landscape-client is not configured, please run landscape-config.


 * Restoring resolver state...       [80G 
[74G[ OK ]


 * Stopping System V runlevel compatibility[74G[ OK ]


Generating locales...




Ubuntu 14.04.5 LTS ip-10-100-10-237 ttyS0



ip-10-100-10-237 login:   en_US.UTF-8... up-to-date
Generation complete.
Cloud-init v. 0.7.5 running 'modules:final' at Tue, 04 Sep 2018 19:58:40 +0000. Up 21.66 seconds.
ci-info: +++++++++++++++++++++++Authorized keys from /home/ubuntu/.ssh/authorized_keys for user ubuntu++++++++++++++++++++++++
ci-info: +---------+-------------------------------------------------+---------+---------------------------------------------+
ci-info: | Keytype |                Fingerprint (md5)                | Options |                   Comment                   |
ci-info: +---------+-------------------------------------------------+---------+---------------------------------------------+
ci-info: | ssh-rsa | 4c:73:9d:e5:f4:60:09:77:2e:09:1e:52:e3:79:78:26 |    -    | packer 5b8e2fbf-372c-b3c9-32b3-b01e379e886d |
ci-info: | ssh-rsa | d6:94:ef:4e:e0:26:35:50:a0:72:8c:13:e9:f5:b8:6d |    -    |             spinnaker_developer             |
ci-info: +---------+-------------------------------------------------+---------+---------------------------------------------+
ec2: 
ec2: #############################################################
ec2: -----BEGIN SSH HOST KEY FINGERPRINTS-----
ec2: 1024 7c:c6:6b:54:49:25:48:0a:16:be:5f:24:75:c4:9a:dd  root@ip-10-100-10-237 (DSA)
ec2: 256 ad:b5:8f:05:a9:da:7e:8b:2c:06:7f:33:4b:6d:75:8b  root@ip-10-100-10-237 (ECDSA)
ec2: 256 6b:bf:7d:c9:56:44:0f:bc:c9:ec:1a:7d:09:2e:21:ec  root@ip-10-100-10-237 (ED25519)
ec2: 2048 b0:7a:d8:90:3e:48:0d:7b:eb:20:7d:76:b1:a8:ca:e2  root@ip-10-100-10-237 (RSA)
ec2: -----END SSH HOST KEY FINGERPRINTS-----
ec2: #############################################################
-----BEGIN SSH HOST KEY KEYS-----
ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPpr+er3f3udgTXl6EPI+7KGx6TXD6uSDR2iwHifbA/rgJqMHVg8Ziq+0dQ1jn6Upu1OgReLw+OG91rLAB+lHNY= root@ip-10-100-10-237
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGH5fGgBdTgC1nD8E/TekwJAet/K4f1f8DiBiQ4NYry/ root@ip-10-100-10-237
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpCdv92wqd3FA503SQRIyr3vPAV2jBzlulqfdMFh8KMlLcJ5Myk5SLPZqxM9BVsCpNttEIFWAArKalPLg4Od6JuBQEI0EzhxWELE7kH/92urWy1VA1lWquWQnNNC0JXqqsZlUZ1PWcbCqRVBwQntKL30KY2GD3J4AfvcVljxCOJcBOej5YIAsapMqJVb95ouIbrVCLV1DUjkTy60XoUtmGmkLGoGea798Ux9MWSk6J+nyCB0jSOYVYjeaajv4ioyrkXumO4/7JoQCxfcAKk9vtMN+jNU6tnrfP+KmcrPJBxf3tAuycPrkVVMJW2fxXgsmAWgOTJpgRnkg4SNm025nR root@ip-10-100-10-237
-----END SSH HOST KEY KEYS-----
Cloud-init v. 0.7.5 finished at Tue, 04 Sep 2018 19:58:40 +0000. Datasource DataSourceEc2.  Up 21.79 seconds
```

**Failed Deploy Stage**:

```
User: arn:aws:iam::709203678428:user/SpinnakerDevelopment-SpinnakerUser-18ZQ3LBIXDZZV is not authorized to perform: iam:PassRole on resource: arn:aws:iam::709203678428:role/BaseIAMRole (Service: AmazonAutoScaling; Status Code: 403; Error Code: AccessDenied; Request ID: 0ef99eda-b012-11e8-a6f7-6b1d7fcc227f)
```

```
Invalid IamInstanceProfile: SpinnakerDevelopment-BaseIAMRole-6D9LJ9HS4PZ7 (Service: AmazonAutoScaling; Status Code: 400; Error Code: ValidationError; Request ID: 7312e684-b079-11e8-95a6-5baf58bb2ca8)
```
Solution: Input **Instance Profile ARN** value of `BaseIAMRole` into `Bookstore Test to Dev > Deploy stage > Advanced Settings > IAM Instance Profile` field (e.g. `arn:aws:iam::709203678428:instance-profile/BaseIAMRole`).

```
User: arn:aws:iam::709203678428:user/SpinnakerDevelopment-SpinnakerUser-18ZQ3LBIXDZZV is not authorized to perform: iam:PassRole on resource: arn:aws:iam::709203678428:role/BaseIAMRole (Service: AmazonAutoScaling; Status Code: 403; Error Code: AccessDenied; Request ID: 01c151d9-b07c-11e8-960b-0d81eade5556)
```
Solution:

- Navigate to **AWS > IAM > Users > SpinnakerDevelopment-SpinnakerUser-18ZQ3LBIXDZZV > Permissions**.
- Expand `Spinnakerpassrole` policy and click **Edit Policy**.
- Select the **JSON** tab and you'll see the auto-generated `SpinnakerDevelopment-BaseIAMRole` listed in `Resources`.
- Add a new line for the `BaseIAMRole` we added previously, like so:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": [
                "arn:aws:iam::123456789012:role/SpinnakerDevelopment-BaseIAMRole-6D9LJ9HS4PZ7",
                "arn:aws:iam::123456789012:role/BaseIAMRole"
            ]
        }
    ]
}
```

- Click **Review policy** and then click **Save changes**.
- `Deploy` stage should now succeed.

**Failed CloudDriver**

```bash
$ systemctl list-units --state=failed
  UNIT                LOAD   ACTIVE SUB    DESCRIPTION
● clouddriver.service loaded failed failed Spinnaker Clouddriver

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.

1 loaded units listed. Pass --all to see loaded but inactive units, too.
To show all installed unit files use 'systemctl list-unit-files'.
```

## How to Deploy Chaos Monkey

1. Once your application is up and running through Spinnaker, you can 

```bash
$ chaosmonkey migrate
[16264] 2018/09/04 14:11:16 Successfully applied database migrations. Number of migrations applied:  0
[16264] 2018/09/04 14:11:16 database migration applied successfully
```

## Manual Spinnaker Installation

***TODO***: https://www.spinnaker.io/setup/install/


### Chaos Monkey + Go + MySQL 8 Authentication Error

See: [#785](https://github.com/go-sql-driver/mysql/issues/785)

```
[ 6593] 2018/09/04 13:26:03 ERROR - couldn't apply database migration: database migration failed: this authentication plugin is not supported
```

Solution: Add `default-authentication-plugin = mysql_native_password` directive to `[mysqld]` section of `/etc/mysql/mysql.conf.d/mysqld.cnf`:

```
[mysqld]
default-authentication-plugin = mysql_native_password
```

!!! Warning
  Chaos Monkey is currently *incompatible* with MySQL version 8.0 and higher.  

```
[16097] 2018/09/04 14:07:43 ERROR - couldn't apply database migration: database migration failed: Error 1298: Unknown or incorrect time zone: 'UTC'
```
Solution: Add timezone info to MySQL by executing:

```bash
$ mysql_tzinfo_to_sql /usr/share/zoneinfo/|mysql -u root mysql -p
Enter password: 
Warning: Unable to load '/usr/share/zoneinfo//iso3166.tab' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo//leap-seconds.list' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo//zone.tab' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo//zone1970.tab' as time zone. Skipping it.
```


Alter `chaosmonkey` MySQL 8 user's identification policy to `mysql_native_password`.  Note: This is inherently less secure than default policy

```bash
mysql> ALTER USER chaosmonkey@'localhost' IDENTIFIED WITH mysql_native_password by 'password';
Query OK, 0 rows affected (0.03 sec)
```

```bash
mysql> ALTER USER root@'localhost' IDENTIFIED WITH mysql_native_password by 'password';
Query OK, 0 rows affected (0.03 sec)
```

## Spinnaker Full Installation via AWS CLI

### Create AWS CloudFormation Spinnaker Stack

1. If needed, install the [AWS CLI tool](https://docs.aws.amazon.com/cli/latest/userguide/installing.html) on your machine.

!!! Tip Simplifying AWS Credentials
    You can make future AWS CLI commands easier by adding creating AWS `profiles`, which will add configuration and credentials to the local `~/.aws/credentials` file.  We'll be using two different accounts/profiles (`primary` or root AWS console account and `spinnaker-developer` as a managed account), so we can add credentials for both of these to `~/.aws/credentials` by using `aws configure --profile <profile-name>` commands:
    ```bash
    $ aws configure --profile spinnaker-developer
    AWS Access Key ID [None]: <AWS_ACCESS_KEY_ID>
    AWS Secret Access Key [None]: <AWS_SECRET_ACCESS_KEY>
    Default region name [None]: us-west-2
    Default output format [None]: text
    
    $ aws configure --profile primary
    AWS Access Key ID [None]: <AWS_ACCESS_KEY_ID>
    AWS Secret Access Key [None]: <AWS_SECRET_ACCESS_KEY>
    Default region name [None]: us-west-2
    Default output format [None]: text
    ```

    In the future, simply add the `--profile <profile-name>` flag to any AWS CLI command to force AWS CLI to use that account.

2. Download [this](https://d3079gxvs8ayeg.cloudfront.net/templates/managing.yaml) `managing.yaml` template.

```bash
$ curl -OL https://d3079gxvs8ayeg.cloudfront.net/templates/managing.yaml
```

1. Now we'll use AWS CLI to create the `spinnaker-managing-infrastructure` stack via CloudFormation.  We want to use the `primary` or managing account for this, so we'll specify the `--profile primary`, which will grab the appropriate credentials, region, and so forth:

```bash
$ aws cloudformation deploy --stack-name spinnaker-managing-infrastructure --template-file managing.yaml --parameter-overrides UseAccessKeyForAuthentication=true --capabilities CAPABILITY_NAMED_IAM --profile primary

Waiting for changeset to be created..
Waiting for stack create/update to complete
Successfully created/updated stack - spinnaker-managing-infrastructure
```

!!! Error Error: Unresolved resource dependency for `SpinnakerInstanceProfile`.
    If you receive an `Unresolved resource dependency` error while creating the `spinnaker-managing-infrastructure` stack related to the `SpinnakerInstanceProfile` you may need to edit the `managing.yaml` file and comment out the two `SpinnakerInstanceProfileArn` related lines under the `Outputs` block.
    ```bash
    # ...
    Outputs:
    # ...
    #  SpinnakerInstanceProfileArn:
    #    Value: !GetAtt SpinnakerInstanceProfile.Arn
    ```

4. Once the `spinnaker-managing-infrastructure` stack has been created open the AWS console, navigate to the `CloudFormation` service, select the **Outputs** tab of the `spinnaker-managing-infrastructure` stack.  We'll be using the `ManagingAccountId` and `AuthArn` values in the next step, which look something like the following:

| Key | Value |
| --- | --- |
| ManagingAccountId | 123456789012 |
| AuthArn | arn:aws:iam::123456789012:user/spinnaker-managing-infrastructure-SpinnakerUser-15UU17KIS3EK1 |

5. Download [this](https://d3079gxvs8ayeg.cloudfront.net/templates/managed.yaml) `managed.yaml` template.

```bash
$ curl -OL https://d3079gxvs8ayeg.cloudfront.net/templates/managed.yaml
```

6. Now enter the following command to create the companion `spinnaker-managed-infrastructure` stack in CloudFormation.  Be sure to specify the appropriate **profile** value and paste the appropriate `ManagingAccountId` and `AuthArn` values from above:

```bash
$ aws cloudformation deploy --stack-name spinnaker-managed-infrastructure --template-file managed.yaml \
--capabilities CAPABILITY_NAMED_IAM --profile spinnaker-developer --parameter-overrides \
AuthArn=<ManagingStack_AuthArnValue> \
ManagingAccountId=<ManagingStack_ManagingAccountId>

Waiting for changeset to be created..
Waiting for stack create/update to complete
Successfully created/updated stack - spinnaker-managed-infrastructure
```

7. Add your AWS Access and Secret Keys to Halyard:

```bash
$ hal config provider aws edit --access-key-id <AWS_ACCESS_KEY_ID> --secret-access-key
Your AWS Secret Key.. Note that if you are baking AMI's via Rosco, you may also need to set the secret key on the AWS bakery default options.:
+ Get current deployment
  Success
+ Get the aws provider
  Success
+ Edit the aws provider
  Success
+ Successfully edited provider aws.
```

8. Add your default managing account to Spinnaker:

```bash
$ hal config provider aws account add default --account-id 123456789012 --assume-role role/spinnakerManaged --regions us-west-2
+ Get current deployment
  Success
+ Add the default account
  Success
Problems in default.provider.aws.default:
- WARNING No validation for the AWS provider has been
  implemented.

+ Successfully added account default for provider aws.
```

!!! Tip
    Spinnaker uses `accounts` added via the Halyard `hal config provider aws account` API to handle all actions performed within the specified provider (such as AWS, in this case).  For this example we'll just be using our primary managing account, but you can freely add more accounts as needed.

9. Finally, enable the AWS provider:

```bash
$ hal config provider aws enable
+ Get current deployment
  Success
+ Edit the aws provider
  Success
Problems in default.provider.aws.default:
- WARNING No validation for the AWS provider has been
  implemented.

+ Successfully enabled aws
```

### Select Installation Environment

In this step you can choose which type of environment on which you want to install Spinnaker.  Most production setups will want to use Kubernetes or another distributed solution, but for this smaller example we'll just use a local Debian installation, putting Spinnaker on the same machine that Halyard is on.

!!! Tip
    By default, Halyard should install as a local Debian environmental setup, so you shouldn't need to make any changes for the environment.  However, if you want to verify it's already configured locally you can run the `hal config deploy edit --type localdebian` command:
    ```bash
    $ hal config deploy edit --type localdebian
    + Get current deployment
      Success
    + Get the deployment environment
      Success
    - No changes supplied.
    ```

### Setup Persistent Storage for Spinnaker

1. Add `s3` storage configuration to Halyard (you'll be prompted to paste your secret key after entry).

```bash
$ hal config storage s3 edit --access-key-id <AWS_ACCESS_KEY_ID> --secret-access-key --region us-west-2
Your AWS Secret Key.:
+ Get current deployment
  Success
+ Get persistent store
  Success
Generated bucket name: spin-6d40b949-3e2d-4240-96f6-1b9467572b79
+ Edit persistent store
  Success
Problems in default.persistentStorage:
- WARNING Your deployment will most likely fail until you configure
  and enable a persistent store.

+ Successfully edited persistent store "s3".
```

2. Tell halyard to use `--type s3` storage:

```bash
$ hal config storage edit --type s3
+ Get current deployment
  Success
+ Get persistent storage settings
  Success
+ Edit persistent storage settings
  Success
+ Successfully edited persistent storage.
```

### Deploy Spinnaker

1. Use the `hal version list` command to view the current Spinnaker version list:

```bash
$ hal version list
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

2. Configure halyard to use version `1.9.2` of Spinnaker:

```bash
$ hal config version edit --version 1.9.2
+ Get current deployment
  Success
+ Edit Spinnaker version
  Success
+ Spinnaker has been configured to update/install version "1.9.2".
  Deploy this version of Spinnaker with `hal deploy apply`.
```

3. Add Chaos Monkey enabled flag to halyard config:

```bash
$ hal config features edit --chaos true
+ Get current deployment
  Success
+ Get features
  Success
+ Edit features
  Success
+ Successfully updated features.
```

4. Now use `sudo hal deploy apply` to deploy Spinnaker to the local machine:

```bash
$ sudo hal deploy apply

+ Get current deployment
  Success
+ Prep deployment
  Success
Problems in default.provider.aws.spinnaker-developer:
- WARNING No validation for the AWS provider has been
  implemented.

+ Preparation complete... deploying Spinnaker
+ Get current deployment
  Success
+ Apply deployment
  Success
+ Run `hal deploy connect` to connect to Spinnaker.
...
```

5. After deployment finishes you should have a functioning Spinnaker installation!  Navigate to [localhost:9000](http://localhost:9000) to see it in action.  If necessary, you may need to setup an SSH tunnel to the Halyard/Spinnaker EC2 instance.

## Spinnaker Full Installation

### Install Halyard

https://www.spinnaker.io/setup/install/halyard/

1. Download Halyard installation script.
    - For Debian/Ubuntu: `$ curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh`
    - For MacOS: `$ curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/macos/InstallHalyard.sh`
2. Install Halyard: `$ sudo bash InstallHalyard.sh`
    - If prompted, default values are typically OK.
3. Source your `.bashrc` file by inputting: `$ . ~/.bashrc`.
4. Verify Halyard was installed by checking the version.

```bash
$ hal -v
1.9.1-20180830145737
```

### Create AWS CloudFormation Spinnaker Stack

1. In AWS navigate to **CloudFormation** and click **Create Stack**.
2. Download [this](https://d3079gxvs8ayeg.cloudfront.net/templates/managing.yaml) `managing.yaml` file to your local machine.
3. Under **Choose a template** click the **Choose File** button under **Upload a template to Amazon S3** and select the downloaded `managing.yaml`.
4. Click **Next**.
5. Input `spinnaker-managing-infrastructure-setup` into the **Stack name** field.
6. Select `false` in the **UseAccessKeyForAuthentication** dropdown.
7. Click **Next**.
8. On the **Options** screen leave defaults and click **Next**, again.
9. Check the **I acknowledge that AWS CloudFormation might create IAM resources with custom names.** checkbox and click **Create** to generate the stack.
    - *Note: If your AWS account already contains the `BaseIAMRole` AWS::IAM::ROLE you may have to delete it before this template will succeed.*
10. Once the `spinnaker-managing-infrastructure-setup` stack has a `CREATE_COMPLETE` **Status**, select the **Outputs** tab and copy all `key/value` pairs there somewhere convenient.  They'll look something like the following:

| Key | Value |
| --- | --- |
| VpcId | vpc-0eff1ddd5f7b26ffc |
| ManagingAccountId | 123456789012 |
| AuthArn | arn:aws:iam::123456789012:role/SpinnakerAuthRole |
| SpinnakerInstanceProfileArn | arn:aws:iam::123456789012:instance-profile/spinnaker-managing-infrastructure-setup-SpinnakerInstanceProfile-1M72QQCCLNCZ9 |
| SubnetIds | subnet-0c5fb1e7ab00f20a7,subnet-065af1a1830937f86 |

11. Add a new AWS account to halyard named `spinnaker-developer` with your AWS account id and your appropriate AWS region name:

```bash
$ hal config provider aws account add spinnaker-developer \
  --account-id 123456789012 \
  --assume-role role/spinnakerManaged \
  --regions us-west-2
+ Get current deployment
  Success
+ Add the spinnaker-developer account
  Success
Problems in default.provider.aws.spinnaker-developer:
- WARNING No validation for the AWS provider has been
  implemented.

+ Successfully added account spinnaker-developer for provider
  aws.
```

12. Enable AWS in halyard:

```bash
$ hal config provider aws enable
+ Get current deployment
  Success
+ Edit the aws provider
  Success
Problems in default.provider.aws.spinnaker-developer:
- WARNING No validation for the AWS provider has been
  implemented.

+ Successfully enabled aws
```

### Setup Persistent Storage for Spinnaker

1. For this example you'll need access to an `AWS::IAM::Role` with full S3 access.
    1. If necessary, navigate to **AWS > IAM > Roles** and click **Create role**.
    2. Select **AWS Service > S3** and click **Next: Permissions**.
    3. Filter policies with `S3` and select the `AmazonS3FullAccess` policy then click **Next: Review**.
    4. Input `s3-full-access` in the **Role name** field and click **Create role**.
2. Add `s3` storage configuration to halyard (you'll be prompted to paste your secret key after entry):

```bash
$ hal config storage s3 edit     --access-key-id <AWS-account-access-key-id>     --secret-access-key     --region us-west-2
Your AWS Secret Key.:
+ Get current deployment
  Success
+ Get persistent store
  Success
Generated bucket name: spin-6d40b949-3e2d-4240-96f6-1b9467572b79
+ Edit persistent store
  Success
Problems in default.persistentStorage:
- WARNING Your deployment will most likely fail until you configure
  and enable a persistent store.

+ Successfully edited persistent store "s3".
```

3. Lastly, tell halyard to use `--type s3` storage:

```bash
$ hal config storage edit --type s3
+ Get current deployment
  Success
+ Get persistent storage settings
  Success
+ Edit persistent storage settings
  Success
+ Successfully edited persistent storage.
```

### Deploy Spinnaker

1. Use the `hal version list` command to view the current Spinnaker version list:

```bash
$ hal version list
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

2. Configure halyard to use version `1.9.2` of Spinnaker:

```bash
$ hal config version edit --version 1.9.2
+ Get current deployment
  Success
+ Edit Spinnaker version
  Success
+ Spinnaker has been configured to update/install version "1.9.2".
  Deploy this version of Spinnaker with `hal deploy apply`.
```

3. Add Chaos Monkey enabled flag to halyard config:

```bash
$ hal config features edit --chaos true
+ Get current deployment
  Success
+ Get features
  Success
+ Edit features
  Success
+ Successfully updated features.
```

4. Now use `sudo hal deploy apply` to deploy Spinnaker to the local machine:

```bash
$ sudo hal deploy apply

+ Get current deployment
  Success
+ Prep deployment
  Success
Problems in default.provider.aws.spinnaker-developer:
- WARNING No validation for the AWS provider has been
  implemented.

+ Preparation complete... deploying Spinnaker
+ Get current deployment
  Success
+ Apply deployment
  Success
+ Run `hal deploy connect` to connect to Spinnaker.
...
```

5. After deployment completes you should have a functioning Spinnaker installation!  Navigate to [localhost:9000](http://localhost:9000) to see it in action.  If necessary, you may need to setup an SSH tunnel to the Halyard/Spinnaker EC2 instance.

### Create Spinnaker Application



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