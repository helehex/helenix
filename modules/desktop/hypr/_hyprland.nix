{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprshot
    hyprpaper
    # hyprshutdown
  ];

  programs.hyprland = {
    enable = true;
    # xwayland.enable = true;
  };

  home-manager.users.helehex =
    { config, ... }:
    {
      services.hyprpaper.enable = true;
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
      };
      xdg.configFile = {
        "hypr/hyprland.lua".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/helenix/modules/desktop/hypr/config.lua";
      };
    };
}
