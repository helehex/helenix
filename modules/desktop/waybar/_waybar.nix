{ ... }:
{
  home-manager.users.helehex =
    { config, ... }:
    {
      programs.waybar = {
        enable = true;
        style = ''
          * {
              color: @base0A;
          }
        '';
      };
      xdg.configFile = {
        "waybar/config.jsonc".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/helenix/modules/desktop/waybar/config.jsonc";
        # "waybar/style.css".source =
        #   config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/helenix/modules/desktop/waybar/style.css";
      };
    };
}
