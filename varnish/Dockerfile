FROM golang:1.16 as exporter
ENV GO111MODULE=on

ARG VARNISH_PROMETHEUS_EXPORTER_VSN=1.5.2

RUN go get github.com/jonnenauha/prometheus_varnish_exporter@$VARNISH_PROMETHEUS_EXPORTER_VSN
#RUN go build

FROM varnish:7.0.1

COPY --from=exporter /go/bin/prometheus_varnish_exporter /usr/local/bin
COPY start.sh /start.sh
COPY default.vcl /etc/varnish/default.vcl

EXPOSE 9131
ENTRYPOINT ["/bin/bash", "/start.sh"]
