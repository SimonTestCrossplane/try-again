FROM golang:1.20-alpine AS build
ADD . /src
WORKDIR /src
RUN go get -d -v -t
RUN GOOS=linux GOARCH=amd64 go build -v -o try-again

FROM alpine:3.17.3
EXPOSE 8080
CMD ["try-again"]
ENV VERSION 1.1.4
COPY --from=build /src/try-again /usr/local/bin/try-again
RUN chmod +x /usr/local/bin/try-again
