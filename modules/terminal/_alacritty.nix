{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alacritty
  ];

  home-manager.users.helehex = {
    programs.alacritty.enable = true;
  };
}
