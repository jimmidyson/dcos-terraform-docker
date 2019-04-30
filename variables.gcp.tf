variable "gcp_credentials" {
  description = "Either the path to or the contents of a service account key file in JSON format. You can manage key files using the Cloud Console."
  default = ""
}

variable "gcp_project" {
  description = "The default project to manage resources in. If another project is specified on a resource, it will take precedence."
}

variable "gcp_region" {
  description = "The default region to manage resources in. If another region is specified on a regional resource, it will take precedence."
}

variable "gcp_zone" {
  description = "The default zone to manage resources in. Generally, this zone should be within the default region you specified. If another zone is specified on a zonal resource, it will take precedence."
  default = ""
}

variable "bootstrap_machine_type" {
  description = "[BOOTSTRAP] Machine type"
  default     = "n1-standard-1"
}

variable "master_machine_type" {
  description = "[MASTERS] Machine type"
  default     = "n1-standard-8"
}

variable "private_agent_machine_type" {
  description = "[PRIVATE AGENTS] Machine type"
  default     = "n1-standard-8"
}

variable "public_agent_machine_type" {
  description = "[PUBLIC AGENTS] Machine type"
  default     = "n1-standard-8"
}
