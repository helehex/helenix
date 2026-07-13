{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
  ];

  home-manager.users.helehex = {
    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
    programs.git = {
      enable = true;
      settings = {
        user.name = "Max Brylski";
        user.email = "helehex@gmail.com";
        init.defaultBranch = "main";
      };
    };
  };
}
