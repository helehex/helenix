{ pkgs, ... }:
{
  environment.variables = {
    EDITOR = "zeditor";
    VISUAL = "zeditor";
  };

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
  };
}
