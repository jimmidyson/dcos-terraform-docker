SHELL := /bin/bash
.SHELLFLAGS = -o pipefail -c

DCOS_TERRAFORM_MODULE_VERSION_aws := 0.2.1
DCOS_TERRAFORM_MODULE_VERSION_gcp := 0.1.5

.PHONY: docker.build
docker.build: $(addprefix docker.build.,aws gcp)

.PHONY: docker.build.%
docker.build.%: .docker.build.%
	@printf ''

.PRECIOUS: .docker.build.%
.docker.build.%: dcos_core_variables.%.tf Dockerfile main.%.tf outputs.tf terraform-wrapper.sh variables.%.tf
	@docker build --build-arg PROVIDER=$* \
								--build-arg DCOS_TERRAFORM_MODULE_VERSION=$(DCOS_TERRAFORM_MODULE_VERSION_$*) \
								-t mesosphere/dcos-terraform-$*:v$(DCOS_TERRAFORM_MODULE_VERSION_$*) .
	@touch $@

.PHONY: docker.push
docker.push: $(addprefix docker.push.,aws gcp)

.PHONY: docker.push.%
docker.push.%: docker.build.%
ifdef DOCKER_USERNAME
ifdef DOCKER_PASSWORD
	@docker login -u $(DOCKER_USERNAME) -p $(DOCKER_PASSWORD)
endif
endif
	@docker push mesosphere/dcos-terraform-$*:v$(DCOS_TERRAFORM_MODULE_VERSION_$*)

.PHONY: clean
clean:
	@$(RM) .docker.*
