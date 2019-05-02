variable "dcos_license_key_file" {
  default     = ""
  description = "[Enterprise DC/OS] used to privide the license key of DC/OS for Enterprise Edition. Optional if dcos_license_key_contents is set or license.txt is present on bootstrap node."
}

variable "admin_ips" {
  description = "List of CIDR admin IPs (comma separated string)"
  default     = ""
}
