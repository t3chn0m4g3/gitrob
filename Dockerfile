FROM golang:1.14.1-alpine3.11 as build

RUN apk add --no-cache git perl-utils zip
RUN go get github.com/golang/dep/cmd/dep

WORKDIR /go/src/github.com/codeEmitter/gitrob
COPY Gopkg.lock Gopkg.toml ./
RUN dep ensure -vendor-only

COPY . .
RUN go build

FROM golang:1.14.1-alpine3.11 as deploy
COPY --from=build /go/src/github.com/codeEmitter/gitrob/gitrob \
     /go/src/github.com/codeEmitter/gitrob/filesignatures.json \
     /go/src/github.com/codeEmitter/gitrob/contentsignatures.json \
    ./
ENTRYPOINT ["./gitrob"]