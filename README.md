## Inputs

### Shared

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

### AWS

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_region | Region to be used | string | `"us-west-2"` | no |
| bootstrap\_instance\_type | [BOOTSTRAP] Machine type | string | `"m5.large"` | no |
| master\_instance\_type | [MASTERS] Machine type | string | `"m5.2xlarge"` | no |
| private\_agent\_instance\_type | [PRIVATE AGENTS] Machine type | string | `"m5.2xlarge"` | no |
| public\_agent\_instance\_type | [PUBLIC AGENTS] Machine type | string | `"m5.2xlarge"` | no |

### GCP
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
