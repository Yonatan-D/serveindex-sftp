# build node_modules
FROM alpine:3.16.2 AS builder
WORKDIR /temp
RUN  apk add --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/v3.10/main/ npm=10.24.1-r0
COPY package.json .
RUN npm install


FROM alpine:3.16.2
MAINTAINER yonatan <yonatan.lin@outlook.com>

# 在一个 RUN 层中完成的步骤
# - 替换为 TUNA 镜像源
# - 修改默认 shell 为 bash
# - 安装 OpenSSH NodeJS
# - 删除通用主机密钥, entrypoint 生成唯一的键
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache --update bash shadow openssh-server-pam openssh-sftp-server && \
    apk add --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/v3.10/main/ nodejs=10.24.1-r0 && \
    ln -s /usr/sbin/sshd.pam /usr/sbin/sshd && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key* && \
    rm -rf /var/cache/apk/*

# serveIndex and sftp
WORKDIR /opt/serveindex-sftp
COPY sftp/sshd_config /etc/ssh/sshd_config
COPY sftp/create-sftp-user /usr/local/bin/
COPY sftp/entrypoint /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/
COPY app.js .
COPY --from=builder /temp/node_modules node_modules

VOLUME /home

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80 22
