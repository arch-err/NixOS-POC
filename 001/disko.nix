# Standalone Disko configuration for Proof-of-Concept partitioning (Corrected)

{
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
          # Use an attribute set for partitions under GPT
          partitions = {
            # Key 'esp' is an arbitrary name for this partition block
            esp = {
              name = "ESP"; # This sets the GPT partition label
              size = "1G";
              type = "EF00"; # GPT type code for ESP
              content = {
                type = "filesystem";
                format = "vfat";
                # mountpoint is informational here, not strictly needed for standalone run
                mountpoint = "/boot";
              };
            };
            # Key 'luks_part' is an arbitrary name for this partition block
            luks_part = {
              name = "cryptroot"; # This sets the GPT partition label
              size = "100%"; # Rest of disk
              content = {
                type = "luks";
                name = "crypted"; # -> /dev/mapper/crypted
                # Disko will prompt for a password interactively
                settings = {
                  allowDiscards = true;
                  # pbkdf = "argon2id"; # Optional
                };
                # Content inside LUKS
                content = {
                  type = "btrfs";
                  label = "nixos-btrfs"; # Optional label
                  extraArgs = [ "-f" ]; # Force format
                  subvolumes = {
                    # Define subvolumes - no mountpoints needed for standalone run
                    "@" = { };
                    "@home" = { };
                    "@nix" = { };
                    "@log" = { };
                    "@swap" = { };
                  };
                };
              };
            };
          }; # End partitions attribute set
        };
      };
    };
  };
}
