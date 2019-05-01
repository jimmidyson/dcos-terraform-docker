variable "cluster_name" {
  description = "Name of the DC/OS cluster"
  default     = "mydcoscluster"
}

variable "cluster_name_random_string" {
  description = "Add a random string to the cluster name"
  default     = true
}

variable "dcos_install_mode" {
  description = "specifies which type of command to execute. Options: install or upgrade"
  default     = "install"
}

variable "dcos_version" {
  default     = "1.12.3"
  description = "specifies which dcos version instruction to use. Options: `1.9.0`, `1.8.8`, etc. _See [dcos_download_path](https://github.com/dcos/tf_dcos_core/blob/master/download-variables.tf) or [dcos_version](https://github.com/dcos/tf_dcos_core/tree/master/dcos-versions) tree for a full list._"
}

variable "dcos_variant" {
  default = "open"
}

variable "dcos_ee_license_file" {
  default     = ""
  description = "[Enterprise DC/OS] used to privide the license key of DC/OS for Enterprise Edition."
}

variable "dcos_security" {
  default     = "permissive"
  description = "[Enterprise DC/OS] set the security level of DC/OS. Default is strict. (recommended)"
}

variable "dcos_config" {
  default     = ""
  description = "used to add any extra arguments in the config.yaml that are not specified here. (optional)"
}

variable "instance_os" {
  description = "Operating system to use."
  default     = "centos_7.5"
}

variable "num_of_public_agents" {
  default = "0"
}

variable "num_of_private_agents" {
  default = "3"
}

variable "num_of_masters" {
  default     = "1"
  description = "set the num of master nodes (required with exhibitor_storage_backend set to aws_s3, azure, ZooKeeper)"
}

variable "admin_ips" {
  description = "List of CIDR admin IPs (space separated)"
  default     = ""
}

variable "ssh_public_key_file" {
  description = "Path to SSH public key. This is mandatory."
}

variable "public_agents_additional_ports" {
  description = "List of additional ports allowed for public access on public agents (80 and 443 open by default)"
  default     = []
}

variable "dcos_superuser_username" {
  default     = ""
  description = "[Enterprise DC/OS] set the superuser username (recommended)"
}

variable "dcos_superuser_password_hash" {
  default     = ""
  description = "[Enterprise DC/OS] set the superuser password hash (recommended)"
}
