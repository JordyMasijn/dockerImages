FROM liquibase/liquibase:4.11.0
ARG SOPS_VERSION="3.8.0"

USER root

RUN apt-get update && apt-get install -y wget unzip openssh-client curl

RUN wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -O "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && aws --version

RUN wget https://github.com/getsops/sops/releases/download/v${SOPS_VERSION}/sops_${SOPS_VERSION}_amd64.deb \
    && apt-get install -y ./sops_${SOPS_VERSION}_amd64.deb \
    && sops --version

COPY scripts /root/scripts
RUN ls -l /root/scripts/ \
    && chmod u+x /root/scripts/import-rds-root-ca.sh \
    && /root/scripts/import-rds-root-ca.sh

USER liquibase