FROM alpine:3.5

# latest build in cfssl.org is 1.2 release, and it has broken initca function
# which does not respect the expiry from the CSR, so I had to build custom static releases

# we need also openssl for generating pkcs12 formatted files for client certs

RUN apk add --no-cache curl openssl \
	&& curl --fail -s -L -o /bin/cfssl https://s3.amazonaws.com/files.function61.com/infrastructure-dl/cfssl-custom-builds/2017-01-09-eadcfcf-static/cfssl \
	&& curl --fail -s -L -o /bin/cfssljson https://s3.amazonaws.com/files.function61.com/infrastructure-dl/cfssl-custom-builds/2017-01-09-eadcfcf-static/cfssljson \
	&& curl --fail -s -L -o /bin/cfssl-bundle https://s3.amazonaws.com/files.function61.com/infrastructure-dl/cfssl-custom-builds/2017-01-09-eadcfcf-static/cfssl-bundle \
	&& chmod +x /bin/cfssl /bin/cfssljson /bin/cfssl-bundle

WORKDIR /app

CMD sh
