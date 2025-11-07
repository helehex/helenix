{ ... }:
{
  home-manager.users.helehex = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
