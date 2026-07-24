{ pkgs, self, ... }:
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
      "-s"
      "-d"
      "-m"
      "last"
    ];
    settings = {
      skip_selection = true;
      widget.clock = {
        format = "%A %H:%M";
      };
      appearance = {
        greeting_msg = "•  ●  🌻  ●  •";
      };
    };
  };
}
