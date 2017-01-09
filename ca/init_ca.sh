#!/bin/sh -eu

# why ECDSA? => https://blog.cloudflare.com/ecdsa-the-digital-signature-algorithm-of-a-better-internet/

cfssl gencert -initca ca/ca-csr.json | cfssljson -bare ca/ca -

cp ca/ca.pem ca/ca.crt
