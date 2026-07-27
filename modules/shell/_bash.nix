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
  };

  home-manager.users.helehex = {
    programs.bash = {
      enable = true;

      shellAliases = {
        code = "$\{EDITOR\}";
        helenix = "cd helenix ; code .";
        rebuild = "sudo nixos-rebuild switch --flake ~/helenix";
        save = ". ~/helenix/modules/desktop/hypr/save.sh";
        logout = "save -l";
        reboot = "save -r";
        shutdown = "save -s";
      };

      initExtra = ''
        p () {
          cd ~/projects/$1
          code .
        }
      '';
    };
  };
}
