#!/bin/bash

docker run -it --rm \
  --network claude-code-network \
  -e http_proxy='http://proxy:3128' \
  -e https_proxy='http://proxy:3128' \
  -e no_proxy='127.0.0.1,localhost,192.168.' \
  -e GITEA_CLAUDE_USERNAME \
  -e GITEA_CLAUDE_PASSWORD \
  -e GITEA_CLAUDE_TOKEN \
  -v claude-code-config:/home/claude/.claude \
  -v claude-code-workspaces:/workspaces \
  -v claude-code-dotconfig:/home/claude/.config \
  claude-code bash

