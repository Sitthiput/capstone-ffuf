docker build . -t ffuf-service
# docker run --rm -it \
#     -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd)/app/reports:/code/app/report \
#     --env DIND_HOST_PATH_PROJECT=$(pwd) -p 8000:8000 ffuf-service

docker run -v $(pwd)/app/reports:/code/app/reports -p 8000:8000 ffuf-service