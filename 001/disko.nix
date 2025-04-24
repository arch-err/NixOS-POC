# ./disko-poc.nix
# Standalone Disko configuration for Proof-of-Concept partitioning

{
    # No function arguments like { lib, pkgs, ... } needed for standalone run
    disko.devices = {
        disk = {
            # !!! --- DANGER --- !!!
            # !!! DOUBLE-CHECK THIS IS YOUR TARGET DRIVE BEFORE RUNNING !!!
            # Use `lsblk` in the installer to confirm.
            # Using /dev/disk/by-id/... is safer if available.
            main_nvme = {
                type = "disk";
                device = "/dev/vda"; # <--- ADJUST IF NEEDED! VERIFY!
                content = {
                    type = "gpt";
                    partitions = [
                        {
                            # EFI System Partition (ESP)
                            name = "ESP";
                            size = "1G";
                            type = "EF00";
                            content = {
                                type = "filesystem";
                                format = "vfat";
                                mountpoint = "/boot"; # Mountpoint is informational here
                            };
                        }
                        {
                            # Main partition for LUKS
                            name = "cryptroot";
                            size = "100%"; # Rest of disk
                            content = {
                                type = "luks";
                                name = "crypted"; # -> /dev/mapper/crypted
                                # Disko will prompt for a password interactively
                                settings = {
                                    # Allow TRIM commands (check NVMe support/security implications)
                                    allowDiscards = true;
                                    # You could add PBKDF settings here if desired
                                    # pbkdf = "argon2id";
                                };
                                # Content inside LUKS
                                content = {
                                    type = "btrfs";
                                    label = "nixos-btrfs"; # Optional label
                                    extraArgs = [ "-f" ]; # Force format
                                    subvolumes = {
                                        # Define subvolumes - no mountpoints needed for standalone run
                                        # Disko just creates them on the BTRFS filesystem.
                                        "@" = { };
                                        "@home" = { };
                                        "@nix" = { };
                                        "@log" = { };
                                        "@swap" = { };
                                    };
                                    # BTRFS mount options aren't applied here, but are good documentation
                                    # mountOptions = [ "compress=zstd", "noatime", "ssd" ];
                                };
                            };
                        }
                    ];
                };
            };
        };
        # No filesystem nodes needed for standalone partitioning/formatting
    };
}
