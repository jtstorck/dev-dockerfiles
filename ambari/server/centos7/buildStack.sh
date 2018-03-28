#!/bin/bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in#answer-246128
BUILD_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$BUILD_DIR" && \
if [ -z "$1" ]; then
  docker build --no-cache -t ambari .
else
  docker build --build-arg repo="$1" -t ambari .
fi && \
cd "$BUILD_DIR/../../../squid/centos7/" && docker build -t squid . && \
cd "$BUILD_DIR/../../../kdc/centos7/" && docker build -t kdc . && \
cd "$BUILD_DIR/../../../openssh-server/ubuntu/" && docker build -t ubuntu-ssh . && \
cd "$BUILD_DIR/../../../openssh-server/centos7/" && docker build -t centos7-ssh . && \
cd "$BUILD_DIR/../../gateway/ubuntu/" && docker build -t gateway . && \
cd "$BUILD_DIR/../../agent/root/centos7/" && docker build -t root-ambari-agent . && \
cd "$BUILD_DIR/../../agent/non-root/centos7" && \
if [ -z "$1" ]; then
  docker build -t non-root-ambari-agent .
else
  docker build --build-arg repo="$1" -t non-root-ambari-agent .
fi && \
cd "$BUILD_DIR/../../ranger/non-root/centos7/" && docker build -t non-root-ranger . && \
cd "$BUILD_DIR/../../solr/ubuntu/" && docker build -t ranger-solr .
