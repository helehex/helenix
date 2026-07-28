{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    nil
    nixd
    pixi
    lua
    lean
  ];

  home-manager.users.helehex = {
    programs.zed-editor = {
      enable = true;
    };

    home.sessionVariables = {
      EDITOR = "zeditor";
      VISUAL = "zeditor";
    };
  };
}
