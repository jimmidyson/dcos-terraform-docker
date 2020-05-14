output "masters-ips" {
  description = "Master IP addresses"
  value       = "${module.dcos.masters-ips}"
}

output "masters-loadbalancer" {
  description = "This is the load balancer address to access the DC/OS UI"
  value       = "${module.dcos.masters-loadbalancer}"
}

output "masters-internal-loadbalancer" {
  description = "This is the internal load balancer address to access the DC/OS Services"
  value       = "${module.dcos.masters-internal-loadbalancer}"
}

output "public-agents-loadbalancer" {
  description = "This is the load balancer address to access the DC/OS public agents"
  value       = "${module.dcos.public-agents-loadbalancer}"
}

output "config" {
  description = "The battle-tested provisioner contents of the output by DC/OS role to perform requried admin actions in behalf of the user as documented in http://mesosphere.com and http://dcos.io"
  value       = "${module.dcos.config}"
}
