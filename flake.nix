{
  description = "ponymushama nix-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, utils, ... }: let
    # Python 开发环境配置
    pythonEnv = system: let
      pkgs = import nixpkgs {inherit system;};
      pythonPackages = pkgs.python3Packages;
    in {
      default = pkgs.mkShell {
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
    };
  in {
    # 系统配置
    nixosConfigurations = {
      ponymushama = let
        username = "ponymushama";
        specialArgs = {inherit username;};
      in
      nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ponymushama = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = inputs // specialArgs;
          }
        ];
      };
    };

    # 开发环境
    devShells = utils.lib.eachDefaultSystem (system: pythonEnv system);
  };
}
