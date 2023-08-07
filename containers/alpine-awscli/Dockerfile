FROM alpine:3.18

ARG DOCKER_USER="appuser"

USER root

RUN apk add --no-cache zip unzip jq sed aws-cli
RUN adduser -D -g "${DOCKER_USER}" "${DOCKER_USER}"

USER ${DOCKER_USER}