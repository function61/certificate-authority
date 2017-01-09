#!/bin/sh -eu

cfssl gencert -initca ca/ca-csr.json | cfssljson -bare ca/ca -

mv ca/ca.pem ca/ca.crt
mv ca/ca-key.pem ca/ca.key
