{ pkgs, lib, ... }:
{
  imports = lib.filter (
    n: lib.strings.hasPrefix "_" (baseNameOf n) && lib.strings.hasSuffix ".nix" n
  ) (lib.filesystem.listFilesRecursive ./modules);

  networking.hostName = "aigis";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  home-manager.users.helehex = {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common = {
        default = [ "gtk" ];
        "org.freedesktop.portal.FileChooser" = "gtk";
      };
    };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "thunar.desktop";
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld = {
    enable = true;
  };

  programs.thunar.enable = true;
  programs.steam.enable = true;
  programs.obs-studio.enable = true;
  environment.systemPackages = with pkgs; [
    brave
    audacity
    blender
    gimp
    inkscape
    godot
    freecad-wayland
    easyeffects
    discord
    prismlauncher
  ];

  # services.udisks2.enable = true;
  # home-manager.users.helehex = {
  #   services.udiskie.enable = true;
  # };

  nix.settings = {
    # auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.05";
}
