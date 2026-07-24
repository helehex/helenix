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
        logout = ". ~/helenix/modules/desktop/hypr/save.sh ; hyprctl dispatch 'hl.dsp.exit()'";
        reboot = ". ~/helenix/modules/desktop/hypr/save.sh ; systemctl reboot";
        shutdown = ". ~/helenix/modules/desktop/hypr/save.sh ; systemctl poweroff";
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
