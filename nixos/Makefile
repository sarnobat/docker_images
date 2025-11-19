IMAGE_NAME = nixos-bat

.PHONY: build run clean

build:
	docker build -t $(IMAGE_NAME):latest .

run:
	docker run -it $(IMAGE_NAME):latest

clean:
	docker rmi $(IMAGE_NAME):latest || true
