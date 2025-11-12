{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./user.nix
    ./options/boot.nix
    ./options/nvidia.nix
    ./options/pipewire.nix
    ./options/stylix.nix
    ./options/gdm.nix
    ./options/hyprland.nix
    ./options/waybar.nix
    ./options/rofi.nix
    ./options/bash.nix
    ./options/alacritty.nix
    ./options/git.nix
    ./options/zed.nix
  ];

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

  programs.thunar.enable = true;
  programs.steam.enable = true;
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    brave
    audacity
    blender
    gimp
    inkscape
    godot
    freecad-wayland
    hyprshot
    easyeffects
    discord
  ];

  services.udisks2.enable = true;

  environment.variables = {
    EDITOR = "zeditor";
    VISUAL = "zeditor";
  };

  nix.settings = {
    # auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.05";
}
