#!CMD: gt
GEN ?= $(error GEN (generation) is not defined. Please set it before running make.)""

disko:
	sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ${GEN}/disko.nix

nix-setup:


.PHONY: disko nix-setup
