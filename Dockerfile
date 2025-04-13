# Start from the official Go image as a build stage with Go 1.24
FROM golang:1.24-bookworm AS builder

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum files first for better cache utilization
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -o jausenschlecka .

# Use a small alpine image for the runtime
FROM alpine:latest

# Install ca-certificates for HTTPS
RUN apk --no-cache add ca-certificates

# Set the working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/jausenschlecka .

# Copy the public directory with HTML files
COPY --from=builder /app/public ./public

# Expose the port the app runs on
EXPOSE 8091

# Run the binary
CMD ["./jausenschlecka"]