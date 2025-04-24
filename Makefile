GEN ?= $(error GEN (generation) is not defined. Please set it before running make.)""

install-disko:
	@echo "Installing disko"
	nix-shell -p disko --run "disko ${GEN}/disko.nix"

test-fzf:
	ls | fzf

.PHONY: install-disko test-fzf
