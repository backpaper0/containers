起動。

```
docker-compose up -d
```

コンテナイメージのビルド、プッシュ。
動作確認用の`Dockerfile`を置いてある。

```
echo secret|docker login localhost:5000 -u example --password-stdin
docker build -t localhost:5000/hello demo
docker push localhost:5000/hello
```

消してみる。

```
docker rmi localhost:5000/hello
```

動かしてみる。
`pull`がめちゃくちゃ速いけどそういうもの？

```
docker run --rm localhost:5000/hello
```

