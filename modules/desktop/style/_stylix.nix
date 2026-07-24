{
  pkgs,
  config,
  self,
  ...
}:
{
  stylix = {
    enable = true;
    base16Scheme = "${self}/modules/desktop/style/theme.yaml";
    image = "${self}/modules/desktop/wallpapers/fine.png";
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
      sizes = {
        applications = 10;
      };
    };
  };

  # # TODO: should be unecessary
  # home-manager.users.helehex = {
  #   home.pointerCursor.enable = true;
  # };
}
