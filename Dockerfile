FROM jenkins/jenkins:lts-jdk17

USER root

RUN apt-get update \
  && apt-get install -y sudo \
  && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN jenkins-plugin-cli --plugins git && \
  apt-get update -y && \
  apt-get install -y software-properties-common && \
  curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
  apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
  apt-get update && apt-get install -y packer && \
  apt-get install -y ca-certificates curl gnupg && \
  apt-get install -y docker.io docker-compose

USER jenkins
