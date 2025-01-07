{
  description = "ponymushama nix-config";

  # define input source
  inputs = {
    # main nixpkgs repository
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # home manager for user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      # keep home manager sync with main nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    # define system config
    nixosConfigurations = {
      # host
      ponymushama = let
        username = "ponymushama";
        specialArgs = {inherit username;};
      in
      nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        # modules
        modules = [
          # system
          ./configuration.nix
          # home
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.ponymushama = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = inputs // specialArgs;
          }
        ];
      };
    };
  };
}
