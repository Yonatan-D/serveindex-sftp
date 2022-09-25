FROM alpine:3.16.2
MAINTAINER yonatan <yonatan.lin@outlook.com>

# 在一个 RUN 层中完成的步骤
# - 替换为 TUNA 镜像源
# - 修改默认 shell 为 bash
# - 安装 OpenSSH NodeJS
# - 删除通用主机密钥, entrypoint 生成唯一的键
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache --update bash shadow openssh-server-pam openssh-sftp-server nodejs npm && \
    ln -s /usr/sbin/sshd.pam /usr/sbin/sshd && \
    mkdir -p /var/run/sshd && \
    rm -f /etc/ssh/ssh_host_*key* && \
    rm -rf /var/cache/apk/*

# serveIndex and sftp
WORKDIR /opt/serveindex-sftp
COPY package.json .
RUN npm install
COPY sftp/sshd_config /etc/ssh/sshd_config
COPY sftp/create-sftp-user /usr/local/bin/
COPY sftp/entrypoint /usr/local/bin/
COPY docker-entrypoint.sh /usr/local/bin/
COPY app.js .

VOLUME /home

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80 22