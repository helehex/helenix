{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
  ];

  home-manager.users.helehex = {
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
