FROM hashicorp/terraform:0.11.13

ARG PROVIDER
ENV PROVIDER ${PROVIDER}
LABEL name=mesosphere/dcos-terraform-${PROVIDER}
ARG DCOS_TERRAFORM_MODULE_VERSION
ENV DCOS_TERRAFORM_MODULE_VERSION ${DCOS_TERRAFORM_MODULE_VERSION}
LABEL version=${DCOS_TERRAFORM_MODULE_VERSION}

ENV TF_PLUGIN_CACHE_DIR /var/lib/terraform/plugin-cache
RUN mkdir -p ${TF_PLUGIN_CACHE_DIR}

WORKDIR /dcos-terraform
RUN mkdir -p /dcos-terraform/tfstate && chmod 777 /dcos-terraform/tfstate
VOLUME /dcos-terraform/tfstate

COPY empty_ee_license_file.txt /dcos-terraform/empty_ee_license_file.txt
COPY main.${PROVIDER}.tf main.tf
COPY variables.${PROVIDER}.tf variables.tf
COPY dcos_core_variables.${PROVIDER}.tf dcos_core_variables.tf
COPY outputs.tf helper-variables.tf ./
RUN sed -i "s/__DCOS_TERRAFORM_MODULE_VERSION__/${DCOS_TERRAFORM_MODULE_VERSION}/" main.tf
RUN terraform init -get=true -get-plugins=true

RUN chmod -R 777 /dcos-terraform ${TF_PLUGIN_CACHE_DIR}

COPY terraform-wrapper.sh /terraform-wrapper.sh
ENTRYPOINT ["/terraform-wrapper.sh"]
