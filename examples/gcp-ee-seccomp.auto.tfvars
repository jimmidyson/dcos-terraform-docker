cluster_name = "awsdcoscluster"

cluster_name_random_string = true

dcos_version = "1.12.3"

dcos_variant = "ee"

dcos_license_key_file = "/PATH/TO/DCOS_EE_LICENSE_FILE.txt"

dcos_security = "strict"

dcos_config = <<EOF
mesos_seccomp_enabled: 'true'
mesos_seccomp_profile_name: default.json
EOF

dcos_instance_os = "centos_7.5"

num_public_agents = "0"

num_private_agents = "3"

num_masters = "1"

ssh_public_key_file = "/PATH/TO/PUBLIC_SSH_KEY.pub"

bootstrap_machine_type = "n1-standard-1"

master_machine_type = "n1-standard-8"

private_agents_machine_type = "n1-standard-8"

public_agents_machine_type = "n1-standard-8"
