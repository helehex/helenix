{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zed-editor
    nil
    nixd
    pixi
  ];

  home-manager.users.helehex = {
    programs.zed-editor.enable = true;
  };
}
