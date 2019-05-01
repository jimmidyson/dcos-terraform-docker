# Run DC/OS Terraform (Universal Installer) in a Docker container

## Usage

The following steps create a DC/OS Open cluster on AWS.

1. Create a variable definition file ending in `.auto.tfvars`, e.g. `aws-open.auto.tfvars` (check the `examples` directory for some inspiration). A minimal example for DC/OS Open on AWS is:
    ```
    cluster_name = "mydcosopencluster"
    ssh_public_key_file = "/tmp/.ssh/SSH_KEY.pub"
    aws_region = "us-west-2"
    ```
1. Ensure that you are logged in to AWS CLI.
1. Run the Docker container to create the cluster:
    ```
    $ mkdir -p tfstate
    $ docker run --rm -it -u $(id -u):$(id -g) \
      -v ~/.aws:/tmp/aws \
      -v ~/.ssh:/tmp/.ssh \
      -v $(realpath aws-open.auto.tfvars):/dcos-terraform/aws-open.auto.tfvars \
      -v $(realpath tfstate):/dcos-terraform/tfstate \
      -e AWS_SHARED_CREDENTIALS_FILE=/tmp/aws/credentials \
      -e SSH_PRIVATE_KEY_FILE=/tmp/.ssh/SSH_KEY \
      -e AWS_PROFILE=your_aws_profile \
      mesosphere/dcos-terraform-aws:v0.2.1 apply -auto-approve -state=tfstate/terraform.tfstate
    ```
1. When ready to destroy the cluster, run the Docker container again:
    ```
    $ docker run --rm -it -u $(id -u):$(id -g) \
      -v ~/.aws:/tmp/aws \
      -v $(realpath aws-open.auto.tfvars):/dcos-terraform/aws-open.auto.tfvars \
      -v $(realpath tfstate):/dcos-terraform/tfstate \
      -e AWS_SHARED_CREDENTIALS_FILE=/tmp/aws/credentials \
      -e SSH_PRIVATE_KEY_FILE=/PATH/TO/PRIVATE_SSH_KEY \
      mesosphere/dcos-terraform-aws:v0.2.1 destroy -auto-approve -state=tfstate/terraform.tfstate
    ```

## More examples

The following examples show the minimal configuration required to create a DC/OS cluster with various requirements.

### DC/OS EE on AWS

```
cluster_name = "mydcosopencluster"
ssh_public_key_file = "/tmp/.ssh/SSH_KEY.pub"
aws_region = "us-west-2"
dcos_variant = "ee"
dcos_ee_license_file = "/tmp/dcos_ee_license_file.txt
dcos_security = "strict"
```

```
$ mkdir -p tfstate
$ docker run --rm -it -u $(id -u):$(id -g) \
  -v ~/.aws:/tmp/aws \
  -v ~/.ssh:/tmp/.ssh \
  -v $(realpath aws-ee.auto.tfvars):/dcos-terraform/aws-ee.auto.tfvars \
  -v $(realpath tfstate):/dcos-terraform/tfstate \
  -e AWS_SHARED_CREDENTIALS_FILE=/tmp/aws/credentials \
  -e SSH_PRIVATE_KEY_FILE=/tmp/.ssh/SSH_KEY \
  -e AWS_PROFILE=your_aws_profile \
  -v /PATH/TO/dcos_ee_license_file.txt:/tmp/dcos_ee_license_file.txt \
  mesosphere/dcos-terraform-aws:v0.2.1 apply -auto-approve -state=tfstate/terraform.tfstate
```

### DC/OS Open on GCP

```
cluster_name = "mydcosopencluster"
ssh_public_key_file = "/tmp/.ssh/SSH_KEY.pub"
gcp_project = "my-gcp-project"
gcp_region = "us-west1"
```

```
$ docker run --rm -it -u $(id -u):$(id -g) \
  -v ~/.config/gcloud/application_default_credentials.json:/tmp/application_default_credentials.json \
  -e GOOGLE_APPLICATION_CREDENTIALS=/tmp/application_default_credentials.json \
  -v ~/.ssh:/tmp/.ssh \
  -v $(realpath gcp-open.auto.tfvars):/dcos-terraform/gcp-open.auto.tfvars \
  -v $(realpath tfstate):/dcos-terraform/tfstate \
  -e SSH_PRIVATE_KEY_FILE=/tmp/.ssh/SSH_KEY \
  -e GOOGLE_PROJECT=my-gcp-project \
  -e GOOGLE_REGION=us-west1 \
  mesosphere/dcos-terraform-gcp:v0.1.5 apply -auto-approve -state=tfstate/terraform.tfstate
```

### DC/OS EE on GCP

