{ pkgs, self, ... }:
{
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprshot
    hyprpaper
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
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
      home.file."/helenix/.luarc.json".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/hypr/.luarc.json";
    };
}
