.PHONY: containerized-nixos-vm run

containerized-nixos-vm: vm.Dockerfile vm.nix
	docker build -f $< -t $@ .

run: containerized-nixos-vm
	docker run -it --rm --device=/dev/kvm -p 2222:22 $<
