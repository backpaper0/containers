# Claude Codeのコンテナイメージ

```bash
docker build -t claude-code .
```

```bash
docker run -it --rm \
  -v claude-code-config:/home/claude/.claude \
  claude-code bash
```

```bash
docker run -it --rm \
  -v claude-code-config:/home/claude/.claude \
  claude-code bash -lc \
  "claude --print --output-format=stream-json --verbose 'こんにちは！'"
```

## ネットワークを制限する

```bash
docker network create --internal claude-code-network
```

``bash
docker run -d --name claude-code-proxy \
  -v $PWD/proxy/squid.conf:/etc/squid/conf.d/_squid.conf:ro \
  -v $PWD/proxy/whitelist.txt:/etc/squid/whitelist.txt:ro \
  ubuntu/squid
```

```bash
docker network connect claude-code-network claude-code-proxy
```

```bash
docker run -it --rm \
  --network claude-code-network \
  -e http_proxy='http://claude-code-proxy:3128' \
  -e https_proxy='http://claude-code-proxy:3128' \
  -e no_proxy='127.0.0.1,localhost,192.168.' \
  -v claude-code-config:/home/claude/.claude \
  claude-code bash
```

```bash
docker run -it --rm \
  --network claude-code-network \
  -e http_proxy='http://claude-code-proxy:3128' \
  -e https_proxy='http://claude-code-proxy:3128' \
  -v claude-code-config:/home/claude/.claude \
  claude-code bash -lc \
  "claude --print --output-format=stream-json --verbose 'こんにちは！'"
```
