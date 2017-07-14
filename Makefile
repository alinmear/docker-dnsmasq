NAME = alinmear/docker-dnsmasq:testing

all: build-no-cache run tests clean
all-fast: build run tests clean
all-local: build run tests

build-no-cache:
	docker build --no-cache -t $(NAME) .

build:
	docker build -t $(NAME) .

run:
	docker network create \
	--subnet=191.168.3.0/24 \
	dnsmasq

	sleep 5

	docker run -d --name dnsmasq \
	-v "`pwd`/test/config":/tmp/docker-dnsmasq \
	--net=dnsmasq \
	--ip=191.168.3.254 \
	-h dnsmasq.mydomain.loc -t $(NAME)

	sleep 15

	docker run -d --name dnsmasq-without-config \
	-h dnsmasq.mydomain.loc -t $(NAME)

	sleep 15

tests:
	./test/bats/bin/bats test/tests.bats

clean:
	-docker rm -f \
	dnsmasq \
	dnsmasq-without-config

	-docker network remove dnsmasq
