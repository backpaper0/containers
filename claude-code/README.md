# Claude Codeのコンテナイメージ

```bash
docker build -t claude-code .
```

```bash
docker run -it --rm \
  -v claude-code-bashhistory:/home/claude/commandhistory \
  -v claude-code-config:/home/claude/.claude \
  claude-code bash
```

```bash
docker run -it --rm \
  -v claude-code-config:/home/claude/.claude \
  claude-code bash -lc \
  "claude --print --output-format=stream-json --verbose 'こんにちは！'"
```
