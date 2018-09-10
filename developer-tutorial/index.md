---
title: "Chaos Monkey Tutorial - A Step-by-Step Guide to Creating Failure on AWS"
description: "A step-by-step guide on setting up and using Chaos Monkey with AWS, and also explores specific scenarios in which Chaos Monkey may (or may not) be relevant."
path: "/chaos-monkey/developer-tutorial"
url: "https://www.gremlin.com/chaos-monkey/developer-tutorial"
sources: "See: _docs/resources.md"
published: true
---

**(TODO)**: Continue cleanup/organize sections; move some content to `advanced tips`.

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

## Deploying Spinnaker

Love it or hate it, Chaos Monkey **requires** the use of [Spinnaker.io](https://www.spinnaker.io/), which is an open-source, multi-cloud continuous delivery platform developed by Netflix.  Spinnaker allows for automated deployments across multiple cloud platforms (such as AWS, Azure, Google Cloud Platform, and more).  Spinnaker can also be used to deploy across multiple accounts and regions, often using **pipelines** that define a series of events that should occur every time a new version is released.  Spinnaker is a powerful tool, but since both Spinnaker and Chaos Monkey were developed by and for Netflix's own network architecture, you may find that trying to use Chaos Monkey and related tools is more painful than you might expect, as Spinnaker isn't perfectly suited to all organizations or applications.

That said, in this first section we'll explore the two easiest ways to get Spinnaker up and running, which will then allow you to move onto [installing](#installing-chaos-moneky) and then [using](#using-chaos-monkey).

### Rapid Spinnaker Deployment: AWS Quick Start

By far the easiest method for getting Spinnaker up and running with AWS is to use the [CloudFormation Quick Start](https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?stackName=Spinnaker&templateURL=https:%2F%2Fs3.amazonaws.com%2Faws-quickstart%2Fquickstart-spinnaker%2Ftemplates%2Fquickstart-spinnakercf.template) template.

The AWS Spinnaker Quick Start will create a simple architecture for you containing two Virtual Private Cloud (VPC) subnets (one public and one private).  The public VPC contains a [Bastion host](https://en.wikipedia.org/wiki/Bastion_host) instance designed to be strictly accessible (only port 22 is open for SSH).  The Bastion host will then allow a pass through connection to the private VPC that is running Spinnaker.

![developer-tutorial-aws-spinnaker-quick-start-architecture](../images/developer-tutorial-aws-spinnaker-quick-start-architecture.png 'AWS Spinnaker Quick Start Architecture')

*Figure 1: AWS Spinnaker Quick Start Architecture - **Courtesy of AWS***

This quick start process will take about 10 - 15 minutes and is mostly automated.

#### Creating the Spinnaker Stack

1. *(Optional)* If necessary, visit [https://aws.amazon.com/](https://aws.amazon.com/) to sign up for or login to your AWS account.
2. *(Optional)* You'll need at least one AWS EC2 Key Pair for securely connecting via SSH.  
    1. If you don't have a KeyPair already start by opening the AWS Console and navigate to **EC2 > NETWORK & SECURITY > Key Pairs**.
    2. Click **Create Key Pair** and enter an identifying name in the **Key pair name** field.
    3. Click **Create** to download the private `.pem` key file to your local system.
    4. Save this key to an appropriate location (typically your local user `~/.ssh` directory).
3. After you've signed into the AWS console visit [this page](https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?stackName=Spinnaker&templateURL=https:%2F%2Fs3.amazonaws.com%2Faws-quickstart%2Fquickstart-spinnaker%2Ftemplates%2Fquickstart-spinnakercf.template), which should load the [`quickstart-spinnakercf.template`](https://s3.amazonaws.com/aws-quickstart/quickstart-spinnaker/templates/quickstart-spinnakercf.template).
4. Click **Next**.
5. (Optional) If you haven't already done so, you'll need to create at least one AWS Access Key, which is a 
6. Select the **KeyName** of the key pair you previously created.
7. Input a secure password in the **Password** field.
8. *(Optional)* Modify the IP address range in the **SSHLocation** field to indicate what IP range is allowed to SSH into the Bastion host.  For example, if your public IP address is `1.2.3.4` you might enter `1.2.3.4/32` into this field.  If you aren't sure, you can enter `0.0.0.0/0` to allow any IP address to connect, though this is obviously less secure.
9. Click **Next**.
10. *(Optional)* Select an **IAM Role** with proper CloudFormation permissions necessary to deploy a stack.  If you aren't sure, leave this blank and deployment will use your account's permissions.
11. Modify any other fields on this screen you wish, then click **Next** to continue.
12. Check the **I acknowledge that AWS CloudFormation might create IAM resources with custom names.** checkbox and click **Create** to generate the stack.

    > warning ""
    > If your AWS account already contains the `BaseIAMRole` AWS::IAM::Role you may have to delete it before this template will succeed.

13. Once the `Spinnaker` stack has a `CREATE_COMPLETE` **Status**, select the **Outputs** tab, which has some auto-generated strings you'll need to paste in your terminal in the next section.

#### Connect to the Bastion Host

1. Copy the **Value** of the **SSHString1** field from the stack **Outputs** tab above.
2. Execute the **SSHString1** value in your terminal and enter `yes` when prompted to continue connecting to this host.

    ```bash
    ssh -A -L 9000:localhost:9000 -L 8084:localhost:8084 -L 8087:localhost:8087 ec2-user@54.244.189.78
    ```

    > error "Permission denied (publickey)."
    > If you received a permission denied SSH error you may have forgotten to place your `.pem` private key file that you downloaded from the AWS EC2 Key Pair creation page.  Make sure it is located in your `~/.ssh` user directory.  Otherwise you can specify the key by adding an optional `-i <identify_file_path>` flag, indicating the path to the `.pem` file.

3. You should now be connected as the `ec2-user` to the Bastion instance.  Before you can connect to the Spinnaker instance you'll probably need to copy your `.pem` file to the Spinnaker instance's `~/.ssh` directory.

    - Once the key is copied, make sure you set proper permissions otherwise SSH will complain.
    
        ```bash
        chmod 400 ~/.ssh/my_key.pem
        ```

#### Connect to the Spinnaker Host

1. To connect to the Spinnaker instance copy and paste the **SSHString2** **Value** into the terminal.

    ```bash
    ssh –L 9000:localhost:9000 -L 8084:localhost:8084 -L 8087:localhost:8087 ubuntu@54.218.73.7 -i ~/.ssh/my_key.pem
    ```

2. You should now be connected to the `SpinnakerWebServer`!

    > warning "System restart required"
    > Upon connecting to the Spinnaker instance you may see a message indicating the system needs to be restarted.  You can do this through the AWS EC2 console, or just enter the `sudo reboot` command in the terminal, then reconnect after a few moments.

#### Create a Spinnaker Application

**(TODO)**

### Manual Spinnaker Deployment With Halyard

**(TODO)**

### Deploying Spinnaker on AWS EKS/Kubernetes

> info ""
> Since deploying Spinnaker on a Kubernetes cluster is a fairly lengthy and complex process, you can find the full tutorial for this over in the [Advanced Developer Guide](https://www.gremlin.com/chaos-monkey/advanced-tips#how-to-deploy-spinnaker-on-aws-with-kubernetes).

## Installing Chaos Monkey

```bash
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

**(TODO)**

### Chaos Monkey + Spinnaker Setup

- Click **Config** in top-right of Spinnaker `Deck` application page.
- Select **Chaos Monkey** in side navigation. [SCREENSHOT]

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

```bash
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

```bash
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

```bash
==> amazon-ebs: Prevalidating AMI Name...
==> amazon-ebs: Inspecting the source AMI...
==> amazon-ebs: Creating temporary keypair: packer 5b8e2fbf-372c-b3c9-32b3-b01e379e886d
==> amazon-ebs: Creating temporary security group for this instance...
==> amazon-ebs: Authorizing access to port 22 the temporary security group...
==> amazon-ebs: Launching a source AWS instance...
    amazon-ebs: Instance ID: i-08d49753da1bfe24d
[...]
Build 'amazon-ebs' finished.

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:

us-west-2: ami-04c042b2789ec7760
```

**Successful Deploy Stage**:

**Cluster Instance Console Output**:

```bash
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.13.0-137-generic (buildd@lgw01-amd64-058) (gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04.3) ) #186-Ubuntu SMP Mon Dec 4 19:09:19 UTC 2017 (Ubuntu 3.13.0-137.186-generic 3.13.11-ckt39)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-3.13.0-137-generic root=UUID=08df443d-a08d-4a06-ab5b-6fdacfc684d3 ro console=tty1 console=ttyS0
[    0.000000] KERNEL supported cpus:
...
Cloud-init v. 0.7.5 finished at Tue, 04 Sep 2018 19:58:40 +0000. Datasource DataSourceEc2.  Up 21.79 seconds
```

**Failed Deploy Stage**:

```bash
User: arn:aws:iam::709203678428:user/SpinnakerDevelopment-SpinnakerUser-18ZQ3LBIXDZZV is not authorized to perform: iam:PassRole on resource: arn:aws:iam::709203678428:role/BaseIAMRole (Service: AmazonAutoScaling; Status Code: 403; Error Code: AccessDenied; Request ID: 0ef99eda-b012-11e8-a6f7-6b1d7fcc227f)
```

```bash
Invalid IamInstanceProfile: SpinnakerDevelopment-BaseIAMRole-6D9LJ9HS4PZ7 (Service: AmazonAutoScaling; Status Code: 400; Error Code: ValidationError; Request ID: 7312e684-b079-11e8-95a6-5baf58bb2ca8)
```

Solution: Input **Instance Profile ARN** value of `BaseIAMRole` into `Bookstore Test to Dev > Deploy stage > Advanced Settings > IAM Instance Profile` field (e.g. `arn:aws:iam::709203678428:instance-profile/BaseIAMRole`).

```bash
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

> warning "Warning"
> Chaos Monkey is currently *incompatible* with MySQL version 8.0 and higher.  

```
[16097] 2018/09/04 14:07:43 ERROR - couldn't apply database migration: database migration failed: Error 1298: Unknown or incorrect time zone: 'UTC'
```
Solution: Add timezone info to MySQL by executing the following command.

```bash
$ mysql_tzinfo_to_sql /usr/share/zoneinfo/|mysql -u root mysql -p
Enter password: 
Warning: Unable to load '/usr/share/zoneinfo//iso3166.tab' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo//leap-seconds.list' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo//zone.tab' as time zone. Skipping it.
Warning: Unable to load '/usr/share/zoneinfo//zone1970.tab' as time zone. Skipping it.
```

Alter `chaosmonkey` MySQL 8 user's identification policy to `mysql_native_password`.  Note: This is inherently less secure than the default policy.

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

> info "Simplifying AWS Credentials"
> You can make future AWS CLI commands easier by creating AWS `profiles`, which will add configuration and credentials to the local `~/.aws/credentials` file.  We'll be using two different accounts/profiles (`primary` or root AWS console account and `spinnaker-developer` as a managed account), so we can add credentials for both of these to `~/.aws/credentials` by using `aws configure --profile <profile-name>` commands.
> ```bash
> aws configure --profile spinnaker-developer
> AWS Access Key ID [None]: <AWS_ACCESS_KEY_ID>
> AWS Secret Access Key [None]: <AWS_SECRET_ACCESS_KEY>
> Default region name [None]: us-west-2
> Default output format [None]: text
>    
> aws configure --profile primary
> AWS Access Key ID [None]: <AWS_ACCESS_KEY_ID>
> AWS Secret Access Key [None]: <AWS_SECRET_ACCESS_KEY>
> Default region name [None]: us-west-2
> Default output format [None]: text
> ```
> 
> In the future, simply add the `--profile <profile-name>` flag to any AWS CLI command to force AWS CLI to use that account.

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

> errpr "Error: Unresolved resource dependency for `SpinnakerInstanceProfile`."
> If you receive an `Unresolved resource dependency` error while creating the `spinnaker-managing-infrastructure` stack related to the `SpinnakerInstanceProfile` you may need to edit the `managing.yaml` file and comment out the two `SpinnakerInstanceProfileArn` related lines under the `Outputs` block.
> ```bash
> # ...
> Outputs:
> # ...
> #  SpinnakerInstanceProfileArn:
> #    Value: !GetAtt SpinnakerInstanceProfile.Arn
> ```

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

> info ""
> Spinnaker uses `accounts` added via the Halyard `hal config provider aws account` API to handle all actions performed within the specified provider (such as AWS, in this case).  For this example we'll just be using our primary managing account, but you can freely add more accounts as needed.

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

> info ""
> By default, Halyard should install as a local Debian environmental setup, so you shouldn't need to make any changes for the environment.  However, if you want to verify it's already configured locally you can run the `hal config deploy edit --type localdebian` command.
> ```bash
> hal config deploy edit --type localdebian
> ```
> ```bash
> # OUTPUT
> + Get current deployment
>   Success
> + Get the deployment environment
>   Success
> - No changes supplied.
> ```

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


[/]:                                    /gremlin-chaos-monkey/
[/advanced-tips]:                       /gremlin-chaos-monkey/advanced-tips
[/alternatives]:                        /gremlin-chaos-monkey/alternatives
[/alternatives/azure]:                  /gremlin-chaos-monkey/alternatives/azure
[/alternatives/docker]:                 /gremlin-chaos-monkey/alternatives/docker
[/alternatives/google-cloud-platform]:  /gremlin-chaos-monkey/alternatives/google-cloud-platform
[/alternatives/kubernetes]:             /gremlin-chaos-monkey/alternatives/kubernetes
[/alternatives/openshift]:              /gremlin-chaos-monkey/alternatives/openshift
[/alternatives/private-cloud]:          /gremlin-chaos-monkey/alternatives/private-cloud
[/alternatives/spring-boot]:            /gremlin-chaos-monkey/alternatives/spring-boot
[/alternatives/vmware]:                 /gremlin-chaos-monkey/alternatives/vmware
[/developer-tutorial]:                  /gremlin-chaos-monkey/developer-tutorial
[/downloads-resources]:                 /gremlin-chaos-monkey/downloads-resources
[/origin-netflix]:                      /gremlin-chaos-monkey/origin-netflix
[/simian-army]:                         /gremlin-chaos-monkey/simian-army