IMAGE_NAME = nixos-bat
ZSHRC_SRC = /Users/sarnobat/computers.git/docker/.zshrc

.PHONY: build run clean

build:
	cp $(ZSHRC_SRC) .
	docker build -t $(IMAGE_NAME):latest .

run:
	docker run -it $(IMAGE_NAME):latest

clean:
	docker rmi $(IMAGE_NAME):latest || true