```
cluster_name = "mydcosopencluster"
ssh_public_key_file = "/tmp/.ssh/SSH_KEY.pub"
gcp_project = "my-gcp-project"
gcp_region = "us-west1"
dcos_variant = "ee"
dcos_ee_license_file = "/tmp/dcos_ee_license_file.txt
dcos_security = "strict"
```

```
$ docker run --rm -it -u $(id -u):$(id -g) \
  -v ~/.config/gcloud/application_default_credentials.json:/tmp/application_default_credentials.json \
  -e GOOGLE_APPLICATION_CREDENTIALS=/tmp/application_default_credentials.json \
  -v ~/.ssh:/tmp/.ssh \
  -v $(realpath gcp-open.auto.tfvars):/dcos-terraform/gcp-open.auto.tfvars \
  -v $(realpath tfstate):/dcos-terraform/tfstate \
  -e SSH_PRIVATE_KEY_FILE=/tmp/.ssh/SSH_KEY \
  -e GOOGLE_PROJECT=my-gcp-project \
  -e GOOGLE_REGION=us-west1 \
  -v /PATH/TO/dcos_ee_license_file.txt:/tmp/dcos_ee_license_file.txt \
  mesosphere/dcos-terraform-gcp:v0.1.5 apply -auto-approve -state=tfstate/terraform.tfstate
```

## Configuration

### Shared inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin\_ips | List of CIDR admin IPs (space separated) | string | `""` | no |
| cluster\_name | Name of the DC/OS cluster | string | `"mydcoscluster"` | no |
| cluster\_name\_random\_string | Add a random string to the cluster name | string | `"true"` | no |
| dcos\_ee\_license\_file | [Enterprise DC/OS] used to privide the license key of DC/OS for Enterprise Edition. | string | `""` | no |
| dcos\_security | [Enterprise DC/OS] set the security level of DC/OS. Default is strict. (recommended) | string | `"permissive"` | no |
| dcos\_superuser\_password\_hash | [Enterprise DC/OS] set the superuser password hash (recommended) | string | `""` | no |
| dcos\_superuser\_username | [Enterprise DC/OS] set the superuser username (recommended) | string | `""` | no |
| dcos\_variant |  | string | `"open"` | no |
| dcos\_version | specifies which dcos version instruction to use. Options: `1.9.0`, `1.8.8`, etc. _See [dcos_download_path](https://github.com/dcos/tf_dcos_core/blob/master/download-variables.tf) or [dcos_version](https://github.com/dcos/tf_dcos_core/tree/master/dcos-versions) tree for a full list._ | string | `"1.12.3"` | no |
| instance\_os | Operating system to use. | string | `"centos_7.5"` | no |
| num\_of\_masters | set the num of master nodes (required with exhibitor_storage_backend set to aws_s3, azure, ZooKeeper) | string | `"1"` | no |
| num\_of\_private\_agents |  | string | `"4"` | no |
| num\_of\_public\_agents |  | string | `"0"` | no |
| public\_agents\_additional\_ports | List of additional ports allowed for public access on public agents (80 and 443 open by default) | list | `<list>` | no |
| ssh\_public\_key\_file | Path to SSH public key. This is mandatory. | string | | yes |

### AWS inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_region | Region to be used | string | `"us-west-2"` | no |
| bootstrap\_instance\_type | [BOOTSTRAP] Machine type | string | `"m5.large"` | no |
| master\_instance\_type | [MASTERS] Machine type | string | `"m5.2xlarge"` | no |
| private\_agent\_instance\_type | [PRIVATE AGENTS] Machine type | string | `"m5.2xlarge"` | no |
| public\_agent\_instance\_type | [PUBLIC AGENTS] Machine type | string | `"m5.2xlarge"` | no |

### GCP inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bootstrap\_machine\_type | [BOOTSTRAP] Machine type | string | `"n1-standard-1"` | no |
| gcp\_credentials | Either the path to or the contents of a service account key file in JSON format. You can manage key files using the Cloud Console. | string | `""` | no |
| gcp\_project | The default project to manage resources in. If another project is specified on a resource, it will take precedence. | string | | yes |
| gcp\_region | The default region to manage resources in. If another region is specified on a regional resource, it will take precedence. | string | | yes |
| gcp\_zone | The default zone to manage resources in. Generally, this zone should be within the default region you specified. If another zone is specified on a zonal resource, it will take precedence. | string | `""` | no |
| master\_machine\_type | [MASTERS] Machine type | string | `"n1-standard-8"` | no |
| private\_agent\_machine\_type | [PRIVATE AGENTS] Machine type | string | `"n1-standard-8"` | no |
| public\_agent\_machine\_type | [PUBLIC AGENTS] Machine type | string | `"n1-standard-8"` | no |

### Outputs

| Name | Description |
|------|-------------|
| cluster-address |  |
| masters-ips |  |
| public-agents-loadbalancer |  |
