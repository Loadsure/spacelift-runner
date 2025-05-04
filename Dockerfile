####################################
# Base image                       #
####################################
FROM public.ecr.aws/spacelift/runner-terraform:latest AS spacelift

ARG TERRAFORM_VERSION=1.11.4
ARG TFLINT_VERSION=0.56.0
ARG TRIVY_VERSION=0.62.0

WORKDIR /tmp

RUN curl -O -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && chmod +x terraform

RUN curl -O -L https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip \
  && unzip tflint_linux_amd64.zip \
  && chmod +x tflint

RUN curl -O -L https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz \
  && tar -zxf trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz\
  && chmod +x trivy

####################################
# Arifact for the Spacelift Runner #
####################################
FROM alpine:3.21 AS artifact

RUN apk -U upgrade && apk add --no-cache \
  bash=5.2.37-r0 \
  jq=1.7.1-r0 \
  tzdata=2025b-r0 \
  git=2.47.2-r0 \
  curl=8.12.1-r1 \
  ca-certificates=20241121-r1 \
  libstdc++=14.2.0-r4

COPY --from=spacelift /tmp/terraform /bin/terraform
COPY --from=spacelift /tmp/tflint /bin/tflint
COPY --from=spacelift /tmp/trivy /bin/trivy

LABEL org.opencontainers.image.source=https://github.com/Loadsure/spacelift-runner

RUN echo "hosts: files dns" > /etc/nsswitch.conf && \
  adduser --disabled-password --uid=1983 spacelift && \
  ln -s /bin/terraform /usr/local/bin/terraform

USER spacelift