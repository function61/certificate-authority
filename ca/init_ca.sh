#!/bin/sh -eu

cfssl gencert -initca ca/ca-csr.json | cfssljson -bare ca/ca -

cp ca/ca.pem ca/ca.crt
