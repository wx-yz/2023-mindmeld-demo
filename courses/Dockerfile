FROM golang:1.20.2-alpine

WORKDIR /app

COPY go.mod ./
COPY *.go ./

RUN go build -o /main

EXPOSE 8080

USER 10004

CMD [ "/main" ]
