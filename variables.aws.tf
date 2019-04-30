variable "aws_region" {
  description = "Region to be used"
  default = "us-west-2"
}

variable "bootstrap_instance_type" {
  description = "[BOOTSTRAP] Machine type"
  default     = "m5.large"
}

variable "master_instance_type" {
  description = "[MASTERS] Machine type"
  default     = "m5.2xlarge"
}

variable "private_agent_instance_type" {
  description = "[PRIVATE AGENTS] Machine type"
  default     = "m5.2xlarge"
}

variable "public_agent_instance_type" {
  description = "[PUBLIC AGENTS] Machine type"
  default     = "m5.2xlarge"
}
