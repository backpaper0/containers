```
docker-compose up -d
```

```
export PROJECT_REGISTRATION_TOKEN=...

docker-compose run --rm -v runner-config:/etc/gitlab-runner runner register \
  --non-interactive \
  --url "http://gitlab/" \
  --registration-token "$PROJECT_REGISTRATION_TOKEN" \
  --executor docker \
  --docker-image alpine:latest
```
