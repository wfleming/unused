FROM ubuntu:16.10
MAINTAINER hello@codeclimate.com

RUN apt-get update -q -y && \
    apt-get install -q -y \
      build-essential exuberant-ctags jq libgmp3-dev silversearcher-ag

RUN adduser --uid 9000 --disabled-password --home /home/unused unused
USER unused

COPY bin/codeclimate-unused /home/unused/bin/
COPY tmp/unused /home/unused/bin/

WORKDIR /home/unused
CMD ["/home/unused/bin/codeclimate-unused"]

