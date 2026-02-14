FROM debian

ARG UID=1000
ARG GID=1000

# パッケージマネージャで必要なものをインストール
RUN <<_EOF_
apt update
apt install -y --no-install-recommends \
  curl \
  ca-certificates \
  git \
  jq \
  vim
rm -fr /var/lib/apt/lists/*
_EOF_

# ユーザーを作成
RUN <<_EOF_
groupadd -g "${GID}" claude
useradd -u "${UID}" -g "${GID}" -m -s /bin/bash claude
_EOF_

USER claude

WORKDIR /home/claude

SHELL ["/bin/bash", "-c"]

ENV CLAUDE_CONFIG_DIR='/home/claude/.claude'
ENV TZ='Asia/Tokyo'

# miseをインストール
RUN <<_EOF_
curl https://mise.run/bash | sh
eval "$(./.local/bin/mise activate bash)"
_EOF_

# Claude Codeをインストール
RUN <<_EOF_
mkdir ./.claude
curl -fsSL https://claude.ai/install.sh | bash
_EOF_

WORKDIR /home/claude/src
