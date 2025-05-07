.PHONY: containerized-nixos-vm run run-nokvm

containerized-nixos-vm: vm.Dockerfile vm.nix
	docker build -f $< -t $@ .

run: containerized-nixos-vm
	docker run -it --rm -p 2222:22 --device=/dev/kvm $<

run-nokvm: containerized-nixos-vm
	docker run -it --rm -p 2222:22 $<
