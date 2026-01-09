{
  description = "byron's nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake/very-refactor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, niri, ... }: {
    nixosConfigurations.snowmane = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
	./overlays.nix
        ./configuration.nix
	home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;

	  home-manager.users.byron = ./home-manager/home.nix;

	  # Optionally, use home-manager.extraSpecialArgs to pass
	  # arguments to home.nix
	  home-manager.extraSpecialArgs = { inherit inputs; };
	}
      ];
    };
  };
}
