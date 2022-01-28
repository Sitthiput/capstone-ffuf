FROM docker

WORKDIR /code

RUN apk add --no-cache python3 py3-pip

COPY . .
    
RUN pip3 install -r requirement.txt

EXPOSE 8000

CMD ["sh", "docker_start.sh"]
