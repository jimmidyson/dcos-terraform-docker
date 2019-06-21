SHELL := /bin/bash
.SHELLFLAGS = -o pipefail -c

DCOS_TERRAFORM_MODULE_VERSION_aws := 0.2.2
DCOS_TERRAFORM_MODULE_VERSION_gcp := 0.2.0
DCOS_TERRAFORM_MODULE_VERSION_azurerm := 0.1.6

BUILD_DATE := $(shell date -u +%Y%m%d%H%M%S)

.PHONY: docker.build
docker.build: $(addprefix docker.build.,aws gcp azurerm)

.PHONY: docker.build.%
docker.build.%: .docker.build.%
	@printf ''

.PRECIOUS: .docker.build.%
.docker.build.%: dcos_core_variables.%.tf Dockerfile main.%.tf outputs.tf terraform-wrapper.sh variables.%.tf
	@docker build --no-cache \
								--build-arg PROVIDER=$* \
								--build-arg DCOS_TERRAFORM_MODULE_VERSION=$(DCOS_TERRAFORM_MODULE_VERSION_$*) \
								-t mesosphere/dcos-terraform-$*:v$(DCOS_TERRAFORM_MODULE_VERSION_$*)-$(BUILD_DATE) .
	@touch $@

.PHONY: docker.push
docker.push: $(addprefix docker.push.,aws gcp azurerm)

.PHONY: docker.push.%
docker.push.%: docker.build.% docker.login
	@docker push mesosphere/dcos-terraform-$*:v$(DCOS_TERRAFORM_MODULE_VERSION_$*)-$(BUILD_DATE)
	@docker tag mesosphere/dcos-terraform-$*:v$(DCOS_TERRAFORM_MODULE_VERSION_$*)-$(BUILD_DATE) mesosphere/dcos-terraform-$*:v$(DCOS_TERRAFORM_MODULE_VERSION_$*)
	@docker push mesosphere/dcos-terraform-$*:v$(DCOS_TERRAFORM_MODULE_VERSION_$*)

.PHONY: docker.login
docker.login:
ifneq ($(and $(DOCKER_USERNAME),$(DOCKER_PASSWORD)),)
	@docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
else
	$(warning Not running docker login: either DOCKER_USERNAME or DOCKER_PASSWORD is unset)
endif

.PHONY: clean
clean:
	@$(RM) .docker.*
