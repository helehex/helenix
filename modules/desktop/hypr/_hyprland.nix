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
      services.hyprpaper = {
        enable = true;
        settings = {
          splash = false;
          wallpaper = [
            {
              fit_mode = "cover";
              monitor = "";
              path = "${config.home.homeDirectory}/helenix/modules/desktop/wallpapers/wallpaper.png";
            }
          ];
        };
      };
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
