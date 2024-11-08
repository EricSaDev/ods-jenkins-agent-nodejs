FROM image-registry.openshift-image-registry.svc:5000/openshift/jenkins-agent-base:latest
# FROM openshift/ose-jenkins-agent-base:v4.10.0.20230828.162821
ENV __doozer=update BUILD_RELEASE=202308281624.p0.ge654cfb.assembly.stream BUILD_VERSION=v4.10.0 OS_GIT_MAJOR=4 OS_GIT_MINOR=10 OS_GIT_PATCH=0 OS_GIT_TREE_STATE=clean OS_GIT_VERSION=4.10.0-202308281624.p0.ge654cfb.assembly.stream SOURCE_GIT_TREE_STATE=clean __doozer_group=openshift-4.10 __doozer_key=ose-jenkins-agent-nodejs-12 
ENV __doozer=merge OS_GIT_COMMIT=e654cfb OS_GIT_VERSION=4.10.0-202308281624.p0.ge654cfb.assembly.stream-e654cfb SOURCE_DATE_EPOCH=1686109079 SOURCE_GIT_COMMIT=e654cfb2806b535132e605917d8f5430a2606499 SOURCE_GIT_TAG=e654cfb2 SOURCE_GIT_URL=https://github.com/openshift/jenkins 

MAINTAINER OpenShift Developer Services <openshift-dev-services+jenkins@redhat.com>

# Labels consumed by Red Hat build service

ENV NODEJS_VERSION=18 \
    NPM_CONFIG_PREFIX=$HOME/.npm-global \
    PATH=$HOME/node_modules/.bin/:$HOME/.npm-global/bin/:$PATH \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

COPY contrib/bin/configure-agent /usr/local/bin/configure-agent

# Install NodeJS
RUN INSTALL_PKGS="nodejs nodejs-nodemon make gcc-c++" && \
    yum module enable -y nodejs:${NODEJS_VERSION} && \
    yum install -y --setopt=tsflags=nodocs --disableplugin=subscription-manager $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum update -y && \
    yum clean all -y

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001

LABEL \
        com.redhat.component="ose-jenkins-agent-nodejs-12-container" \
        name="openshift/ose-jenkins-agent-nodejs" \
        architecture="x86_64" \
        io.k8s.display-name="Jenkins Agent Nodejs" \
        io.k8s.description="The jenkins agent nodejs image has the nodejs tools on top of the jenkins agent base image." \
        io.openshift.tags="openshift,jenkins,agent,nodejs" \
        maintainer="openshift-dev-services+jenkins@redhat.com" \
        License="GPLv2+" \
        vendor="Red Hat" \
        io.openshift.maintainer.project="OCPBUGS" \
        io.openshift.maintainer.component="Jenkins" \
        release="202308281624.p0.ge654cfb.assembly.stream" \
        io.openshift.build.commit.id="e654cfb2806b535132e605917d8f5430a2606499" \
        io.openshift.build.source-location="https://github.com/openshift/jenkins" \
        io.openshift.build.commit.url="https://github.com/openshift/jenkins/commit/e654cfb2806b535132e605917d8f5430a2606499" \
        version="v4.10.0"
