{
  description = "Helenix Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs: {
    nixosConfigurations.aigis = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./system.nix
        inputs.home-manager.nixosModules.home-manager
        inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
