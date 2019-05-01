cluster_name = "awsdcoscluster"

cluster_name_random_string = true

dcos_version = "1.12.3"

dcos_variant = "ee"

dcos_ee_license_file = "/PATH/TO/DCOS_EE_LICENSE_FILE.txt"

dcos_security = "strict"

instance_os = "centos_7.5"

num_of_public_agents = "0"

num_of_private_agents = "3"

num_of_masters = "1"

ssh_public_key_file = "/PATH/TO/PUBLIC_SSH_KEY.pub"

aws_region = "us-west-2"

bootstrap_machine_type = "n1-standard-1"

master_machine_type = "n1-standard-8"

private_agent_machine_type = "n1-standard-8"

public_agent_machine_type = "n1-standard-8"
