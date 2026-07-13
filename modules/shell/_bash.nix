{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    fastfetch
    psmisc
    jq
    ffmpeg
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      beep = "echo boop";
      code = "$\{EDITOR\}";
      helenix = "cd helenix ; code .";
      rebuild = "sudo nixos-rebuild switch --flake ~/helenix";
      reboot = ". ~/helenix/modules/desktop/hypr/graceful-shutdown.sh ; command reboot";
      shutdown = ". ~/helenix/modules/desktop/hypr/graceful-shutdown.sh ; command shutdown";
    };
  };

  # TODO: move this flake into /projects, move shell aliases to home manager
  home-manager.users.helehex = {
    programs.bash = {
      enable = true;
      initExtra = ''
        p () {
          cd ~/projects/$1
          code .
        }
      '';
    };
  };
}
