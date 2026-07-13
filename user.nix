{ ... }:
{
  users.users.helehex = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      # "input"
    ];
  };
  home-manager.backupFileExtension = "backup";
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.helehex = {
    home.username = "helehex";
    home.homeDirectory = "/home/helehex";
    home.stateVersion = "25.05";
  };
}
