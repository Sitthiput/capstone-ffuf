FROM golang:1.16.4-alpine3.13

COPY main.py requirement.txt ./app /opt/ffuf/ 

RUN apk --no-cache add git \
    && export GO111MODULE=on \
    && go get -u github.com/ffuf/ffuf@v1.3.1 \
    && ln -s /go/bin/ffuf /usr/bin/ffuf \
    && cd /opt/ffuf \
    && wget https://raw.githubusercontent.com/onvio/wordlists/master/words_and_files_top5000.txt \
    && apk update \
    && apk add py-pip \
    && apk --no-cache add bash python3 ca-certificates \
    && chmod +x /opt/ffuf/main.py \
    && pip install -r requirement.txt

WORKDIR /opt/ffuf/
VOLUME /var/reports/

ENTRYPOINT ["./main.py"]