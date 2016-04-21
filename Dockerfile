FROM node:4.2-slim

RUN groupadd user && useradd --create-home --home-dir /home/user -g user user

ENV REACT_SOURCE /usr/src/react
WORKDIR $REACT_SOURCE

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && apt-get install -y git \
    && apt-get install -y graphicsmagick \
    && apt-get install -y imagemagick \ 
    && rm -rf /var/lib/apt/lists/*

RUN buildDeps=' \
        gcc \
        make \
        python \
    ' \
  && set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
  && git clone https://github.com/twreporter/plate.git plate \
    && cd plate \
    && cp -rf . .. \
    && cd .. \
    && rm -rf plate \
    && npm install

EXPOSE 3000
CMD ["npm", "start"]
