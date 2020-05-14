variable "cluster_name" {
  description = "Name of the DC/OS cluster"
  default     = "dcos-example"
}

variable "ssh_public_key" {
  description = "SSH public key in authorized keys format (e.g. 'ssh-rsa ..') to be used with the instances. Make sure you added this key to your ssh-agent."
  default     = ""
}

variable "ssh_public_key_file" {
  description = "Path to SSH public key. This is mandatory but can be set to an empty string if you want to use ssh_public_key with the key as string."
}

variable "num_masters" {
  description = "Specify the amount of masters. For redundancy you should have at least 3"
  default     = 3
}

variable "num_private_agents" {
  description = "Specify the amount of private agents. These agents will provide your main resources"
  default     = 2
}

variable "num_public_agents" {
  description = "Specify the amount of public agents. These agents will host marathon-lb and edgelb"
  default     = 1
}

variable "labels" {
  description = "Add custom labels to all resources"
  type        = "map"
  default     = {}
}

variable "availability_zones" {
  type        = "list"
  description = "List of availability_zones to be used as the same format that are required by the platform/cloud providers. i.e `['RegionZone']`"
  default     = []
}

variable "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = "centos_7.5"
}

variable "bootstrap_gcp_image" {
  description = "[BOOTSTRAP] Image to be used"
  default     = ""
}

variable "bootstrap_os" {
  description = "[BOOTSTRAP] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "bootstrap_root_volume_size" {
  description = "[BOOTSTRAP] Root volume size in GB"
  default     = "80"
}

variable "bootstrap_root_volume_type" {
  description = "[BOOTSTRAP] Root volume type"
  default     = "pd-standard"
}

variable "bootstrap_machine_type" {
  description = "[BOOTSTRAP] Machine type"
  default     = "n1-standard-2"
}

variable "masters_gcp_image" {
  description = "[MASTERS] Image to be used"
  default     = ""
}

variable "masters_os" {
  description = "[MASTERS] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "masters_root_volume_size" {
  description = "[MASTERS] Root volume size in GB"
  default     = "120"
}

variable "masters_machine_type" {
  description = "[MASTERS] Machine type"
  default     = "n1-standard-4"
}

variable "private_agents_gcp_image" {
  description = "[PRIVATE AGENTS] Image to be used"
  default     = ""
}

variable "private_agents_os" {
  description = "[PRIVATE AGENTS] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "private_agents_root_volume_size" {
  description = "[PRIVATE AGENTS] Root volume size in GB"
  default     = "120"
}

variable "private_agents_root_volume_type" {
  description = "[PRIVATE AGENTS] Root volume type"
  default     = "pd-ssd"
}

variable "private_agents_machine_type" {
  description = "[PRIVATE AGENTS] Machine type"
  default     = "n1-standard-4"
}

variable "public_agents_gcp_image" {
  description = "[PUBLIC AGENTS] Image to be used"
  default     = ""
}

variable "public_agents_os" {
  description = "[PUBLIC AGENTS] Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = ""
}

variable "public_agents_root_volume_size" {
  description = "[PUBLIC AGENTS] Root volume size"
  default     = "120"
}

variable "public_agents_root_volume_type" {
  description = "[PUBLIC AGENTS] Specify the root volume type."
  default     = "pd-ssd"
}

variable "public_agents_machine_type" {
  description = "[PUBLIC AGENTS] Machine type"
  default     = "n1-standard-4"
}

variable "public_agents_additional_ports" {
  description = "List of additional ports allowed for public access on public agents (80 and 443 open by default)"
  default     = []
}

variable "public_agents_access_ips" {
  description = "List of ips allowed access to public agents. admin_ips are joined to this list"
  type        = "list"
  default     = ["0.0.0.0/0"]
}

variable "cluster_name_random_string" {
  description = "Add a random string to the cluster name"
  default     = false
}

variable "accepted_internal_networks" {
  description = "Subnet ranges for all internal networks"
  type        = "list"
  default     = []
}

variable "subnet_range" {
  description = "Private IP space to be used in CIDR format"
  default     = "172.16.0.0/16"
}

variable "additional_public_agent_ips" {
  description = "Additional public agent IPs."
  default     = []
}

variable "additional_private_agent_ips" {
  description = "Additional private agent IPs."
  default     = []
}

variable "ansible_bundled_container" {
  default     = "mesosphere/dcos-ansible-bundle:latest"
  description = "Docker container with bundled dcos-ansible and ansible executables"
}

variable "ansible_additional_config" {
  default     = ""
  description = "Add additional config options to ansible. This is getting merged with generated defaults. Do not specify `dcos:`"
}
