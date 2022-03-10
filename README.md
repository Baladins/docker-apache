# Apache 2 docker image

# Building the image
```
docker build . -t docker-apache:latest
```

# Get image from Github Registry
```
docker pull ghcr.io/baladins/docker-apache:latest
docker tag ghcr.io/baladins/docker-apache:latest docker-apache:latest
```

# Running the image
To run it:

```
docker run -p 8080:8080 docker-apache:latest
```

# Publish the image to Github Registry
```
docker tag docker-apache:latest ghcr.io/baladins/docker-apache:latest
echo $GITHUB_TOKEN | docker login ghcr.io -u $USERNAME --password-stdin
docker push ghcr.io/baladins/docker-apache:latest
```
