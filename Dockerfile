FROM alpine:latest
MAINTAINER Vladimir Kozlovski <inbox@vladkozlovski.com>

ENV CONSUL_REGISTRATOR_VERSION 6

ADD https://github.com/gliderlabs/registrator/archive/v${CONSUL_REGISTRATOR_VERSION}.zip /tmp/consul-registrator.zip

RUN apk add --update -t build-deps go git mercurial && \
    unzip /tmp/consul-registrator.zip -d /tmp && \
    mkdir -p /go/src/github.com/gliderlabs/registrator && \
    mv /tmp/registrator-${CONSUL_REGISTRATOR_VERSION}/* /go/src/github.com/gliderlabs/registrator/ && \
    cd /go/src/github.com/gliderlabs/registrator && \
    export GOPATH=/go && \
    go get && \
    go build -ldflags "-X main.Version=$(cat VERSION)" -o /bin/registrator && \
    rm /tmp/consul-registrator.zip && \
    cd /bin && \
    rm -rf /go && \
    apk del --purge build-deps

ENTRYPOINT ["/bin/registrator"]
