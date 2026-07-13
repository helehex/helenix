{ config, pkgs, ... }:
{
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelModules = [ "pcspkr" ];

    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  # # Overlay to patch the blacklist package
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     kmod-blacklist-ubuntu = prev.kmod-blacklist-ubuntu.overrideAttrs (old: {
  #       patches = [ ./Dont-blacklist-pcspkr.patch ];
  #     });
  #   })
  # ];
}
