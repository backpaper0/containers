# GitLab

## 起動

Docker Composeで起動。

```bash
docker compose up -d
```

起動は割と時間がかかる。

## 管理者でログイン

管理者のユーザー名は`root`。
パスワードは`password`。

<details>
<summary>パスワードを明示的に設定しない場合</summary>
パスワードは明示的に設定しているが、そうしない場合は自動生成されて確認用に`/etc/gitlab/initial_root_password`へファイル出力される。
その場合、次のコマンドでパスワードを確認する。

```bash
docker compose exec gitlab cat /etc/gitlab/initial_root_password
```
</details>

GitLabを開いてログインする。

- http://localhost:9080/

## GitLab Runnerを登録する

次のページでトークンを確認する。

- http://localhost:9080/admin/runners

トークンを環境変数`RUNNER_TOKEN`へ設定する。

```bash
export RUNNER_TOKEN=...
```

次のコマンドで登録する(`--index=2`に対してもコマンドを実行すること)。

```bash
docker compose exec --index=1 runner gitlab-runner register \
  --non-interactive \
  --url "http://gitlab:9080/" \
  --registration-token "$RUNNER_TOKEN" \
  --executor docker \
  --docker-image alpine:latest
```

トークンを確認した画面で、ランナーが登録されていることが確認できる。

### ランナーの設定を編集する

ランナーのコンテナ内から`config.toml`を取り出して、編集してからコンテナ内へ戻す。

まず次のコマンドで`config.toml`を取り出す。

```bash
seq 2|xargs -I{} docker compose cp --index={} runner:/etc/gitlab-runner/config.toml config{}.toml
```

次にテキストエディターで編集する。

- `[[runners]]`以下に`clone_url = "http://gitlab:9080"`を追加する
- `[runners.docker]`以下に`network_mode = 'gitlab_default'`を追加する(`gitlab_default`はDocker Composeのネットワーク)

次のコマンドで`config.toml`を戻す。

```bash
seq 2|xargs -I{} docker compose cp --index={} config{}.toml runner:/etc/gitlab-runner/config.toml
```

最後にランナーをリスタートさせる。

```bash
docker compose restart runner
```

これで設定変更が反映され、CIができるようになった。

