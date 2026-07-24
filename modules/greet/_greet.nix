{ pkgs, ... }:
{
  services.displayManager.sessionPackages = [
    pkgs.hyprland
  ];

  services.greetd = {
    enable = true;
    settings.default_session.user = "greeter";
  };

  programs.regreet = {
    enable = true;
    cageArgs = [
      "-m"
      "last"
    ];
  };
}
