NAME = alinmear/docker-dhcpd:testing

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
	dhcpd

	sleep 5

	docker run -d --name dhcpd \
	-v "`pwd`/test/config":/tmp/docker-dhcpd \
	--net=dhcpd \
	--ip=191.168.3.254 \
	-h dhcpd.mydomain.loc -t $(NAME)

	sleep 15

	docker run -d --name dhcpd-without-config \
	-h dhcpd.mydomain.loc -t $(NAME)

	sleep 15

tests:
	./test/bats/bin/bats test/tests.bats

clean:
	-docker rm -f \
	dhcpd \
	dhcpd-without-config

	-docker network remove dhcpd
