# serveindex-sftp

Use SFTP to upload files, and the Internet browser to download files

## Preview

my tools download page: https://tool.yonatan.cn/

## Usage

```bash
docker run \
    --name=serveindex-sftp \
    --restart=always \
    -p 9022:22 \
    -p 9080:80 \
    -e SS_ARGS=test:123:::files \
    -dt yont/serveindex-sftp:1.1
```

download： http://localhost:9080/

upload：sftp://localhost:9022 (username: test , password: 123)

file path: /home/test/files (so you can use `-v /home/your_dir:/home/test/files`)

## Build

```bash
$ docker build -t serveindex-sftp .
$ docker-compose up -d
```

## Thank

- [atmoz/sftp](https://github.com/atmoz/sftp)
- [expressjs/serve-index](https://github.com/expressjs/serve-index)
