FROM golang:alpine as builder
RUN mkdir /project
COPY . /project
WORKDIR /project
RUN CGO_ENABLED=0 GOOS=linux go build -mod vendor -o fizzbuzz .


FROM alpine:3.9

COPY --from=builder /project/fizzbuzz fizzbuzz
RUN chmod +x ./fizzbuzz
EXPOSE 8080
RUN mv ./fizzbuzz /bin/fizzbuzz
ENTRYPOINT [ "fizzbuzz" ]