{ ... }:
{
  home-manager.users.helehex = {
    programs.rofi = {
      enable = true;
      extraConfig = {
        show-icons = true;
        display-drun = "Run: ";
        drun-display-format = "{name}";
      };
      theme = {
        "window" = {
          padding = 8;
          border = 2;
          border-radius = 8;
        };
        "listview" = {
          lines = 20;
          columns = 3;
        };
        "element" = {
          padding = 4;
          spacing = 4;
        };
        "element-icon" = {
          size = 18;
        };
        "element-text" = {
          size = 14;
        };
      };
    };
  };
}
