ARG TERRAFORM_DOCKER_IMAGE=hashicorp/terraform:0.11.13
FROM ${TERRAFORM_DOCKER_IMAGE}

ENV TF_PLUGIN_CACHE_DIR /var/lib/terraform/plugin-cache
RUN mkdir -p ${TF_PLUGIN_CACHE_DIR}

WORKDIR /dcos-terraform
RUN mkdir -p /dcos-terraform/tfstate && chmod 777 /dcos-terraform/tfstate
VOLUME /dcos-terraform/tfstate

ADD empty_ee_license_file.txt /dcos-terraform/empty_ee_license_file.txt

ARG PROVIDER
ENV PROVIDER ${PROVIDER}
COPY main.${PROVIDER}.tf main.tf
COPY variables.${PROVIDER}.tf variables.tf
COPY outputs.tf core_variables.tf ./
RUN terraform init -get=true -get-plugins=true

RUN chmod -R 777 /dcos-terraform ${TF_PLUGIN_CACHE_DIR}

COPY terraform-wrapper.sh /terraform-wrapper.sh
ENTRYPOINT ["/terraform-wrapper.sh"]
