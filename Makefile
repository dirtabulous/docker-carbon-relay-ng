.PHONY: all

all: goenvtemplator-amd64
	docker build -t quay.io/adfin/k8-carbon-replay-ng .

goenvtemplator-amd64:
	wget https://github.com/tnozicka/goenvtemplator/releases/download/v1.0.0/goenvtemplator-amd64 -O $@
	chmod +x $@
