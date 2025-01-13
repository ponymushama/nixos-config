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
    # utils for python
    utils.url = "github:numtide/flake-utils";
    # hyprland
    hyprland.url = "github:hyprwm/Hyprland";
	  ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
  };

  outputs = inputs@{ self, nixpkgs, home-manager, utils, hyprland, ags, ... }: 
    {
      nixosConfigurations = {
        # hostname
        ponymushama = let
          username = "ponymushama";
          specialArgs = {inherit username inputs;};
        in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          # modules
          modules = [
            # system
            ./system/default.nix
            # home
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ponymushama = import ./user/default.nix;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
      };
    }
    # python
    # https://github.com/MordragT/nix-templates/tree/master/python-venv
    // (utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      pythonPackages = pkgs.python3Packages;
    in {
      devShells.default = pkgs.mkShell {
        name = "python-venv";
        venvDir = "./.venv";
        buildInputs = [
          pythonPackages.python
          pythonPackages.venvShellHook
          pythonPackages.numpy
        ];

        postVenvCreation = ''
          unset SOURCE_DATE_EPOCH
          pip install -r requirements.txt
        '';

        postShellHook = ''
          unset SOURCE_DATE_EPOCH
        '';
      };
    }));
}
