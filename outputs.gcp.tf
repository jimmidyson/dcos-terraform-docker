output "masters-ips" {
  description = "Master IP addresses"
  value       = "${module.dcos.masters-ips}"
}

output "masters-loadbalancer" {
  description = "This is the load balancer address to access the DC/OS UI"
  value       = "${module.dcos.masters-loadbalancer}"
}

output "public-agents-loadbalancer" {
  description = "This is the load balancer address to access the DC/OS public agents"
  value       = "${module.dcos.public-agents-loadbalancer}"
}
