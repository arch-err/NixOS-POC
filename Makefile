GEN ?= $(error GEN (generation) is not defined. Please set it before running make.)""

disko:
	@echo "Disko"
	disko ${GEN}/disko.nix

.PHONY: disko
