# serveindex-sftp

atmoz/sftp 镜像的基础上增加 serve-index 应用, 满足自己使用 sftp 上传文件, 网页浏览器查看下载文件



## 构建

```bash
docker build -t serveindex-sftp .
```

## 使用

```bash
docker run --name <容器名称> \
  --restart always
  -v <宿主机目录>:/home/<用户名>/ \
  -p <宿主机web端口>:80 \
  -p <宿主机sftp端口>:22 \
  -d serveindex-sftp:<版本> \
  <用户名>:<密码>:::<目录>
```

## 示例

> 浏览器访问： http://localhost:9080/
>
> FTP工具访问：sftp://localhost:9022  用户名: docs  密码: 123
>
> 文件映射在宿主机的 `/home/docs/files` 目录下

```bash
docker run --name serveindex-sftp --restart always -v /home/docs:/home/docs -p 9080:80 -p 9022:22 -d serveindex-sftp docs:123:::files
```



## 感谢

- [atmoz/sftp](https://github.com/atmoz/sftp)
- [expressjs/serve-index](https://github.com/expressjs/serve-index)
- [nodejs/docker-node](https://github.com/nodejs/docker-node)