# Terraform Configuration for EC2

The [main.tf configuration](./main.tf) will set up AWS EC2 instance with

* Ubuntu 18.04 Server
* Nginx
* Jenkins

[network.tf](./network.tf) will create a new VPC, Subnet, GW and add route to routing table and add a new Security Group.


## Prerequisites:

Install them locally:

* [AWS CLI](https://aws.amazon.com/cli/)
* [Terraform](https://www.terraform.io/downloads.html)


## Variables:

region: "aws region"

amis (map): "region" = "ami_id"

aws_keys (map): access and secret keys

ssh_pubkey: SSH public key location

ssh_privkey: SSH private key location


## Example usage:

Before running it check that aws is configured

```bash
$ aws configure
```

Otherwise specify the keys in [variables.tf](./variables.tf)

```ini
    "access" = "YOUR-ACCESS-KEY"
    "secret" = "YOUR-SECRET-KEY"
```


```bash
git clone git@github.com:pavars/luminor-jenkins.git

# Make sure that keys are correct and run

terraform init
terraform apply

```
