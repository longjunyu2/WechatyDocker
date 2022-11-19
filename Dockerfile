FROM node:lts-slim

LABEL maintainer="Junyu Long"

ENV TIMEZONE=Asia/Shanghai \
    WECHATY_PUPPET_WECHAT_PUPPETEER_UOS=true \
    WECHATY_PUPPET_SERVICE_TOKEN="12345678" \
    WECHATY_PUPPET="wechaty-puppet-wechat" \
    WECHATY_LOG="verbose" \
    WECHATY_PUPPET_SERVER_PORT="8080" \
    WECHATY_PUPPET_SERVICE_NO_TLS_INSECURE_SERVER=true \
    PUID=0 \
    GUID=0

EXPOSE 8080/tcp

VOLUME [ "/WechatyData" ]

RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone \
    && apt update \
    && apt dist-upgrade -y \
    && apt install -y libglib2.0-0 libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2  libgbm1 libpango-1.0-0 libcairo2 libasound2 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && npm config set registry https://registry.npmmirror.com/ \
    && npm install -g wechaty wechaty-puppet-wechat

WORKDIR /WechatyData

CMD wechaty gateway --token $WECHATY_PUPPET_SERVICE_TOKEN --port $WECHATY_PUPPET_SERVER_PORT --puppet $WECHATY_PUPPET