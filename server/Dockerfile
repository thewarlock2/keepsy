# build stage
FROM golang:1.26-alpine AS builder

WORKDIR /app

# install build dependencies
RUN apk add --no-cache gcc musl-dev

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o main ./cmd/server/main.go

# final stage
FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/main .
COPY --from=builder /app/migrations ./migrations
COPY --from=builder /app/start.sh ./start.sh
RUN chmod +x ./main ./start.sh

EXPOSE 8080

CMD ["./start.sh"]
