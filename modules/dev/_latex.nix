{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    texliveFull
    zathura
    zathuraPkgs.zathura_core
    zathuraPkgs.zathura_pdf_poppler
  ];

  home-manager.users.helehex = {
    programs.zathura.enable = true;
  };
}
