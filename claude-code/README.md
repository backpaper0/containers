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

```bash
docker run -d --name proxy \
  -v $PWD/proxy/squid.conf:/etc/squid/conf.d/_squid.conf:ro \
  -v $PWD/proxy/whitelist.txt:/etc/squid/whitelist.txt:ro \
  ubuntu/squid
```

```bash
docker network connect claude-code-network proxy
```

```bash
docker run -it --rm \
  --network claude-code-network \
  -e http_proxy='http://proxy:3128' \
  -e https_proxy='http://proxy:3128' \
  -e no_proxy='127.0.0.1,localhost,192.168.' \
  -v claude-code-config:/home/claude/.claude \
  claude-code bash
```

```bash
docker run -it --rm \
  --network claude-code-network \
  -e http_proxy='http://proxy:3128' \
  -e https_proxy='http://proxy:3128' \
  -v claude-code-config:/home/claude/.claude \
  claude-code bash -lc \
  "claude --print --output-format=stream-json --verbose 'こんにちは！'"
```

## Giteaを立ててプルリクエストでClaude Codeの成果を受け入れられるようにする

```bash
docker run -d --name gitea \
  -p 3000:3000 \
  -v gitea-data:/data \
  -e TZ='Asia/Tokyo' \
  docker.gitea.com/gitea 
```

ネットワークを制限している場合は次のコマンドも実行すること。

```bash
docker network connect claude-code-network claude-code-gitea
```

Claude Codeコンテナーの起動コマンドは次の通り。

```bash
docker run -it --rm \
  --network claude-code-network \
  -e http_proxy='http://proxy:3128' \
  -e https_proxy='http://proxy:3128' \
  -e no_proxy='127.0.0.1,localhost,192.168.' \
  -e GITEA_CLAUDE_USERNAME \
  -e GITEA_CLAUDE_PASSWORD \
  -e GITEA_CLAUDE_TOKEN \
  -v claude-code-config:/home/claude/.claude \
  claude-code bash
```

