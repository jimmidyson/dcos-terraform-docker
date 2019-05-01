data "http" "whatismyip" {
  url = "http://whatismyip.akamai.com/"
}

locals {
  dcos_admin_ips = "${split(" ", var.admin_ips == "" ? "${data.http.whatismyip.body}/32" : var.admin_ips)}"

  empty_ee_license_file_path = "${path.module}/empty_ee_license_file.txt"
  dcos_ee_license_file_path  = "${var.dcos_ee_license_file == "" ? local.empty_ee_license_file_path : var.dcos_ee_license_file}"
}

provider "google" {
  version = "~> 1.18"

  credentials = "${var.gcp_credentials}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
  zone        = "${var.gcp_zone}"
}

module "dcos" {
  source  = "dcos-terraform/dcos/gcp"
  version = "__DCOS_TERRAFORM_MODULE_VERSION__"

  providers = {
    google = "google"
  }

  cluster_name               = "${var.cluster_name}"
  cluster_name_random_string = "${var.cluster_name_random_string}"

  num_masters        = "${var.num_of_masters}"
  num_private_agents = "${var.num_of_private_agents}"
  num_public_agents  = "${var.num_of_public_agents}"

  dcos_version              = "${var.dcos_version}"
  dcos_install_mode         = "${var.dcos_install_mode}"
  dcos_variant              = "${var.dcos_variant}"
  dcos_security             = "${var.dcos_security}"
  dcos_instance_os          = "${var.instance_os}"
  dcos_license_key_contents = "${file(local.dcos_ee_license_file_path)}"

  bootstrap_machine_type      = "${var.bootstrap_machine_type}"
  masters_machine_type        = "${var.master_machine_type}"
  private_agents_machine_type = "${var.private_agent_machine_type}"
  public_agents_machine_type  = "${var.public_agent_machine_type}"

  admin_ips           = "${local.dcos_admin_ips}"
  ssh_public_key_file = "${var.ssh_public_key_file}"

  public_agents_additional_ports = "${var.public_agents_additional_ports}"

  dcos_resolvers = <<EOF
# YAML
  - 169.254.169.254
EOF
}
