{ config, pkgs, ... }:
{
  environment.sessionVariables = {
    MODULAR_NVPTX_COMPILER_PATH = "${pkgs.cudaPackages.cuda_nvcc}/bin/ptxas";
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  programs.nix-ld = {
    libraries = [
      config.boot.kernelPackages.nvidiaPackages.legacy_580
    ];
  };
}
