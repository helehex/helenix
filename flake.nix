{
  description = "Helenix Flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    nixosConfigurations.aigis = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./system.nix
        ./hardware.nix
        ./user.nix
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
