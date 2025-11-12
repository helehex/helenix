{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    rustc
    rustup
    nil
    nixd
    pixi
  ];

  home-manager.users.helehex = {
    programs.zed-editor = {
      enable = true;
    };
  };
}
