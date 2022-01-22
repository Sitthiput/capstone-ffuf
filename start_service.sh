docker build . -t ffuf-service
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -p 8000:8000 ffuf-service