Foreword
--------

You obviously cannot use this directly, but this repository serves to others as an example for
setting up a modern certificate authority. I wanted to publish this because this is a complex subject
and there is not a lot of simple information written for achieving this. This is based on Cloudflare's
[cfssl](https://github.com/cloudflare/cfssl) which seems to be the current best-of-breed and simple and
easy tool for this. However - cfssl is not that well documented.


Usage
-----

function61.com's certificate authority is implemented as a Docker image.

The setup is somewhat unconventional because the scripts that you see in this repository are decoupled
from the Docker image - the image only contains the cfssl binaries.

This is because you are going to need to mount at least the CA's private key into the container anyway,
and this project is currently intended to be used as a manual tool anyway, so in this case it's an added
bonus that the scripts and config are mounted directly from the repository as well
(=> edit-run doesn't require image rebuild).

Enter it by running (while your current directory is this repository):

```
$ docker run -it --rm -v "$(pwd):/app" fn61/certificate-authority
```


Initialize CA
-------------

You have to do this only once during your root certificate's lifetime (currently configured at 20 years).

```
$ ca/init_ca.sh
```

You'll end up with these new files:

- `ca/ca.crt` - this is your CA certificate ("root certificate")
- `ca/ca.key` - this is the private key to the CA certificate. Protect this at all costs.

You have to import this root certificate to all of your devices that you want to trust
accessing services backed by the server certs that you'll be signing with this project.

You can import this certificate in Windows by:

- clicking on the .crt file
- Install Certificate
- Storate Location: Local Machine
- Place all certificates in the following store: Trusted Root Certification Authorities


Sign a server certificate
-------------------------

```
$ server-signer/sign.sh
```

You'll end up with these new files:

- `server-signer/signed/server.crt` - the new server certificate
- `server-signer/signed/server.key` - the private key to the certificate. Protect this.


File layout
-----------

- `server-signer/sign.sh` => for signing server certificates.


Roadmap
-------

- Make the server-signer take hostnames from the command line.
- Implement intermediate CA:s, so the root CA cert can be kept totally offline.


Links
-----

- [How do SSL certificates work](https://function61.com/blog/2017/how-do-ssl-certificates-work/)
- Why ECDSA? Read this
  [Cloudflare blog entry](https://blog.cloudflare.com/ecdsa-the-digital-signature-algorithm-of-a-better-internet/)
- Only intermediate certificates have to be bundled: [1](http://security.stackexchange.com/questions/65332/ssl-root-certificate-optional),
  [2](http://stackoverflow.com/questions/20409534/how-does-an-ssl-certificate-chain-bundle-work)
