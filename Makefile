ROOT_DIR = $(abspath .)
CONTAINER_TAG = arm_hpc_compiler
DOCKER_FLAG = $(abspath .docker)
DOCKERFILE ?= Dockerfile
ABS_DOCKERFILE = $(abspath $(DOCKERFILE))
ARM_LICENSE_DIR = $(abspath licenses)

.PHONY: docker
docker: $(DOCKER_FLAG)

$(DOCKER_FLAG): $(ABS_DOCKERFILE)
	@touch $@
	docker build -f $(ABS_DOCKERFILE) -t $(CONTAINER_TAG) .

.PHONY: interactive
interactive: $(DOCKER_FLAG)
	@docker run -v $(ROOT_DIR):/code -v $(ARM_LICENSE_DIR):/opt/arm/licenses -it $(CONTAINER_TAG) bash -l

.PHONY: clean
clean:
	@rm -rf $(DOCKER_FLAG)