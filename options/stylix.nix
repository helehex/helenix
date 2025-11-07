{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/default-dark.yaml";
    image = ./../wallpapers/wallpaper.png;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 30;
    };

    fonts = {
      serif = config.stylix.fonts.sansSerif;
      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };
      monospace = {
        package = pkgs.nerd-fonts.geist-mono;
        name = "GeistMono Nerd Font";
      };
      emoji = config.stylix.fonts.monospace;
    };
  };

  # home-manager.users.helehex = {
  # };
}
