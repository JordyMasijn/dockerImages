FROM debian:12-slim

ARG DOCKER_USER="appuser"

RUN apt-get update && apt-get install -y awscli zip unzip jq

RUN useradd -ms "${DOCKER_USER}"

USER "${DOCKER_USER}"