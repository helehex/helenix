{ ... }:
{
  home-manager.users.helehex =
    { config, ... }:
    {
      programs.waybar = {
        enable = true;
      };
      xdg.configFile = {
        "waybar/config.jsonc".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/helenix/modules/desktop/waybar/config.jsonc";
        # "waybar/style.css".source = ./style.css;
      };
    };
}
