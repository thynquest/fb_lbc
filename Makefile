IMAGE := "github.com/thynquest/fb_lbc"
DOCKER_NAME := "fizzbuzz"
BUILD_NAME := "fizzbuzz"

default:  build

build:
	CGO_ENABLED=0  GOARCH=amd64 go build -mod=vendor -o $(BUILD_NAME) .

test:
	go test -race $(go list ./... | grep -v /vendor/) -v -coverprofile=coverage.out
	go tool cover -func=coverage.out

docker_build:
	docker build -t $(IMAGE)  .

docker_start: docker_build
	docker run -d --name $(DOCKER_NAME) -p 8080:8080  $(IMAGE)

docker_stop:
	docker stop $(DOCKER_NAME)
	docker rm $(DOCKER_NAME)
