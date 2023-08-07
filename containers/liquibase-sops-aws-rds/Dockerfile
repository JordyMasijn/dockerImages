FROM liquibase/liquibase:4.23.0

ARG SOPS_VERSION="3.7.3"

USER root

RUN wget https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops_${SOPS_VERSION}_amd64.deb \
    && apt-get install -y ./sops_${SOPS_VERSION}_amd64.deb \
    && apt-get update && apt-get install -y openssh-client awscli curl \
    && sops --version

COPY ./scripts /root/scripts
RUN ls -l /root/scripts/ \
    && chmod u+x /root/scripts/import-rds-root-ca.sh \ 
    && /root/scripts/import-rds-root-ca.sh

USER liquibase