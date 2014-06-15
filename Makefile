
build/all: build/docksul Dockerfile
	docker build -t denkhaus/consul .

build/docksul: clean
	mkdir -p build && cd build && git clone git@github.com:denkhaus/docksul.git ds
	cd build && go build -o ./docksul ds/docksul.go

.PHONY: clean
clean:
	rm -rf build

run:
	docker run -d -p 8400:8400 -p 8500:8500 -p 8600:53/udp -h v999 --name consul -t denkhaus/consul
