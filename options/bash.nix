{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    fastfetch
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      beep = "echo boop";
      code = "$\{EDITOR\}";
      helenix-rebuild = "sudo nixos-rebuild switch --flake ~/helenix";
    };
  };
}
