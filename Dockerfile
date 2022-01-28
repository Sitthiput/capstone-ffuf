# FROM docker

# WORKDIR /code

# RUN apk add --no-cache python3 py3-pip

# COPY . .
    
# RUN pip3 install -r requirement.txt

# EXPOSE 8000

# CMD ["sh", "docker_start.sh"]


FROM ubuntu:20.04

WORKDIR /code

RUN apt-get update

RUN apt-get -y install wget git python3 python3-pip

RUN wget https://go.dev/dl/go1.17.6.linux-amd64.tar.gz

RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.6.linux-amd64.tar.gz

COPY . .

RUN git clone https://github.com/ffuf/ffuf ; cd ffuf ; /usr/local/go/bin/go get ; /usr/local/go/bin/go build

RUN mv ./ffuf/ffuf /code/app/ffuf/ffuf

RUN pip3 install -r requirement.txt

EXPOSE 8000

CMD ["python3", "main.py"]