#!/bin/sh -eu

cfssl gencert \
	-ca=ca/ca.crt -ca-key=ca/ca.key -config=ca/ca-config.json \
	-profile=server \
	server-signer/server-profile.json | cfssljson -bare server-signer/signed/server

mv server-signer/signed/server.pem server-signer/signed/server.crt
mv server-signer/signed/server-key.pem server-signer/signed/server.key
rm server-signer/signed/server.csr
