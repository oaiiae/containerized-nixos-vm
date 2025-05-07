FROM alpine AS stage1

RUN apk upgrade && apk add qemu-img e2fsprogs

RUN qemu-img create -f raw disk.raw 1G && \
    mkfs.ext4 -L nixos disk.raw && \
    qemu-img convert -f raw -O qcow2 disk.raw disk.qcow2; \
    rm -f disk.raw

# ---

FROM nixos/nix

RUN nix-channel --add https://nixos.org/channels/nixos-24.11-small && \
    nix-channel --update

COPY vm.nix /
RUN nix-build '<nixpkgs/nixos>' -A vm \
    -I nixpkgs=channel:nixos-24.11-small \
    -I nixos-config=/vm.nix

WORKDIR /result
COPY --from=stage1 disk.qcow2 .

ENV NIX_DISK_IMAGE=disk.qcow2
ENV QEMU_KERNEL_PARAMS="console=ttyS0"
ENV QEMU_NET_OPTS="hostfwd=::22-:22"

EXPOSE 22

ENTRYPOINT [ "./bin/run-nixos-vm" ]
CMD [ "-nographic" ]
