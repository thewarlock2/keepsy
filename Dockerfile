# Multi-stage Dockerfile for Keepsy Server (Root Context)
FROM golang:1.26-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache gcc musl-dev

# Copy Go module files and download dependencies
COPY server/go.mod server/go.sum ./server/
WORKDIR /app/server
RUN go mod download

# Copy source code
WORKDIR /app
COPY server/ ./server/

# Build binary
WORKDIR /app/server
RUN go build -o main ./cmd/server/main.go

# Final stage
FROM alpine:latest

WORKDIR /root/

COPY --from=builder /app/server/main .
COPY --from=builder /app/server/migrations ./migrations
COPY --from=builder /app/server/start.sh ./start.sh
RUN chmod +x ./main ./start.sh

EXPOSE 8080

CMD ["./start.sh"]
