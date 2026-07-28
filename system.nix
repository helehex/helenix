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
    };
  };

  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
  programs.thunar.enable = true;
  programs.steam.enable = true;
  programs.obs-studio.enable = true;
  services.udisks2.enable = true;
  environment.systemPackages = with pkgs; [
    udiskie
    brave
    audacity
    blender
    gimp
    inkscape
    godot
    freecad-wayland
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "25.05";
}
