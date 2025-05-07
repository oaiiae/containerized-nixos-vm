# Containerized NixOS VM

This repository contains a proof-of-concept demonstrating how to run a NixOS virtual machine inside a container.

## But why?

There is probably very little situations where doing this is actually a good idea but hey, it's funny enough :neckbeard: and still good to know. The only use case I had for this was for running a single node Nomad cluster in a devcontainers environment.

## How-to

### Requirements

- Docker
- ideally a KVM-capable environment

### Build the image

```console
$ make
```

### Run the image

```console
$ make run

...

<<< Welcome to NixOS 24.11.717743.d30125e98b05 (x86_64) - ttyS0 >>>

Run 'nixos-help' for the NixOS manual.

nixos login:
```

The username / password is `vscode / vscode`.
