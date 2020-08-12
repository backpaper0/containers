```
docker build -t mkdocs .
```

```
docker run --rm -p 8000:8000 -v $(pwd):/workspace mkdocs
```

```
docker run --rm -v $(pwd):/workspace mkdocs build

serve -s site
```

