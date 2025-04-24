GEN ?= $(error GEN (generation) is not defined. Please set it before running make.)""

install-disko:
	@echo "Installing disko"
	nix-shell -p disko --run "disko ${GEN}/disko.nix"

.PHONY: install-disko
