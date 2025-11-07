{ ... }:
{
  users.users.helehex = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  home-manager.backupFileExtension = "backup";
  home-manager.users.helehex = {
    home.username = "helehex";
    home.homeDirectory = "/home/helehex";
    home.stateVersion = "25.05";
  };
}
