FROM golang:1.22.3 AS builder

WORKDIR /usr/src/app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /app

FROM scratch

COPY --from=builder /app /bin/app

COPY tracker.db ./

ENTRYPOINT ["/bin/app"]
