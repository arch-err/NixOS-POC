![NixOS Logo](./assets/logo.png)

# NixOS-POC
This is a POC project for what will hopefully lead to the declarative setup of my daily driver OS.


## Main Goals
- Fully declarative "base setup" (disk partitioning, boot process, etc.). My initial thought is to use Mitchell Hashimotos idea and use a Makefile (or similar script) for this.

## Technologies
- Hyprland
- Nix (duh)
- Plymouth (boot screen)
- ZFS
- Luks

## Commands
```bash
git clone https://github.com/arch-err/NixOS-POC.git && cd NixOS-POC
nix-shell -p gnumake
git pull && make GEN=001 disko
git pull && make GEN=001 nix-setup
```
