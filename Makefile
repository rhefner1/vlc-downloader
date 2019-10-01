SHELL := /bin/bash

DOCKER := "docker"
HOST=eu.gcr.io
PROJECT=rhefner-projects/vlc-downloader
VERSION=$(shell git rev-parse --abbrev-ref HEAD | tr '/' '-')

IMAGE=$(HOST)/$(PROJECT)

IMAGE_VERSION=$(IMAGE):$(VERSION)
LATEST_IMAGE=$(IMAGE):latest
RUNTIME_CONTAINER_NAME="vlc-downloader"

# --------------
# --- Docker ---
# --------------
.PHONY: build push convert-video .check-vars

build:
	$(DOCKER) build -t $(IMAGE_VERSION) .

push:
	$(DOCKER) push $(IMAGE_VERSION)

convert-video: build .check-vars
	$(DOCKER) rm -f $(RUNTIME_CONTAINER_NAME) || true
	$(DOCKER) run --name $(RUNTIME_CONTAINER_NAME) -dt $(IMAGE_VERSION)
	$(DOCKER) exec -it $(RUNTIME_CONTAINER_NAME) /app/download_video.sh $(url)
	$(DOCKER) cp $(RUNTIME_CONTAINER_NAME):/home/user/downloaded_video.mkv $(HOME)/Downloads/$(name).mkv
	$(DOCKER) rm -f $(RUNTIME_CONTAINER_NAME)
	echo "Your file is available here: $(HOME)/Downloads/$(name).mkv"

.check-vars:
	@[ "$(url)" ] || ( echo ">> url variable is not set"; exit 1 )
	@[ "$(name)" ] || ( echo ">> name variable is not set"; exit 1 )
