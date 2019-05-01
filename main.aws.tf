data "http" "whatismyip" {
  url = "http://whatismyip.akamai.com/"
}

locals {
  dcos_admin_ips = "${split(" ", var.admin_ips == "" ? "${data.http.whatismyip.body}/32" : var.admin_ips)}"

  empty_ee_license_file_path = "${path.module}/empty_ee_license_file.txt"
  dcos_ee_license_file_path  = "${var.dcos_ee_license_file == "" ? local.empty_ee_license_file_path : var.dcos_ee_license_file}"
}

provider "aws" {
  region = "${var.aws_region}"
}

module "dcos" {
  source  = "dcos-terraform/dcos/aws"
  version = "__DCOS_TERRAFORM_MODULE_VERSION__"

  providers = {
    aws = "aws"
  }

  cluster_name               = "${var.cluster_name}"
  cluster_name_random_string = "${var.cluster_name_random_string}"

  num_masters        = "${var.num_of_masters}"
  num_private_agents = "${var.num_of_private_agents}"
  num_public_agents  = "${var.num_of_public_agents}"

  dcos_version              = "${var.dcos_version}"
  dcos_variant              = "${var.dcos_variant}"
  dcos_security             = "${var.dcos_security}"
  dcos_instance_os          = "${var.instance_os}"
  dcos_license_key_contents = "${file(local.dcos_ee_license_file_path)}"

  bootstrap_instance_type      = "${var.bootstrap_instance_type}"
  masters_instance_type        = "${var.master_instance_type}"
  private_agents_instance_type = "${var.private_agent_instance_type}"
  public_agents_instance_type  = "${var.public_agent_instance_type}"

  admin_ips           = "${local.dcos_admin_ips}"
  ssh_public_key_file = "${var.ssh_public_key_file}"

  public_agents_additional_ports = "${var.public_agents_additional_ports}"
}
