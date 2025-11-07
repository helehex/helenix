{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./user.nix
    ./options/boot.nix
    ./options/nvidia.nix
    ./options/stylix.nix
    ./options/pipewire.nix
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

  # xdg.mime.defaultApplications = {
  #   "inode/directory" = [ "dolphin.desktop" ];
  # };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "hyprland";

  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;
  programs.nix-ld.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.dolphin

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
