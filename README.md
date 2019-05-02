# Run DC/OS Terraform (Universal Installer) in a Docker container

## Usage

The following steps create a DC/OS Open cluster on AWS.

1. Create a variable definition file ending in `.auto.tfvars`, e.g. `aws-open.auto.tfvars` (check the `examples` directory for some inspiration). A minimal example for DC/OS Open on AWS is:

    ```hcl
    cluster_name = "mydcosopencluster"
    ssh_public_key_file = "/tmp/.ssh/SSH_KEY.pub"
    ```

1. Ensure that you are logged in to AWS CLI.
1. Run the Docker container to create the cluster:

    ```shell
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

    ```shell
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

```hcl
cluster_name = "mydcosopencluster"
ssh_public_key_file = "/tmp/.ssh/SSH_KEY.pub"
dcos_variant = "ee"
dcos_license_key_file = "/tmp/dcos_ee_license_file.txt
dcos_security = "strict"
```

```shell
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

```hcl
cluster_name = "mydcosopencluster"
ssh_public_key_file = "/tmp/.ssh/SSH_KEY.pub"
```

```shell
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

```hcl
cluster_name = "mydcosopencluster"
ssh_public_key_file = "/tmp/.ssh/SSH_KEY.pub"
dcos_variant = "ee"
dcos_license_key_file = "/tmp/dcos_ee_license_file.txt
dcos_security = "strict"
```

```shell
$ docker run --rm -it -u $(id -u):$(id -g) \
  -v ~/.config/gcloud/application_default_credentials.json:/tmp/application_default_credentials.json \
  -e GOOGLE_APPLICATION_CREDENTIALS=/tmp/application_default_credentials.json \
  -v ~/.ssh:/tmp/.ssh \
  -v $(realpath gcp-ee.auto.tfvars):/dcos-terraform/gcp-ee.auto.tfvars \
  -v $(realpath tfstate):/dcos-terraform/tfstate \
  -e SSH_PRIVATE_KEY_FILE=/tmp/.ssh/SSH_KEY \
  -e GOOGLE_PROJECT=my-gcp-project \
  -e GOOGLE_REGION=us-west1 \
  -v /PATH/TO/dcos_ee_license_file.txt:/tmp/dcos_ee_license_file.txt \
  mesosphere/dcos-terraform-gcp:v0.1.5 apply -auto-approve -state=tfstate/terraform.tfstate
```

## Configuration

Please refer to the relevant DC/OS Terraform module documentation for available variables:

* [GCP](https://github.com/dcos-terraform/terraform-gcp-dcos)
* [AWS](https://github.com/dcos-terraform/terraform-aws-dcos)

### Helper variables

In addition to the core module configurations linked above, the following helper variables are
provided which make it slightly easier to run in a Docker container:

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| dcos\_license\_key\_file | [Enterprise DC/OS] used to privide the license key of DC/OS for Enterprise Edition. Optional if dcos_license_key_contents is set or license.txt is present on bootstrap node. | string | `""` | no |

### Outputs

| Name | Description |
|------|-------------|
| cluster-address |  |
| masters-ips |  |
| public-agents-loadbalancer |  |

## Building

To build the Docker images, run:

```shell
$ make docker.build
...
```

To build individual Docker images, run:

```shell
$ make docker.build.aws
...
$ make docker.build.gcp
...
```

Equivalent targets exist for pushing the Docker images. Push all Docker images:

```shell
$ make docker.push
...
```

Or to push individual Docker images:

```shell
$ make docker.push.aws
...
$ make docker.push.gcp
...
```
