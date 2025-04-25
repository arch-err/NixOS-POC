#!CMD: gt
GEN ?= $(error GEN (generation) is not defined. Please set it before running make.)""

disko:
	sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ${GEN}/disko.nix

nix-setup:
	sudo nixos-generate-config --root /mnt
	sudo cp ${GEN}/configuration.nix /mnt/etc/nixos/configuration.nix
	sudo nixos-install


.PHONY: disko nix-setup
