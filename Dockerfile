FROM atmoz/sftp
ARG NODE_VERSION=10.16.0
WORKDIR /app
RUN apt-get update && apt-get install wget -y \
&& apt-get clean -y \
&& rm -rf \
/var/lib/apt/lists/* \
/var/cache/debconf/* \
/var/log/* \
/var/tmp/* \
/tmp/*
# 安装 nodejs 环境
RUN wget -O node-${NODE_VERSION}.tar.gz https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz  \
&& mkdir ./node-${NODE_VERSION} \
&& tar -zxvf node-${NODE_VERSION}.tar.gz -C ./node-${NODE_VERSION} --strip-components 1 \
&& ln -s /app/node-${NODE_VERSION}/bin/node /usr/bin/node \
&& ln -s /app/node-${NODE_VERSION}/bin/npm /usr/bin/npm \
&& ln -s /app/node-${NODE_VERSION}/bin/npx /usr/bin/npx
# 安装项目依赖
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 80 22

