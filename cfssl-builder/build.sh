#!/bin/bash -eu

# Produces static builds of cfssl, cfssljson and cfssl-bundle

read -r -d '' script << EOM
go get -d github.com/cloudflare/cfssl || true \
&& go build --ldflags '-extldflags "-static"' github.com/cloudflare/cfssl/cmd/cfssl \
&& go build --ldflags '-extldflags "-static"' github.com/cloudflare/cfssl/cmd/cfssljson \
&& go build --ldflags '-extldflags "-static"' github.com/cloudflare/cfssl/cmd/cfssl-bundle \
&& cp cfssl cfssljson cfssl-bundle /app
EOM

echo $script | docker run --rm -i -v "$(pwd):/app" golang:1.8 bash
